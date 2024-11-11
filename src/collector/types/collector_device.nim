import json


import ../../common/type_ids as tid

type       
    # Маршрут устройства
    CollectorDeviceRoute* = ref object
        # Тип маршрута
        routeType:tid.RouteType
        # Настройки маршрута
        routeSettings:JsonNode

    # Данные по устройству сбора
    CollectorDevice* = ref object
        # Идентификатор устройства
        id:int
        # Идентификатор устройства
        deviceType:tid.DeviceModelType
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

# Возвращает тип маршрута
proc routeType*(this:CollectorDeviceRoute):tid.RouteType =
    return this.routeType

# Возвращает маршруты по устройству
proc routes*(this:CollectorDevice):seq[CollectorDeviceRoute] =
    return this.routes