# Общие типы относящиеся к автосбору
# Для передачи между модулями

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

# Создаёт задачу собирателя
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
proc id*(this:CollectorTask) : int =
    return this.id

# Возвращает тип задания
proc kind*(this:CollectorTask) : TaskKind =
    return this.kind