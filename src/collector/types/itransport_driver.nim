import asyncdispatch

import ../../common/ikey
import ./collector_device as cod

type
    # Канал транспортировки данных
    ITransportChannel* = object
        # Обратный вызов при получении ответа
        onResponse*:proc(packet:seq[uint8]):void
        # Обратный вызов при возникновении ошибки в канале
        onFail*:proc():void
        # Отправляет пакет
        send:proc(packet:openArray[uint8]):void
    
     # Интерфейс транспортного драйвера
    ITransportDriver* = object
        # Возвращает future которая вернёт канал посли установки связи
        # Или ошибку получения канала
        openChannel:proc(route:cod.CollectorDeviceRoute):Future[ITransportChannel]
        # Возвращает ключ для сравнения маршрута
        getKey:proc(route:CollectorDeviceRoute):IKey[CollectorDeviceRoute]

# Создаёт новый ITransportDriver
proc newITransportDriver*(
            openChannel:proc(route:cod.CollectorDeviceRoute):Future[ITransportChannel],
            getKey:proc(route:CollectorDeviceRoute):IKey[CollectorDeviceRoute]):ITransportDriver =
    return ITransportDriver(
        openChannel:openChannel,
        getKey:getKey
    )

# Перенаправляет в интерфейс
proc openChannel*(
        this:ITransportDriver, route:cod.CollectorDeviceRoute):Future[ITransportChannel] = 
    return this.openChannel(route)

# Перенаправляет в интерфейс
proc getKey*(this:ITransportDriver,route:CollectorDeviceRoute):IKey[CollectorDeviceRoute] =
    return this.getKey(route)
    
# Отправляет пакет
proc send*(this:ITransportChannel,packet:openArray[uint8]):void =
    this.send(packet)