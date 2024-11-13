# Модуль сборщика данных (собиратель)
# Позволяет управлять сценариями сбора: добавлять, удалять, запускать, останавливать
# Позволяет вручную выполнять задания: запускать, останавливать

import asyncdispatch
import tables
import options

import print

import ../common/schedule
import ../common/ikey
import ./types/collector_device as cod
import ./types/collector_task as cot
import ./types/itransport_driver as itd
import ./driver_factory as drf

type
    # Транспортный драйвер с устройствами которые будут через него опрашиваться
    TransportWithDevices = ref object
        # Транспортный драйвер
        driver:ITransportDriver
        # Устройства
        devices:seq[CollectorDevice]

    # Сценарий сбора
    CollectorScenario* = ref object
        # Идентификатор сценария
        id:int
        # Расписание сценария
        schedule:BaseSchedule
        # Устройства сбора
        devices:seq[CollectorDevice]

# Сценарии сбора
var scenarios = newTable[int, CollectorScenario]()

# Идентификатор задания
var collectorTaskId = 0

# Возвращает следующий идентификатор задания собирателя
template nextTaskId*(): int =
    collectorTaskId += 1
    collectorTaskId

# Создаёт и добавляет сценарий сбора в словарь сценариев
# Возвращает созданный сценарий
proc addCollectorScenario*(
            # Идентификатор сценария
            id:int,
            # Расписание сценария
            schedule:BaseSchedule,
            # Опрашиваемые устройства 
            devices:seq[cod.CollectorDevice]) : CollectorScenario =    
    let scenario = CollectorScenario(
        id:id,
        schedule:schedule,
        devices:devices
    )    
    scenarios[scenario.id] = scenario
    return scenario

# Возвращает сценарий сбора по идентификатору
proc getScenarioById*(id:int) : CollectorScenario =
    discard

# Запускает сценарий сбора
proc start*(this:CollectorScenario) =   
    var deviceByRoute = newTable[IKey[CollectorDeviceRoute], TransportWithDevices]()    

    # Группирует устройства по маршрутам
    for device in this.devices:
        for route in device.routes:
            let transportDriver = drf.getTransportDriver(route.routeType)
            if transportDriver.isSome:
                let key = transportDriver.get.getKey(route)
                var transDevice = if deviceByRoute.hasKey(key):
                    deviceByRoute[key]
                else:
                    TransportWithDevices(
                       driver:transportDriver.get,
                       devices: @[]
                    )

                transDevice.devices.add(device)
                deviceByRoute[key] = transDevice
    
    for key, transDevice in deviceByRoute:
        let channel = transDevice.driver.openChannel(key.obj).waitFor

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