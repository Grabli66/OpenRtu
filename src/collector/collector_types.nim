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
    ICollectorTask* = ref object of RootObj      
        # Возвращает идентификатор задания
        getId*: proc():int  
        case kind : TaskKind
        of DataRequest:
            # Параметр измерения
            parameter:int
            # Запрашиваемый интервал данных
            dataInterval:Interval
        of EventRequest:
            # Запрашиваемый интервал событий
            eventInterval:Interval