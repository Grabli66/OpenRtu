import options
import ../common/type_ids as tid
import ./collector_types as cot

# Фабрика драйверов сбора

# Возвращает драйвер для транспортировки пакета
proc getTransportDriver*(routeType:tid.RouteType) : Option[cot.ITransportDriver] =
    case routeType
    of tid.RouteType.TcpClient:
        discard
    else:
        return none(cot.ITransportDriver)

# Возвращает драйвер канального протокола
proc getProtocolDriver*(protocolType:tid.ProtocolType) : cot.IProtocolDriver =
    discard

# Возвращает прикладной драйвер обрабатывающего задания автосбора
proc getAppLayerDriver*(deviceType:DeviceModelType) : cot.IAppLayerDriver =
    discard