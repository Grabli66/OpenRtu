# Модуль сборщика данных

import asyncdispatch
import ../database/database as db
import ../database/db_entities as dbe


type
    # Устройство с полной информацией для сбора
    DeviceWithFullInfo = ref object
        device:dbe.DbDevice
        deviceType:dbe.DbDeviceType
        route:dbe.DbRoute

# Возвращает устройства с заполненной информацией
proc getDevicesWithFullInfo() : seq[DeviceWithFullInfo] =
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
    
    return deviceSeq

# Запускает обработку сценариев сбора
proc startExecuteScenarios(scenarios:seq[DbCollectScenario], devices:seq[DeviceWithFullInfo]) =
    discard

# Запускает работу автосбора
proc start*() =
    # Загружает из базы: устройства, типы устройств, маршруты    
    let devices = getDevicesWithFullInfo()

    # Загружает сценарии сбора из базы
    let collectScenarios = db.getCollectScenarios()

    # Запускает сбор по сценарию сбора
    startExecuteScenarios(collectScenarios, devices)

# Исполняет внешнее задание
proc executeExternalTask*() : Future[void] =
    discard