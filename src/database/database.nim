# Модуль базы данных

import asyncdispatch, json
import allographer/connection as conn
import allographer/query_builder
import allographer/schema_builder
import std/options
import std/strutils
import tables
import db_entities as dbe

import ./updates/update_v1 as up1

let rdb = conn.dbOpen(Sqlite3, "openrtu.db")
# Таблица с обновлениями
let updateMap = newTable[int, proc(ctx:SqliteConnections):void]()

# Возвращает объект Json с информацие о базе данных
proc getInfoJson*() : Option[JsonNode] =
    # Получает информацию о базе данных
    let res = rdb
        .select("info")
        .table("db_info")
        .first()
        .waitFor

    if res.isSome:
        let info = res.get["info"].getStr
        let jinfo = json.parseJson(info)
        return some(jinfo)

    return none(JsonNode)

# Обновляет номер версии базы
proc setDbVersion(version:int) =        
    var jinfo = getInfoJson()    
    
    if jinfo.isSome:  
        var info = jinfo.get()
        info["db_version"] = newJInt(version)
        var updateQuery = newJObject()
        updateQuery["info"] = jinfo.get()

        rdb
            .table("db_info")
            .update(updateQuery)
            .waitFor             
    else:
        var insertQuery = newJObject()
        insertQuery["info"] = %*{"db_version": version} 
        rdb
            .table("db_info")
            .insert(insertQuery)
            .waitFor                    

# Инициализирует базу данных
proc init*() =    
    updateMap[1] = up1.updateV1

    # Создаёт таблицу если её нет для хранения информации о базе данных
    rdb.create([
        table("db_info", [
            Column.string("info")
        ]) 
    ])

    let jinfo = getInfoJson()
    var dbVersion = 1

    if jinfo.isSome:
        dbVersion = jinfo.get["db_version"].getInt()        
    
    # Идёт по словарю и вызывает по номеру обновления
    # До тех пор пока они не закончатся
    while true:
        let updateProc = updateMap.getOrDefault(dbVersion)
        if updateProc == nil:
            return
    
        updateProc(rdb)
        dbVersion += 1
        setDbVersion(dbVersion)

# Добавляет устройство
proc addDevice*(dev:DbDevice):DbDevice =
    let id = rdb
        .table(dbe.deviceTableName)
        .insertId(%*{"model_type_id":dev.model_type_id,"settings":dev.settings})
        .waitFor()
    
    result = dev
    result.id = parseInt(id)

# Возвращает все устройства
proc getAllDevices*():seq[dbe.DbDevice] =
    let devices = rdb
        .select("id", "model_type_id", "settings")
        .table(dbe.deviceTableName)
        .get()
        .orm(dbe.DbDevice)
        .waitFor()
    return devices

# Возвращает устройство по идентификатору
proc getDeviceById*(id:int):Option[dbe.DbDevice] =
    let device = rdb
        .select("id", "model_type_id", "settings")
        .table(dbe.deviceTableName)
        .where("id","=",id)
        .first()        
        .orm(dbe.DbDevice)
        .waitFor()
    return device

# Удаляет устройство по идентификатору
proc removeDeviceById*(id:int) =
    rdb
        .table(dbe.deviceTableName)
        .delete(id)
        .waitFor()

# Возвращает тип устройства по идентификатору модели
proc getDeviceTypeByModelId*(id:int) : DbDeviceType =
    discard

# Добавляет маршрут для устройства
proc addRouteByDeviceId*(deviceId:int, route:DbRoute) : DbRoute =
    discard

# Возвращает маршрут по идентификатору устройства
proc getRouteByDeviceId*(id:int) : DbRoute =
    discard

# Удаляет маршрут по идентификатору устройства
proc removeRouteByDeviceId*(id:int) =
    discard

# Возвращает сценарии сбора
proc getCollectScenarios*() : seq[DbCollectScenario] =
    discard