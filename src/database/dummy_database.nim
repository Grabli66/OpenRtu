import idatabase
import ./db_entities as dbe

# Возвращает все устройства
proc getDevices():seq[dbe.DbDevice] =
    result = newSeq[dbe.DbDevice]()
    result.add(dbe.DbDevice())

# Возвращает все сценарии сбора
proc getCollectorScenarios():seq[dbe.DbCollectorScenario] =
    discard

# Создаёт новую базу
proc newDatabase*() : IDatabase =
    return idatabase.createInterface(
        getDevices = getDevices,
        getCollectorScenarios = getCollectorScenarios
    )