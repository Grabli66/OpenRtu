import allographer/connection as conn
import allographer/schema_builder

# Обновление базы данных до версии 1
proc updateV1*(ctx:SqliteConnections) =    
    ctx.create([
        table("device", [
            Column.increments("id"),  
            Column.integer("model_type_id"),
            Column.string("settings")
        ]) 
    ])

    ctx.create([
        table("device_type", [
            Column.increments("id"),  
            Column.integer("model_type_id"),
            Column.string("name")
        ])
    ])