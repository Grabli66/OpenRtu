# Общие типы относящиеся к автосбору

type
    # Установленный канал до устройства
    # Для передачи данных в устройство
    DeviceIOChannel* = ref object       

    # Прикладной драйвер
    AppLayerDriver* = ref object

    # Задание автосбора использующееся в прикладном драйвере сбора
    AppLayerCollectorTask* = ref object
        # Идентификатор задания
        id*:int
        # Настройки задания
        settings:string
        # Установленный канал до устройства
        io*:DeviceIOChannel