import json


import ../../common/type_ids
import ../../database/db_entities as dbe

type       
    # Маршрут устройства
    CollectorDeviceRoute* = object
        # Тип маршрута
        routeType:RouteType
        # Настройки маршрута
        routeSettings:DbBaseRouteSettingsRead

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
proc newCollectorDeviceRoute*(routeType:RouteType, routeSettings:DbBaseRouteSettingsRead):CollectorDeviceRoute =
    return CollectorDeviceRoute(
        routeType:routeType,
        routeSettings:routeSettings
    )

# Возвращает тип устройства
proc deviceType*(this:CollectorDevice):DeviceModelType =
    return this.deviceType

# Возвращает протокол устройства
proc protocolType*(this:CollectorDevice):ProtocolType =
    return this.protocolType

# Возвращает тип маршрута
proc routeType*(this:CollectorDeviceRoute):RouteType =
    return this.routeType

# Возвращает маршруты по устройству
proc routes*(this:CollectorDevice):seq[CollectorDeviceRoute] =
    return this.routes