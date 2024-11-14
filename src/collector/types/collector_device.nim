import json


import ../../common/type_ids

type       
    # Маршрут устройства
    CollectorDeviceRoute* = object
        # Тип маршрута
        routeType:RouteType
        # Настройки маршрута
        routeSettings:JsonNode

    # Данные по устройству сбора
    CollectorDevice* = object
        # Идентификатор устройства
        id:int
        # Идентификатор устройства
        deviceType:DeviceModelType
        # Тип протокола
        protocolType:ProtocolType
        # Настройки устройства
        settings:JsonNode
        # Маршруты устройства
        routes:seq[CollectorDeviceRoute]

# Создаёт новое устройство сбора
proc newCollectorDevice*(
        id:int, deviceType:DeviceModelType, settings:JsonNode, routes:seq[CollectorDeviceRoute]) : CollectorDevice =
    return CollectorDevice(
        id: id,
        deviceType: deviceType,
        settings: settings,
        routes:routes
    )

# Создаёт новый маршрут
proc newCollectorDeviceRoute*(routeType:RouteType, routeSettings:JsonNode):CollectorDeviceRoute =
    return CollectorDeviceRoute(
        routeType:routeType,
        routeSettings:routeSettings
    )

# Возвращает тип маршрута
proc routeType*(this:CollectorDeviceRoute):RouteType =
    return this.routeType

# Возвращает маршруты по устройству
proc routes*(this:CollectorDevice):seq[CollectorDeviceRoute] =
    return this.routes