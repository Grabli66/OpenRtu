type
    # Время внутри суток
    DayTime* = object
        hour:int
        minute:int
        second:int

# Конструктор нулевого DayTime
proc newZeroDayTime*() : DayTime =
    return DayTime(
        hour:0,
        minute:0,
        second:0
    )

# Конструктор DayTime
proc newDayTime*(hour:int, minute:int, second:int) : DayTime =
    return DayTime(
        hour:hour,
        minute:minute,
        second:second
    )