import options

import ../../common/type_ids

type
    # Параметр измерения собирателя
    CollectorParameter* = object
        # Тип измерения
        measureType:MeasureType
        # Направление перетока, может отсутствовать
        direction:Option[FlowDirection]
        # Дискретность, может отсутствовать
        discret:Option[int]
        # True - параметр за интервал
        # False - параметр фиксируется или текущий
        isInterval:bool

