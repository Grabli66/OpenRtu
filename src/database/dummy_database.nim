import options
import idatabase
import ./type_ids as tid
import ./db_entities as dbe

# Возвращает все устройства
proc getDevices():seq[dbe.DbDevice] =
    result = @[
        dbe.DbDevice(
            id:1,
            modelTypeId:int(tid.DeviceModelType.UniversalSpodes),
            settings: "{ \"networkId\": 23 }"
        ),
        dbe.DbDevice(
            id:2,
            modelTypeId:int(tid.DeviceModelType.UniversalSpodes),
            settings: "{ \"networkId\": 62 }"
        ),
        dbe.DbDevice(
            id:3,
            modelTypeId:int(tid.DeviceModelType.UniversalSpodes),
            settings: "{ \"networkId\": 98 }"
        )
    ]

# Возвращает модель по идентификатору устройства
proc getDeviceTypeByModelId(id:int):Option[DbDeviceType] =
    case id
    of int(tid.DeviceModelType.UniversalSpodes):
        return some(
            DbDeviceType(
                modelTypeId:id,
                name:"Универсальный счетчик СПОДЭС"
            )
        )
    else:
        none(DbDeviceType)

# Возвращает все сценарии сбора
proc getCollectorScenarios():seq[dbe.DbCollectorScenario] =
    return @[
        dbe.DbCollectorScenario(
            scheduleType:int(tid.ScheduleType.Periodic)
        )
    ]

# Возвращает маршрут по идентификатору устройства
proc getRouteByDeviceId(id:int) : Option[dbe.DbRoute] =
    case id
    of 1,2,3:
        return some(dbe.DbRoute(
            id: 1, 
            routeTypeId: 1
        ))    
    else:
        return none(dbe.DbRoute)

# Создаёт новую базу
proc newDatabase*() : IDatabase =
    return idatabase.createInterface(
        getDevices = getDevices,
        getDeviceTypeByModelId = getDeviceTypeByModelId,
        getCollectorScenarios = getCollectorScenarios,
        getRouteByDeviceId = getRouteByDeviceId
    )