# Основной модуль
# Инициализирует базу данных
# Загружает сценарии сбора и устройства из базы
# Создаёт сценарии сбора для сборщика данных и добавляет их в обработку
# Запускает сервер обработки внешних запросов
# Запускает webapi для веб интерфейса
# Отслеживает изменения: web, серзвера запросов и вносит изменения в базу и управляет сбором

import print

import options
import json
import tables

import database/idatabase as dbi
import database/database_factory as dbf
import database/db_entities as dbe
import database/type_ids
import collector/collector as col
import common/schedule

proc main() =
    # Инициализирует базу данных    
    let db = dbf.get()
    # Загружает сценарии сбора    
    let dbScenarios = db.getCollectorScenarios()
    var scenarios = newSeq[col.CollectorScenario]()
    for dbScenario in dbScenarios:
        discard

    # Запускает выполнение сценариев


when isMainModule:
    main()