# Сущности базы данных

type 
    DbEntity* = ref object of RootObj
        # Идентификатор сущности
        id*:int

    # Модель прибора учета
    DbDevice* = ref object of DbEntity   
        # Идентификатор модели
        model_type_id*:int
        # Специфические настройки модели в формате JSON
        settings*:string

    # Тип прибора учета
    DbDeviceType* = ref object of DbEntity
        # Идентификатор модели
        model_type_id*:int
        # Название модели
        name*:string

    # Маршрут до устройства
    DbRoute* = ref object of DbEntity
        # Идентификатор устройства к которому относится маршрут
        device_id*:int
        # Тип маршрута устройства
        route_type_id*:int
        # Настройки маршрута
        settings*:string

    # Параметр измерения
    DbMeasureParameter* = ref object of DbEntity
        # Название параметра
        name*:string