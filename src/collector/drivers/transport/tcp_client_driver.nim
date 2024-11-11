import ../../types/itransport_driver as itd

# Создаёт новый драйвер
proc newDriver*():itd.ITransportDriver =
    return itd.ITransportDriver(
    )