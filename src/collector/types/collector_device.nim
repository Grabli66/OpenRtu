import json


import ../../common/type_ids as tid

type       
    # Маршрут устройства
    CollectorDeviceRoute* = ref object
        # Тип маршрута
        routeType:int
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
proc newCollectorDevice*(id:int, deviceType:DeviceModelType, settings:JsonNode) : CollectorDevice =
    return CollectorDevice(
        id: id,
        deviceType: deviceType,
        settings: settings
    )