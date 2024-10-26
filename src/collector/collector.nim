# Модуль сборщика данных

import asyncdispatch
import ../database/database as db

# Запускает работу автосбора
proc start*() =
    # Загружает устройства из базы
    # Загружает сценарии сбора из базы
    # Запускает сбор по сценарию сбора
    # Запускает обработку внешних запросы
    discard

# Исполняет внешнее задание
proc executeExternalTask*() : Future[void] =
    discard