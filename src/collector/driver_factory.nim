# Модуль фабрика драйверов сбора

import options
import tables

import ../common/type_ids as tid
import ./types/itransport_driver as itd
import ./types/iprotocol_driver as ipd
import ./types/iapplayer_driver as iad
import ./drivers/transport/tcp_client_driver as tcd

var transportDrivers = newTable[RouteType, Option[ITransportDriver]]()

# Возвращает драйвер для транспортировки пакета
proc getTransportDriver*(routeType:RouteType) : Option[ITransportDriver] =            
    if transportDrivers.hasKey(routeType):
        return transportDrivers[routeType]
    
    let driver = case routeType
    of tid.RouteType.TcpClient:
        some(tcd.newDriver())
    else:
        none(ITransportDriver)
    
    transportDrivers[routeType] = driver

    return driver

# Возвращает драйвер канального протокола типа протокола
proc getProtocolDriver*(protocolType:ProtocolType) : IProtocolDriver =
    discard

# Возвращает прикладной драйвер обрабатывающего задания автосбора
proc getAppLayerDriver*(deviceType:DeviceModelType) : IAppLayerDriver =
    discard