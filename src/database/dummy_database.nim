import options
import idatabase
import ./type_ids as tid
import ./db_entities as dbe

# Возвращает все сценарии сбора
proc getCollectorScenarios():seq[dbe.DbCollectorScenarioRead] =
    return @[
        dbe.DbCollectorScenarioRead(
            scheduleType:tid.ScheduleType.Periodic
        )
    ]

# Создаёт новую базу
proc newDatabase*() : IDatabase =
    return idatabase.createInterface(
        getCollectorScenarios = getCollectorScenarios,        
    )