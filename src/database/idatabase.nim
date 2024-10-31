import db_entities as dbe

type
    # Интерфейс базы данных 
    IDatabase* = ref object
        # Возвращает все устройства
        getDevices:proc():seq[dbe.DbDevice]
        # Возвращает все сценарии сбора
        getCollectorScenarios:proc():seq[dbe.DbCollectorScenario]

# Создаёт интерфейс базы данных
proc createInterface*(
    getDevices:proc():seq[dbe.DbDevice],
    getCollectorScenarios:proc():seq[dbe.DbCollectorScenario]
) : IDatabase =
    return IDatabase(
        getDevices:getDevices,
        getCollectorScenarios:getCollectorScenarios
    )

# Возвращает все устройства
template getDevices*(this:IDatabase):seq[dbe.DbDevice] =
    this.getDevices()

# Возвращает все сценарии сбора
template getCollectorScenarios*(this:IDatabase):seq[dbe.DbCollectorScenario] =
    this.getCollectorScenarios()
       