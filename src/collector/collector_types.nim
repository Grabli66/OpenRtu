# Типы относящиеся к автосбору

type
    # Установленный канал до устройства
    DeviceIOChannel* = ref object       

    # Прикладной драйвер
    AppLayerDriver* = ref object

    # Задание автосбора использующееся в прикладном драйвере сбора
    CollectorTask* = ref object
        # Идентификатор задания
        id*:int
        # Установленный канал до устройства
        io*:DeviceIOChannel