# Модуль базы данных

import asyncdispatch, json
import allographer/connection as conn
import allographer/query_builder
import allographer/schema_builder
import std/options
import tables

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
    var info : JsonNode
    var jinfo = getInfoJson()    
    
    if jinfo.isSome:
        info = jinfo.get()
    else:
        info = %*{"db_version": 1}

    info["db_version"] = newJInt(version)

    var updateQuery = newJObject()
    updateQuery["info"] = info

    rdb
        .table("db_info")
        .insert(updateQuery)
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
    if jinfo.isSome:        
        var dbVersion = jinfo.get["db_version"].getInt()

        # Идёт по словарю и вызывает по номеру обновления
        # До тех пор пока они не закончатся
        while true:
            let updateProc = updateMap.getOrDefault(dbVersion)                    
            if updateProc == nil:
                return
        
            updateProc(rdb)
            dbVersion += 1
            setDbVersion(dbVersion)
    else:
        const firstVersion = 1
        setDbVersion(firstVersion)
        let updateProc = updateMap.getOrDefault(firstVersion)
        if updateProc == nil:
            return
        
        updateProc(rdb)

# Возвращает все устройства
proc getAllDevices*() =
    discard

# Возвращает устройство по идентификатору
proc getDeviceById*(id:int) =
    discard