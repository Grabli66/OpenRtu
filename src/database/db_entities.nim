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

    # Сценарий сбора
    DbCollectScenario* = ref object of DbEntity
        # Тип расписания
        scheduleType*:int
        # Настройки расписания
        scheduleSettings*:string
        # Ссылка на список устройств сценариев сбора
        deviceListRef*:int

    # Элемент списка устройств сценария сбора
    DbCollectScenarioDeviceListItem* = ref object of DbEntity
        # Ссылка на список устройств сценариев сбора
        deviceListRef*:int
        # Идентификатор устройства
        deviceId*:int

    # Параметр измерения
    DbMeasureParameter* = ref object of DbEntity
        # Название параметра
        name*:string

proc `$`*(this:DbDevice) : string =
    return &"id: {this.id} model_type_id: {this.model_type_id} settings: {this.settings}"