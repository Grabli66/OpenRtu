type
    # Время внутри суток
    DayTime* = object
        hour:int
        minute:int
        second:int

# Конструктор DayTime
proc newDayTime*(hour:int, minute:int, second:int) : DayTime =
    return DayTime(
        hour:hour,
        minute:minute,
        second:second
    )