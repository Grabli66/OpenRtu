import options

import ./collector_device
import ./collector_parameter
import ../../common/interval

type
     # Типы задания собирателя
    TaskKind* {.pure.} = enum
        # Запрос измеренных данных устройства
        DataRequest = 0, 
        # Запрос событий устройства
        EventRequest = 1

    # Интерфейс задания собирателя
    CollectorTask* = object of RootObj      
        # Идентификатор задания
        id: int
        case kind : TaskKind
        of DataRequest:
            # Параметр измерения
            parameter:CollectorParameter
            # Запрашиваемый интервал данных, может отсутствовать
            dataInterval:Option[Interval]
        of EventRequest:
            # Запрашиваемый интервал событий
            eventInterval:Interval   

    # Задания собирателя с данными по устройству с маршрутом
    CollectorTasksWithDevice* = object
        # Задания
        tasks: seq[CollectorTask]
        # Устройство
        device: CollectorDevice
        # Маршрут
        route: CollectorDeviceRoute

# Создаёт задачу собирателя для сбора данных измерения
proc newDataRequestCollectorTask*(
        id:int,
        parameter:CollectorParameter,
        dataInterval:Option[Interval]
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