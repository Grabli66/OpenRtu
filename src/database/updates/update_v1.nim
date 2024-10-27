import allographer/connection as conn
import allographer/schema_builder
import ../db_entities as dbe

# Обновление базы данных до версии 1
proc updateV1*(ctx:SqliteConnections) =    
    ctx.create([
        table(dbe.deviceTableName, [
            Column.increments("id"),  
            Column.integer("model_type_id"),
            Column.string("settings")
        ]) 
    ])

    ctx.create([
        table(dbe.deviceTypeTableName, [
            Column.increments("id"),
            Column.integer("model_type_id"),
            Column.string("name")
        ])
    ])