# Точка входа

import database/database as db
import database/db_entities as dbe
import collector/collector

proc main() =
    # Инициализирует базу данных
    db.init()        
    # Запускает автосбор
    collector.start()

when isMainModule:
    main()