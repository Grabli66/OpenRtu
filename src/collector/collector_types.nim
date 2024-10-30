# Общие типы относящиеся к автосбору
# Для передачи между модулями

type
    # Установленный канал до устройства
    # Для передачи данных в устройство
    DeviceIOChannel* = ref object       

    # Прикладной драйвер
    AppLayerDriver* = ref object

    # Задание автосбора использующееся в прикладном драйвере сбора
    # Базовое определение, реализуется в автосборе
    BaseCollectorTask* = ref object of RootObj       

# Возвращает идентификатор задания
method id*(this:BaseCollectorTask) : int {.base.} =
    raise newException(ValueError, "Not implemented")