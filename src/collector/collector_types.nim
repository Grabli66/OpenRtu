# Общие типы относящиеся к автосбору
# Для передачи между модулями

import json
import ../database/type_ids as tid
import ../common/interval

type
    # Установленный канал до устройства
    # Для передачи данных в устройство
    DeviceIOChannel* = ref object       

    # Прикладной драйвер
    AppLayerDriver* = ref object

    # Типы задания собирателя
    TaskKind* {.pure.} = enum
        # Запрос измеренных данных устройства
        DataRequest = 0, 
        # Запрос событий устройства
        EventRequest = 1

    # Данные по устройству сбора
    CollectorDevice* = ref object
        # Идентификатор устройства
        id:int
        # Идентификатор устройства
        deviceType:tid.DeviceModelType
        # Настройки устройства
        settings:JsonNode  

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