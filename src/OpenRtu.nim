# Точка входа

import asyncdispatch
import database/database as db
import collector

proc main() {.async.} =
    db.init()
    collector.start()

when isMainModule:
    waitFor(main())