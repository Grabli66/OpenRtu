import ./collector_device
import ./collector_task

type    
    # Интерфейс прикладного драйвера
    IAppLayerDriver* = object
        # Обрабатывает задания от автосбора
        processTasks:proc(
            # Задания для сбора
            tasks:seq[CollectorTasksWithDevice], 
            # Канал: протокол + транспорт
            channel:IProtocolChannel):void