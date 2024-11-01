# Сущности базы данных

import strformat

# Название таблицы с устройствами
const deviceTableName* = "device"
# Название таблицы с типами устройств
const deviceTypeTableName* = "device_type"

type 
    DbEntity* = ref object of RootObj
        # Идентификатор сущности
        id*:int

    # Модель прибора учета
    DbDevice* = ref object of DbEntity
        # Идентификатор модели
        modelTypeId*:int
        # Специфические настройки модели в формате JSON
        settings*:string

    # Тип прибора учета
    DbDeviceType* = ref object of DbEntity
        # Идентификатор модели
        modelTypeId*:int
        # Название модели
        name*:string

    # Маршрут до устройства
    DbRoute* = ref object of DbEntity
        # Идентификатор устройства к которому относится маршрут
        deviceId*:int
        # Тип маршрута устройства
        routeTypeId*:int
        # Настройки маршрута
        settings*:string

    # Сценарий сбора
    DbCollectorScenario* = ref object of DbEntity
        # Тип расписания
        scheduleType*:int
        # Настройки расписания
        scheduleSettings*:string
        # Ссылка на список устройств сценариев сбора
        deviceListRef*:int

    # Параметр измерения
    DbMeasureParameter* = ref object of DbEntity
        # Идентификатор параметра
        prameterId:int
        # Название параметра        
        name*:string

proc `$`*(this:DbDevice) : string =
    return &"id: {this.id} model_type_id: {this.model_type_id} settings: {this.settings}"