import ./discret
import ./daytime

type
    # Базовое расписание запуска
    BaseSchedule* = object of RootObj

    # Периодическое расписание
    PeriodicSchedule* = object of BaseSchedule
        # Дискретность выполнения
        discret:Discret
        # Начальное время внутри суток, от которого считается интервал по дискретности
        startTime:DayTime

# Конструктор PeriodicSchedule
proc newPeriodicSchedule*(discret:Discret, startTime:DayTime) : PeriodicSchedule =
    return PeriodicSchedule(
        discret:discret,
        startTime:startTime
    )

# Возвращает через сколько секунд должен быть запуск для периодического расписания
proc getNextStartSec*(this : PeriodicSchedule) : int =
    return 10