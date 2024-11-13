import idatabase
import ./dummy_database as ddb


# Интерфейс базы данных
var database : IDatabase

# Возвращает интерфейс базы данных
proc get*() : IDatabase =
    # if database != nil:
    #     return database

    database = ddb.newDatabase()
    return database