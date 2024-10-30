# Основной модуль
# Инициализирует базу данных
# Загружает сценарии сбора и устройства из базы
# Создаёт сценарии сбора для сборщика данных и добавляет их в обработку
# Запускает сервер обработки внешних запросов
# Запускает webapi для веб интерфейса
# Отслеживает изменения: web, серзвера запросов и вносит изменения в базу и управляет сбором

import database/database as db
import database/db_entities as dbe
import collector/collector as col

type
    # Устройство с полной информацией для сбора
    DeviceWithFullInfo = ref object
        device:dbe.DbDevice
        deviceType:dbe.DbDeviceType
        route:dbe.DbRoute

# Загружает сценарии сбора и устройства из базы
# Возвращает сценарии сбора
proc loadScenarios() : seq[col.CollectorScenario] =
    let devices = db.getAllDevices()    
    var deviceSeq = newSeq[DeviceWithFullInfo](devices.len)
    for device in devices:
        let route = db.getRouteByDeviceId(device.id)
        let deviceType = db.getDeviceTypeByModelId(device.model_type_id)
        let devFull = DeviceWithFullInfo(
            device:device, 
            deviceType:deviceType,
            route:route
        )

        deviceSeq.add(devFull)

proc main() =
    # Инициализирует базу данных
    db.init()
    # Загружает сценарии сбора    
    let scenarios = loadScenarios()
    for scenario in scenarios:
        scenario.start()

    # Запускает выполнение сценариев


when isMainModule:
    main()