import ./discret
import ./daytime

type
    # Интерфейс расписания запуска
    ISchedule* = object
        # Возвращает время следующего запуска в секундах
        getNextStartSec:proc():int

# Создаёт периодическое расписание
proc newPeriodicSchedule*(discret:Discret, startTime:DayTime):ISchedule =
    return ISchedule(
        getNextStartSec:proc():int =
            return 10
    )

# Возвращает через сколько секунд должен быть запуск для периодического расписания
proc getNextStartSec*(this:ISchedule):int =
    return this.getNextStartSec()