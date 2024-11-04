import options
import db_entities as dbe

type
    # Интерфейс базы данных 
    IDatabase* = ref object        
        # Возвращает все сценарии сбора
        getCollectorScenarios:proc():seq[dbe.DbCollectorScenarioRead]

# Создаёт интерфейс базы данных
proc createInterface*(        
    getCollectorScenarios:proc():seq[dbe.DbCollectorScenarioRead],
) : IDatabase =
    return IDatabase(        
        getCollectorScenarios:getCollectorScenarios,
    )

# Возвращает все сценарии сбора
template getCollectorScenarios*(this:IDatabase):seq[dbe.DbCollectorScenarioRead] =
    this.getCollectorScenarios()       