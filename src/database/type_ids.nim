# Модуль с идентификаторами

type
    # Модели устройств
    DeviceModelType* {.pure.} = enum
        # Универсальный счетчик с протоколом СПОДЭС
        UniversalSpodes = 0

    # Типы маршрутов
    RouteType* {.pure.} = enum
        # Серийный порт
        Serial = 0,
        # TCP клиент
        TcpClient = 1

    # Типы расписания
    ScheduleType* {.pure.} = enum
        Periodic = 0