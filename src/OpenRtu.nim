# Основной модуль
# Инициализирует базу данных
# Загружает сценарии сбора и устройства из базы
# Создаёт сценарии сбора для сборщика данных и добавляет их в обработку
# Запускает сервер обработки внешних запросов
# Запускает webapi для веб интерфейса
# Отслеживает изменения: web, серзвера запросов и вносит изменения в базу и управляет сбором

import print

import options
import json
import database/idatabase as dbi
import database/database_factory as dbf
import database/db_entities as dbe
import database/type_ids
import collector/collector as col
import common/schedule

type
    # Устройство с полной информацией для сбора
    DeviceWithFullInfo = ref object
        device:dbe.DbDevice
        deviceType:dbe.DbDeviceType
        route:dbe.DbRoute

# Загружает сценарии сбора и устройства из базы
# Возвращает сценарии сбора
proc loadScenarios(db:IDatabase) : seq[col.CollectorScenario] =
    # Загружает устройства
    let dbDevices = db.getDevices()
    var deviceSeq = newSeq[DeviceWithFullInfo]()
    for dbDevice in dbDevices:
        let route = db.getRouteByDeviceId(dbDevice.id)
        if route.isNone:
            continue

        let deviceType = db.getDeviceTypeByModelId(dbDevice.modelTypeId)
        if deviceType.isNone:
            continue

        let devFull = DeviceWithFullInfo(
            device:dbDevice, 
            deviceType:deviceType.get(),
            route:route.get()
        )

        deviceSeq.add(devFull)    
    
    # Загружает сценарии сбора    
    let dbScenarios = db.getCollectorScenarios()
    var scenarios = newSeq[col.CollectorScenario]()
    for dbScenario in dbScenarios:
        discard
    
    return scenarios

proc main() =
    # Инициализирует базу данных    
    let db = dbf.get()
    # Загружает сценарии сбора    
    let scenarios = loadScenarios(db)
    #for scenario in scenarios:
    #    scenario.start()

    print scenarios
    # Запускает выполнение сценариев


when isMainModule:
    main()