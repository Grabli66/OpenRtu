import ../../types/itransport_driver as itd
import ../../types/collector_device as cod
import ../../../common/ikey as ike

# Возвращает ключ для маршрута
proc getKey(route:CollectorDeviceRoute):IKey[CollectorDeviceRoute] =
    return newIKey[CollectorDeviceRoute](
        obj = route,
        hash = nil,
        equals = nil
    )

# Создаёт новый драйвер
proc newDriver*():itd.ITransportDriver =
    return itd.newITransportDriver(
        openChannel = nil,
        getKey = getKey
    )