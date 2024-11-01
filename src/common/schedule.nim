type
    # Базовое расписание запуска
    BaseSchedule* = object of RootObj

    # Периодическое расписание
    PeriodicSchedule* = object of BaseSchedule
    
# Возвращает через сколько секунд должен быть запуск
method getNextStartSec*(this : BaseSchedule) : int {.base.} =
    discard

# Возвращает через сколько секунд должен быть запуск для периодического расписания
method getNextStartSec*(this : PeriodicSchedule) : int =
    return 10