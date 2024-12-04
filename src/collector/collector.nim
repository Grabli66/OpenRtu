# Модуль сборщика данных (собиратель)
# Позволяет управлять сценариями сбора: добавлять, удалять, запускать, останавливать
# Позволяет вручную выполнять задания: запускать, останавливать

import asyncdispatch
import tables
import options
import sequtils

import print

import ../common/ischedule
import ../common/interval
import ../common/ikey
import ./types/collector_device
import ./types/collector_scenario
import ./types/collector_parameter
import ./types/collector_task as cot
import ./types/iapplayer_driver as iad
import ./types/iprotocol_driver as ipd
import ./types/itransport_driver as itd
import ../common/type_ids as tid
import ./driver_factory as drf

type
    # Ключ для группировки устройств
    DeviceChannelKey = object
        # Модель устройства
        deviceType:DeviceModelType
        # Протокол устройства
        protocolType:ProtocolType
        # Ключ транспортного канала
        transportKey:IKey[CollectorDeviceRoute]

    # Транспортный драйвер с устройствами которые будут через него опрашиваться
    TransportWithDevices = object
        # Маршрут до устройств
        route:CollectorDeviceRoute
        # Транспортный драйвер
        driver:ITransportDriver
        # Устройства
        devices:seq[CollectorDevice] 

    # Цепочка драйверов:прикладной+канальный+транспорт
    DriverChain = object
        # Прикладной драйвер
        applayer:IAppLayerDriver
        # Протокольный драйвер
        protocol:IProtocolDriver
        # Транспортный канал
        transport:ITransportChannel


# Сценарии сбора
var scenarios = newTable[int, Option[CollectorScenario]]()

# Идентификатор задания
var collectorTaskId = 0

# Возвращает следующий идентификатор задания собирателя
template nextTaskId(): int =
    collectorTaskId += 1
    collectorTaskId

# Создаёт цепочку драйверов
proc newDriverChain(
        applayer:IAppLayerDriver,
        protocol:IProtocolDriver,
        transport:ITransportChannel):DriverChain =
    discard

# Обрабатывает задания собирателя
proc processTasks(
        this:DriverChain,
        tasks:seq[CollectorTask]) =
    discard

# Возвращает ключ по которому группируются устройство
# Тип устройства + протокол устройства + ключ канала
proc getDeviceChannelKey(
            deviceType:DeviceModelType,
            protocolType:ProtocolType,
            transportKey:IKey[CollectorDeviceRoute]
        ):IKey[DeviceChannelKey] =
    discard

# Создаёт и добавляет сценарий сбора в словарь сценариев
# Возвращает созданный сценарий
proc addCollectorScenario*(scenario:CollectorScenario) =        
    scenarios[scenario.id] = some(scenario)

# Возвращает сценарий сбора по идентификатору
proc getScenarioById*(id:int) : Option[CollectorScenario] =
    return scenarios.getOrDefault(id, none(CollectorScenario))

# Запускает сценарий сбора
proc start*(this:CollectorScenario) =
    var deviceByRoute = newTable[IKey[DeviceChannelKey], TransportWithDevices]()    

    # Группирует устройства по маршрутам
    for device in this.devices:
        for route in device.routes:
            let transportDriver = drf.getTransportDriver(route.routeType)
            if transportDriver.isSome:
                let transportKey = transportDriver.get.getKey(route)
                let key = getDeviceChannelKey(
                    device.deviceType, device.protocolType, transportKey)                
                var transDevice = if deviceByRoute.hasKey(key):
                    deviceByRoute[key]
                else:
                    TransportWithDevices(
                       route:route,
                       driver:transportDriver.get,
                       devices: @[]
                    )

                transDevice.devices.add(device)
                deviceByRoute[key] = transDevice
    
    # Создаёт информацию о заданиях
    var tasksData = newSeq[CollectorTaskData]()
    for param in this.measureParameters:
        let task = cot.newCollectorDataTask(param, none(Interval))
        tasksData.add(task)
        
    for key, transDevice in deviceByRoute:                       
        # Открывает канал
        let channel = transDevice.driver.openChannel(transDevice.route).waitFor

        # Создаёт цепочку драйверов: прикладной+канальный+транспорт
        let deviceKey = key.obj
        let applayer = drf.getAppLayerDriver(deviceKey.deviceType)
        let protocol = drf.getProtocolDriver(deviceKey.protocolType)

        let driverChain = newDriverChain(
            applayer = applayer,
            protocol = protocol,
            transport = channel
        )

        # Создаёт задания для выполнения
        let tasks = tasksData.mapIt(cot.newCollectorTask(nextTaskId(), it))

        # Обрабатывает задания
        driverChain.processTasks(tasks)

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