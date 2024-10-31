# Основной модуль
# Инициализирует базу данных
# Загружает сценарии сбора и устройства из базы
# Создаёт сценарии сбора для сборщика данных и добавляет их в обработку
# Запускает сервер обработки внешних запросов
# Запускает webapi для веб интерфейса
# Отслеживает изменения: web, серзвера запросов и вносит изменения в базу и управляет сбором

import print

import json
import database/database as db
import database/db_entities as dbe
import collector/collector as col
import common/ids/device_model_types as dmt
import common/schedule

type
    # Устройство с полной информацией для сбора
    DeviceWithFullInfo = ref object
        device:dbe.DbDevice
        deviceType:dbe.DbDeviceType
        route:dbe.DbRoute

# Загружает сценарии сбора и устройства из базы
# Возвращает сценарии сбора
proc loadScenarios() : seq[col.CollectorScenario] =
    # Загружает устройства
    let dbDevices = db.getDevices()
    var deviceSeq = newSeq[DeviceWithFullInfo](dbDevices.len)
    for dbDevice in dbDevices:
        let route = db.getRouteByDeviceId(dbDevice.id)
        let deviceType = db.getDeviceTypeByModelId(dbDevice.model_type_id)
        let devFull = DeviceWithFullInfo(
            device:dbDevice, 
            deviceType:deviceType,
            route:route
        )

        deviceSeq.add(devFull)    
    
    # Загружает сценарии сбора
    let dbScenarios = db.getCollectorScenarios()
    var scenarios = newSeq[col.CollectorScenario]()
    for dbScenario in dbScenarios:
        let settings = json.newJObject()
        var devices = newSeq[col.CollectorDevice]()        
        let device = col.newCollectorDevice(
            1, dmt.DeviceModelType.UniversalSpodes, settings
        )
        devices.add(device)        
        scenarios.add(col.addCollectorScenario(
                dbScenario.id, BaseSchedule(), devices
            )
        )
    
    return scenarios

proc main() =
    # Инициализирует базу данных
    db.init()
    # Загружает сценарии сбора    
    let scenarios = loadScenarios()
    #for scenario in scenarios:
    #    scenario.start()

    print scenarios
    # Запускает выполнение сценариев


when isMainModule:
    main()