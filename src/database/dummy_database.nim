import json
import options
import idatabase
import ../common/type_ids as tid
import ./db_entities as dbe

# Возвращает все сценарии сбора
proc getCollectorScenarios():seq[dbe.DbCollectorScenarioRead] =
    return @[
        dbe.DbCollectorScenarioRead(
            id:1,
            name:"Сбор энергии",
            scheduleType:tid.ScheduleType.Periodic,
            scheduleSettings: %* { "discet": { "type":4, "value": 1  } },
            devices: @[
                dbe.DbDeviceRead(
                    id: 1,
                    devceType:DeviceModelType.UniversalSpodes,
                    protocolType:ProtocolType.Spodes,
                    deviceSettings: %* { "address": 45 },
                    routes: @[
                        dbe.DbRouteRead(
                            id:1,
                            routeType:tid.RouteType.TcpClient,
                            #routeSettings: %* { "host":"localhost", "port":26701 }
                        )
                    ]
                ),
                dbe.DbDeviceRead(
                    id: 2,
                    devceType:tid.DeviceModelType.UniversalSpodes,
                    deviceSettings: %* { "address": 22 },
                    routes: @[
                        dbe.DbRouteRead(
                            id:2,
                            routeType:tid.RouteType.TcpClient,
                            #routeSettings: %* { "host":"localhost", "port":26701 }
                        )
                    ]
                ),
                dbe.DbDeviceRead(
                    id: 3,
                    devceType:tid.DeviceModelType.UniversalSpodes,
                    deviceSettings: %* { "address": 14 },
                    routes: @[
                        dbe.DbRouteRead(
                            id:3,
                            routeType:tid.RouteType.TcpClient,
                            #routeSettings: %* { "host":"localhost", "port":26701 }
                        )
                    ]
                )
            ]
        )
    ]

# Создаёт новую базу
proc newDatabase*() : IDatabase =
    return idatabase.createInterface(
        getCollectorScenarios = getCollectorScenarios,        
    )