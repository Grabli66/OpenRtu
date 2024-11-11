import asyncdispatch

import ../../common/ikey
import ./collector_device as cod

type
    # Канал транспортировки данных
    ITransportChannel* = ref object
        # Обратный вызов при получении ответа
        onResponse*:proc(packet:seq[uint8]):void
        # Обратный вызов при возникновении ошибки в канале
        onFail*:proc():void
        # Отправляет пакет
        send:proc(packet:openArray[uint8]):void
    
     # Интерфейс транспортного драйвера
    ITransportDriver* = ref object
        # Возвращает future которая вернёт канал посли установки связи
        # Или ошибку получения канала
        openChannel:proc(route:cod.CollectorDeviceRoute):Future[ITransportChannel]
        # Возвращает ключ для сравнения маршрута
        getKey:proc(route:CollectorDeviceRoute):IKey[CollectorDeviceRoute]

# Отправляет пакет
proc send*(this:ITransportChannel,packet:openArray[uint8]):void =
    this.send(packet)

# Перенаправляет в интерфейс
proc openChannel*(
        this:ITransportDriver, route:CollectorDeviceRoute):Future[ITransportChannel] =
    return this.openChannel(route)

proc isRouteEqual*(
        this:ITransportDriver, first:CollectorDeviceRoute, second:CollectorDeviceRoute):bool =
    return this.isRouteEqual(first, second)
    