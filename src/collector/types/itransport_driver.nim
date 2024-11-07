import asyncdispatch

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
        # Возвращает future которая вернёт или канал
        # Или ошибку получения канала
        getChannel:proc(route:CollectorDeviceRoute):Future[ITransportChannel]

# Отправляет пакет
template send*(this:ITransportChannel,packet:openArray[uint8]):void =
    this.send(packet)
    