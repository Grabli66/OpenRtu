# Модуль фабрика драйверов сбора

import options
import ../common/type_ids as tid
import ./types/itransport_driver as itd
import ./types/iprotocol_driver as ipd
import ./types/iapplayer_driver as iad
import ./drivers/transport/tcp_client_driver as tcd

# Возвращает драйвер для транспортировки пакета
proc getTransportDriver*(routeType:tid.RouteType) : Option[itd.ITransportDriver] =
    case routeType
    of tid.RouteType.TcpClient:
        return some(tcd.newDriver())
    else:
        return none(itd.ITransportDriver)

# Возвращает драйвер канального протокола
proc getProtocolDriver*(protocolType:tid.ProtocolType) : ipd.IProtocolDriver =
    discard

# Возвращает прикладной драйвер обрабатывающего задания автосбора
proc getAppLayerDriver*(deviceType:DeviceModelType) : iad.IAppLayerDriver =
    discard