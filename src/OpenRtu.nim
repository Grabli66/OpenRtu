# Основной модуль
# Инициализирует базу данных
# Загружает сценарии сбора и устройства из базы
# Создаёт сценарии сбора для сборщика данных и добавляет их в обработку
# Запускает сервер обработки внешних запросов
# Запускает webapi для веб интерфейса
# Отслеживает изменения: web, серзвера запросов и вносит изменения в базу и управляет сбором


import sequtils

import print

import database/idatabase as dbi
import database/database_factory as dbf
import database/db_entities as dbe
import collector/collector as col
import collector/types/collector_device as cod
import common/daytime as dyt
import common/discret as dis
import common/schedule as sch

proc main() =
    # Инициализирует базу данных    
    let db = dbf.get()
    # Загружает сценарии сбора    
    let dbScenarios = db.getCollectorScenarios()    
    for dbScenario in dbScenarios:               
        let scenario = col.addCollectorScenario(
            dbScenario.id,
            sch.newPeriodicSchedule(
                dis.newHourDiscret(),
                dyt.newZeroDayTime()
            ),
            dbScenario.devices.mapIt(cod.newCollectorDevice(
                it.id,
                it.devceType,
                it.deviceSettings
            ))
        )
        scenario.start()


when isMainModule:
    main()