# Модуль сборщика данных (собиратель)
# Позволяет управлять сценариями сбора: добавлять, удалять, запускать, останавливать
# Позволяет вручную выполнять задания: запускать, останавливать

import asyncdispatch
import json
import tables

import collector_types as cot
import ../common/schedule
import ../database/type_ids

type
    # Сценарий сбора
    CollectorScenario* = ref object
        # Идентификатор сценария
        id:int
        # Расписание сценария
        schedule:BaseSchedule
        # Устройства сбора
        devices:seq[CollectorDevice]

    # Данные по устройству сбора
    CollectorDevice* = ref object
        # Идентификатор устройства
        id:int
        # Идентификатор устройства
        deviceType:DeviceModelType
        # Настройки устройства
        settings:JsonNode    

# Сценарии сбора
var scenarios = newTable[int, CollectorScenario]()

# Идентификатор задания
var collectorTaskId = 0

# Возвращает следующий идентификатор задания собирателя
template nextTaskId*(): int =
    collectorTaskId += 1
    collectorTaskId

# Создаёт новое устройство сбора
proc newCollectorDevice*(id:int, deviceType:DeviceModelType, settings:JsonNode) : CollectorDevice =
    return CollectorDevice(
        id: id,
        deviceType: deviceType,
        settings: settings
    )

# Создаёт и добавляет сценарий сбора в словарь сценариев
# Возвращает созданный сценарий
proc addCollectorScenario*(
            # Идентификатор сценария
            id:int,
            # Расписание сценария
            schedule:BaseSchedule,
            # Опрашиваемые устройства 
            devices:seq[CollectorDevice]) : CollectorScenario =    
    let scenario = CollectorScenario(id:id)    
    scenarios[scenario.id] = scenario
    return scenario

# Возвращает сценарий сбора по идентификатору
proc getScenarioById*(id:int) : CollectorScenario =
    discard

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

# Добавляет устройство в сценарий сбора
proc addDevice*(this:CollectorScenario, device:CollectorDevice) =
    discard

# Обновляет информацию по устройству
# Сопоставление произойдёт по id устройства
proc updateDevice*(this:CollectorScenario, device:CollectorDevice) =
    discard

# Удавляет устройство по идентификатору
proc removeDeviceById*(this:CollectorScenario, id:int) =
    discard

# Запускает внешнее задания
# Возвращает результат выолнения задания
proc executeExternalTask*(task:cot.CollectorTask) : Future[void] =
    discard