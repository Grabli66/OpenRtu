# Точка входа

import database/database as db
import collector/collector

proc main() =
    # Инициализирует базу данных
    db.init()        
    # Запускает автосбор
    collector.loadAndStart()

when isMainModule:
    main()