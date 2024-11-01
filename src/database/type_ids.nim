# Модуль с идентификаторами

type
    # Модели устройств
    DeviceModelType* {.pure.} = enum
        # Универсальный счетчик с протоколом СПОДЭС
        UniversalSpodes = 0

    # Типы расписания
    ScheduleType* {.pure.} = enum
        Periodic = 0