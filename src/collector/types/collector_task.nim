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
    CollectorTaskData* = object        
        case kind : TaskKind
        of DataRequest:
            # Параметр измерения
            parameter:CollectorParameter
            # Запрашиваемый интервал данных, может отсутствовать
            dataInterval:Option[Interval]
        of EventRequest:
            # Запрашиваемый интервал событий
            eventInterval:Interval       

    CollectorTask* = object
        # Идентификатор задания
        id:Natural
        # Информация по заданию 
        data:CollectorTaskData

    # Задания собирателя с данными по устройству с маршрутом
    CollectorTasksWithDevice* = object
        # Задания
        tasks: seq[CollectorTask]
        # Устройство
        device: CollectorDevice
        # Маршрут
        route: CollectorDeviceRoute

# Создаёт задачу собирателя для сбора данных измерения
proc newCollectorDataTask*(
        parameter:CollectorParameter,
        dataInterval:Option[Interval]
        ) : CollectorTaskData =
    return CollectorTaskData(        
            kind:TaskKind.DataRequest,
            parameter:parameter,
            dataInterval:dataInterval        
    )

# Создаёт новое задание собирателя
proc newCollectorTask*(id:Natural, data:CollectorTaskData):CollectorTask =
    return CollectorTask(
        id:id,
        data:data
    )

# Возвращает идентификатор задания
proc id*(this:CollectorTask) : int =
    return this.id

# Возвращает тип задания
proc kind*(this:CollectorTask) : TaskKind =
    return this.kind