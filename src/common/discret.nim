type
    # Тип дискретности
    DiscretType* {.pure.} = enum
        Minute = 0,
        Second = 1,
        Hour = 2,
        Day = 3,
        Month = 4,
        Year = 5

    # Дискретность
    Discret* = object
        # Тип дискретности
        discretType*:DiscretType
        # Значение дискретности
        discretValue*:int