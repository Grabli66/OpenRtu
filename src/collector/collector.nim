# Модуль сборщика данных
# Позволяет управлять сценариями сбора: добавлять, удалять, запускать, останавливать
# Позволяет вручную выполнять задания: запускать, останавливать

import asyncdispatch
import tables
import ../database/database as db
import ../database/db_entities as dbe
import collector_types as cot
import ../common/schedule

type
    # Сценарий сбора
    CollectorScenario* = ref object
        # Идентификатор сценария
        id:int
        # Устройства сбора
        devices:seq[CollectorDevice]
        schedule:BaseSchedule

    # Данные по устройству сбора
    CollectorDevice* = ref object
        # Идентификатор устройства
        id:int

var scenarioId = 0
var scenarios = newTable[int, CollectorScenario]()

# Создаёт новое устройство сбора
proc newCollectorDevice*() : CollectorDevice =
    return CollectorDevice()

# Создаёт сценарий сбора
proc createCollectorScenario*(schedule:BaseSchedule, devices:seq[CollectorDevice]) : CollectorScenario =
    let scenario = CollectorScenario(
        id:scenarioId
    )
    scenarioId += 1
    scenarios[scenario.id] = scenario
    return scenario

# Запускает сценарий сбора
proc start*(this:CollectorScenario) =
    # Получает прикладной драйвер устройства
    # Устанавливает канал до устройства
    # Создаёт задания по устройству
    # Передаёт задания в прикладной драйвер
    discard

# Останавливает сценарий
proc stop*(this:CollectorScenario) =
    # Получает прикладной драйвер устройства
    # Получает задания по сценарию
    # Передаёт драйверу задания для остановки
    discard

# Удаляет сценарий сбора
proc remove*(this:CollectorScenario) =
    this.stop()
    scenarios.del(this.id)

# type
#     # Устройство с полной информацией для сбора
#     DeviceWithFullInfo = ref object
#         device:dbe.DbDevice
#         deviceType:dbe.DbDeviceType
#         route:dbe.DbRoute

#     # Сценарий сбора данных
#     CollectorScenario = ref object
#         # Идентификатор сценария сбора
#         id : int
#         # Расписание сценария
#         schedule : BaseSchedule
#         # Устройства по которым нужно собирать данные
#         devices : DeviceWithFullInfo

# # Возвращает устройства с заполненной информацией
# proc getDevicesWithFullInfo() : seq[DeviceWithFullInfo] =
#     let devices = db.getAllDevices()    
#     var deviceSeq = newSeq[DeviceWithFullInfo](devices.len)
#     for device in devices:        
#         let route = db.getRouteByDeviceId(device.id)
#         let deviceType = db.getDeviceTypeByModelId(device.model_type_id)
#         let devFull = DeviceWithFullInfo(
#             device:device, 
#             deviceType:deviceType,
#             route:route
#         )

#         deviceSeq.add(devFull)
    
#     return deviceSeq

# # Создаёт задачу сбора для прикладного драйвера
# proc createCollectorTask() : CollectorTask =
#     discard

# # Запускает исполнение задания сбора
# proc startCollectorTask(task : CollectorTask) =
#     discard

# # Запускает обработку сценариев сбора
# proc startExecuteScenarios(scenarios:seq[CollectorScenario]) =
#     for scenario in scenarios:
#         # Проверяет нужно ли запускать сценарий
#         discard

#         # Создаёт задание сбора
#         #let collectorTask = createCollectorTask()
#         # Запускает задание
#         #startCollectorTask(collectorTask)

# # Загружает сценарии и запускает работу автосбора
# proc loadAndStart*() =
#     # Загружает из базы: устройства, типы устройств, маршруты    
#     let devices = getDevicesWithFullInfo()

#     # Загружает сценарии сбора из базы
#     let dbCollectScenarios = db.getCollectScenarios()
    
#     # Создаёт сценарии сбора
#     #let collectScenarios = createCollectScenarios(dbCollectScenarios, devices)

#     # Запускает сбор по сценарию сбора
#     #startExecuteScenarios(collectScenarios)

# # Добавляет сценарий сбора
# proc addCollectScenario*() =
#     discard

# # Останавливает работу сценария
# proc stopCollectScenario*() =
#     discard

# # Удаляет сценарий сбора
# proc removeCollectScenario*() = 
#     discard

# # Исполняет внешнее задание
# proc executeExternalTask*() : Future[void] =
#     discard