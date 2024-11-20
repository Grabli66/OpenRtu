# Основной модуль
# Инициализирует базу данных
# Загружает сценарии сбора и устройства из базы
# Создаёт сценарии сбора для сборщика данных и добавляет их в обработку
# Запускает сервер обработки внешних запросов
# Запускает webapi для веб интерфейса
# Отслеживает изменения: web, серзвера запросов и вносит изменения в базу и управляет сбором


import sequtils
import std/sugar

import database/idatabase as dbi
import database/database_factory as dbf
import database/db_entities as dbe
import collector/collector as col
import collector/types/collector_device as cod
import collector/types/collector_scenario as cos
import common/daytime as dyt
import common/discret as dis
import common/ischedule as sch

proc main() =
    # Инициализирует базу данных    
    let db = dbf.get()
    # Загружает сценарии сбора    
    let dbScenarios = db.getCollectorScenarios()    
    for dbScenario in dbScenarios:  
        let deepDay = 3

        let schedule = sch.newPeriodicSchedule(
                dis.newHourDiscret(),
                dyt.newZeroDayTime()
        )

        let devices = dbScenario.devices.mapIt(cod.newCollectorDevice(
                it.id,
                it.devceType,
                it.deviceSettings,
                it.routes.mapIt(
                    cod.newCollectorDeviceRoute(it.routeType, it.routeSettings)
                )
        ))

        let scenario = cos.newCollectorScenario(
            dbScenario.id, schedule, deepDay, @[], devices)
        scenario.start()

when isMainModule:
    main()