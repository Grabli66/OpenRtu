import json
import ./type_ids

type
    # Маршрут для чтения
    DbRouteRead* = ref object
        id*:int
        routeType*:RouteType
        routeSettings*:JsonNode

    # Устройство для чтения
    DbDeviceRead* = ref object
        id*:int
        devceType*:DeviceModelType
        deviceSettings*:JsonNode
        routes*:seq[DbRouteRead]

    # Сущность сценария сбора для чтения
    DbCollectorScenarioRead* = ref object
        id*:int
        name*:string
        scheduleType*:ScheduleType
        scheduleSettings:JsonNode
        devices*:seq[DbDeviceRead]