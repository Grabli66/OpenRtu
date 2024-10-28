# Модуль сборщика данных
# Принцип работы:
# 

import asyncdispatch
import ../database/database as db
import ../database/db_entities as dbe
import collector_types as cot
import ../common/schedule

type
    # Устройство с полной информацией для сбора
    DeviceWithFullInfo = ref object
        device:dbe.DbDevice
        deviceType:dbe.DbDeviceType
        route:dbe.DbRoute

    # Сценарий сбора данных
    CollectorScenario = ref object
        # Идентификатор сценария сбора
        id : int
        # Расписание сценария
        schedule : BaseSchedule
        # Устройства по которым нужно собирать данные
        devices : DeviceWithFullInfo

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

# Создаёт задачу сбора для прикладного драйвера
proc createCollectorTask() : CollectorTask =
    discard

# Запускает исполнение задания сбора
proc startCollectorTask(task : CollectorTask) =
    discard

# Запускает обработку сценариев сбора
proc startExecuteScenarios(scenarios:seq[CollectorScenario]) =
    for scenario in scenarios:
        # Проверяет нужно ли запускать сценарий
        

        # Создаёт задание сбора
        let collectorTask = createCollectorTask()
        # Запускает задание
        startCollectorTask(collectorTask)

# Загружает сценарии и запускает работу автосбора
proc loadAndStart*() =
    # Загружает из базы: устройства, типы устройств, маршруты    
    let devices = getDevicesWithFullInfo()

    # Загружает сценарии сбора из базы
    let dbCollectScenarios = db.getCollectScenarios()
    
    # Создаёт сценарии сбора
    #let collectScenarios = createCollectScenarios(dbCollectScenarios, devices)

    # Запускает сбор по сценарию сбора
    #startExecuteScenarios(collectScenarios)

# Добавляет сценарий сбора
proc addCollectScenario*() =
    discard

# Останавливает работу сценария
proc stopCollectScenario*() =
    discard

# Удаляет сценарий сбора
proc removeCollectScenario*() = 
    discard

# Исполняет внешнее задание
proc executeExternalTask*() : Future[void] =
    discard