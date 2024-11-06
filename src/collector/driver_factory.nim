import ../common/type_ids as tid
import ./collector_types as cot

# Фабрика драйверов сбора

# Возвращает драйвер для транспортировки пакета
proc getTransportDriver*(routeType:tid.RouteType) : cot.ITransportDriver =
    discard

# Возвращает драйвер канального протокола
proc getProtocolDriver*(protocolType:tid.ProtocolType) : cot.IProtocolDriver =
    discard

# Возвращает прикладной драйвер обрабатывающего задания автосбора
proc getAppLayerDriver*(deviceType:DeviceModelType) : cot.IAppLayerDriver =
    discard