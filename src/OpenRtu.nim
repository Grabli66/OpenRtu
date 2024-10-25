# Точка входа

import asyncdispatch
import database/database as db
import database/db_entities as dbe
import collector

proc main() {.async.} =
    db.init()

    
    collector.start()

when isMainModule:
    waitFor(main())