import ../../collector_types as cot

# Создаёт новый драйвер
proc newDriver*():cot.ITransportDriver =
    return cot.ITransportDriver(
    )