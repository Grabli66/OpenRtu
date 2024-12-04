import json
import ../common/type_ids as tid

type
    # Базовые настройки маршрута. Для чтения
    DbBaseRouteSettingsRead* = object of RootObj

    # Настройки для TCP клиентского подключения
    DbTcpClientSettingsRead* = object of DbBaseRouteSettingsRead        
        # Хост удалённого устройства
        host*:string
        # Порт для подключения
        port*:string

    # Настройки маршрута через УСПД
    DbRtuRouteSettingsRead* = object of DbBaseRouteSettingsRead
                
    # Маршрут для чтения
    DbRouteRead* = object
        id*:int
        routeType*:tid.RouteType
        routeSettings*:DbBaseRouteSettingsRead

    # Устройство для чтения
    DbDeviceRead* = object
        id*:int
        devceType*:DeviceModelType
        protocolType*:ProtocolType
        deviceSettings*:JsonNode
        routes*:seq[DbRouteRead]

    # Сущность сценария сбора для чтения
    DbCollectorScenarioRead* = object
        id*:int
        name*:string
        scheduleType*:tid.ScheduleType
        scheduleSettings*:JsonNode
        devices*:seq[DbDeviceRead]