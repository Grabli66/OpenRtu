import ../../common/ischedule
import ./collector_parameter
import ./collector_device

type
    # Сценарий сбора
    CollectorScenario* = object
        # Идентификатор сценария
        id:int
        # Расписание сценария
        schedule:ISchedule
        # Глубина сбора в днях
        deepDay:int
        # Параметры измерения
        measureParameters:seq[CollectorParameter]
        # Устройства сбора
        devices:seq[CollectorDevice]

# Создаёт новый сценарий сбора
proc newCollectorScenario*(
        id:int, schedule:ISchedule,
        deepDay:int, measureParameters:seq[CollectorParameter],
        devices:seq[CollectorDevice]):CollectorScenario =
    return CollectorScenario(
        id:id,
        schedule:schedule,
        deepDay:deepDay,
        measureParameters:measureParameters,
        devices:devices
    )

# Возвращает id
proc id*(this:CollectorScenario):int =
    return this.id

# Возвращает schedule
proc schedule*(this:CollectorScenario):ISchedule =
    return this.schedule

# Возвращает deepDay
proc deepDay*(this:CollectorScenario):int =
    return this.deepDay

# Возвращает measureParameters
proc measureParameters*(this:CollectorScenario):seq[CollectorParameter] =
    return this.measureParameters

# Возвращает devices
proc devices*(this:CollectorScenario):seq[CollectorDevice] =
    return this.devices