# Общие типы относящиеся к автосбору
# Для передачи между модулями

import asyncdispatch
import json
import std/hashes

import ../common/type_ids as tid
import ../common/interval

type    
    # Типы задания собирателя
    TaskKind* {.pure.} = enum
        # Запрос измеренных данных устройства
        DataRequest = 0, 
        # Запрос событий устройства
        EventRequest = 1

    # Маршрут устройства
    CollectorDeviceRoute* = ref object
        # Тип маршрута
        routeType:int
        # Настройки маршрута
        routeSettings:JsonNode

    # Данные по устройству сбора
    CollectorDevice* = ref object
        # Идентификатор устройства
        id:int
        # Идентификатор устройства
        deviceType:tid.DeviceModelType
        # Настройки устройства
        settings:JsonNode
        # Маршруты устройства
        routes:seq[CollectorDeviceRoute]

    # Интерфейс задания собирателя
    CollectorTask* = ref object of RootObj      
        # Идентификатор задания
        id: int
        case kind : TaskKind
        of DataRequest:
            # Параметр измерения
            parameter:int
            # Запрашиваемый интервал данных
            dataInterval:Interval
        of EventRequest:
            # Запрашиваемый интервал событий
            eventInterval:Interval

    # Канал транспортировки данных
    ITransportChannel* = ref object
        # Обратный вызов при получении ответа
        onResponse*:proc(packet:seq[uint8]):void
        # Обратный вызов при возникновении ошибки в канале
        onFail*:proc():void
        # Отправляет пакет
        send:proc(packet:openArray[uint8]):void

    # Интерфейс транспортного драйвера
    ITransportDriver* = ref object
        # Возвращает future которая вернёт или канал
        # Или ошибку получения канала
        getChannel:proc(route:CollectorDeviceRoute):Future[ITransportChannel]

    # Интерфейс драйвера протокола
    IProtocolDriver* = ref object

    # Интерфейс прикладного драйвера
    IAppLayerDriver* = ref object

# Создаёт задачу собирателя для сбора данных измерения
proc newDataRequestCollectorTask*(
        id:int,
        parameter:int,
        dataInterval:Interval
        ) : CollectorTask =
    return CollectorTask(
        id:id,
        kind:TaskKind.DataRequest,
        parameter:parameter,
        dataInterval:dataInterval
    )

# Возвращает идентификатор задания
template id*(this:CollectorTask) : int =
    this.id

# Возвращает тип задания
template kind*(this:CollectorTask) : TaskKind =
    this.kind

# Создаёт новое устройство сбора
proc newCollectorDevice*(id:int, deviceType:DeviceModelType, settings:JsonNode) : CollectorDevice =
    return CollectorDevice(
        id: id,
        deviceType: deviceType,
        settings: settings
    )

# Считает хэш для CollectorDeviceRoute
proc hash*(this:CollectorDeviceRoute):Hash =
    return 1

# Сравнивает два маршрута
proc `==`*(x,y:CollectorDeviceRoute):bool =
    true