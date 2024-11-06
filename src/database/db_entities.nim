import json
import ../common/type_ids as tid

type
    # Маршрут для чтения
    DbRouteRead* = ref object
        id*:int
        routeType*:tid.RouteType
        routeSettings*:JsonNode

    # Устройство для чтения
    DbDeviceRead* = ref object
        id*:int
        devceType*:tid.DeviceModelType
        deviceSettings*:JsonNode
        routes*:seq[DbRouteRead]

    # Сущность сценария сбора для чтения
    DbCollectorScenarioRead* = ref object
        id*:int
        name*:string
        scheduleType*:tid.ScheduleType
        scheduleSettings*:JsonNode
        devices*:seq[DbDeviceRead]