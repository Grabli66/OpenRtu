import options
import db_entities as dbe

type
    # Интерфейс базы данных 
    IDatabase* = ref object
        # Возвращает все устройства
        getDevices:proc():seq[dbe.DbDevice]
        # Возвращает модель по идентификатору устройства
        getDeviceTypeByModelId:proc(id:int):Option[DbDeviceType]
        # Возвращает все сценарии сбора
        getCollectorScenarios:proc():seq[dbe.DbCollectorScenario]
        # Возвращает маршрут по идентификатору устройства
        getRouteByDeviceId:proc(id:int):Option[dbe.DbRoute]

# Создаёт интерфейс базы данных
proc createInterface*(
    getDevices:proc():seq[dbe.DbDevice],
    getDeviceTypeByModelId:proc(id:int):Option[DbDeviceType],
    getCollectorScenarios:proc():seq[dbe.DbCollectorScenario],
    getRouteByDeviceId:proc(id:int):Option[dbe.DbRoute],
) : IDatabase =
    return IDatabase(
        getDevices:getDevices,
        getDeviceTypeByModelId:getDeviceTypeByModelId,
        getCollectorScenarios:getCollectorScenarios,
        getRouteByDeviceId:getRouteByDeviceId
    )

# Возвращает все устройства
template getDevices*(this:IDatabase):seq[dbe.DbDevice] =
    this.getDevices()

# Возвращает модель по идентификатору устройства
template getDeviceTypeByModelId*(this:IDatabase, id:int):Option[DbDeviceType] =
    this.getDeviceTypeByModelId(id)

# Возвращает все сценарии сбора
template getCollectorScenarios*(this:IDatabase):seq[dbe.DbCollectorScenario] =
    this.getCollectorScenarios()

# Возвращает маршрут по идентификатору устройства
template getRouteByDeviceId*(this:IDatabase, id:int) : Option[dbe.DbRoute] =
    this.getRouteByDeviceId(id)
       