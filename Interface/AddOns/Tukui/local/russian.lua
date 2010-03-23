
local L = GetLocale()

if L == "ruRU" then
	tukuilocal.datatext_guild = "Гильдия"
	tukuilocal.datatext_noguild = "Не в Гильдии"
	tukuilocal.datatext_bags = "Сумки: "
	tukuilocal.datatext_friends = "Друзья"
	tukuilocal.datatext_online = "В игре: "
	tukuilocal.datatext_armor = "Броня"
	tukuilocal.datatext_earned = "Получено:"
	tukuilocal.datatext_spent = "Потрачено:"
	tukuilocal.datatext_deficit = "Убыток:"
	tukuilocal.datatext_profit = "Прибыль:"
	tukuilocal.datatext_wg = "Время до Озера:"
	tukuilocal.datatext_friendlist = "Список друзей:"
	tukuilocal.datatext_inprogress = "Идет бой"
	tukuilocal.datatext_unavailable = "Не доступно"
	tukuilocal.datatext_playersp = "sp"
	tukuilocal.datatext_playerap = "ap"
	tukuilocal.datatext_playerhaste = "haste"
	tukuilocal.datatext_dps = "dps"
	tukuilocal.datatext_hps = "hps"
	tukuilocal.datatext_playerarp = "arp"
	tukuilocal.datatext_session = "Сеанс: "
	tukuilocal.datatext_character = "Персонаж: "
	tukuilocal.datatext_server = "Сервер: "
	tukuilocal.datatext_totalgold = "Всего: "
	tukuilocal.datatext_savedraid = "Сохранения:"
	tukuilocal.datatext_currency = "Валюта:"
	tukuilocal.datatext_fps = " к/с & "
	tukuilocal.datatext_ms = " мс"
	tukuilocal.datatext_playercrit = " crit"
	tukuilocal.datatext_playerheal = " heal"
	tukuilocal.datatext_avoidancebreakdown = "Распределение"
	tukuilocal.datatext_lvl = "ур"
	tukuilocal.datatext_boss = "босс"
	tukuilocal.datatext_miss = "Промах"
	tukuilocal.datatext_dodge = "Уклонение"
	tukuilocal.datatext_block = "Блок"
	tukuilocal.datatext_parry = "Парирование"
	tukuilocal.datatext_playeravd = "avd: "
	tukuilocal.datatext_servertime = "Серверное время: "
	tukuilocal.datatext_localtime = "Местное время: "
	tukuilocal.datatext_mitigation = "Уменьшение по уровню: "

	tukuilocal.Slots = {
	  [1] = {1, "Голова", 1000},
	  [2] = {3, "Плечо", 1000},
	  [3] = {5, "Грудь", 1000},
	  [4] = {6, "Пояс", 1000},
	  [5] = {9, "Запястья", 1000},
	  [6] = {10, "Кисти рук", 1000},
	  [7] = {7, "Ноги", 1000},
	  [8] = {8, "Ступни", 1000},
	  [9] = {16, "Правая рука", 1000},
	  [10] = {17, "Левая рука", 1000},
	  [11] = {18, "Оружие дальнего боя", 1000}
	}

	tukuilocal.popup_disableui = "Tukui не работает на этом разрешении, хотите отключить Tukui? (Отмена если хотите попробовать другое разрешение)"
	tukuilocal.popup_install = "Это первый запуск Tukui V10 для этого персонажа. Необходимо перезагрузить интерфейс для настройки Панелей, Переменных и Окон Чата."
	tukuilocal.popup_2raidactive = "Обе рейдовые раскладки активны, пожалуйста, выберите одну."

	tukuilocal.merchant_repairnomoney = "Не достаточно денег на починку!"
	tukuilocal.merchant_repaircost = "Предметы починены за"
	tukuilocal.merchant_trashsell = "Серые предметы проданы и Вы получили"

	tukuilocal.goldabbrev = "|cffffd700з|r"
	tukuilocal.silverabbrev = "|cffc7c7cfс|r"
	tukuilocal.copperabbrev = "|cffeda55fм|r"

	tukuilocal.error_noerror = "Ошибок пока нет."

	tukuilocal.unitframes_ouf_offline = "Оффлайн"
	tukuilocal.unitframes_ouf_dead = "Труп"
	tukuilocal.unitframes_ouf_ghost = "Призрак"
	tukuilocal.unitframes_ouf_lowmana = "МАНА"
	tukuilocal.unitframes_ouf_threattext = "Угроза на цели:"
	tukuilocal.unitframes_ouf_offlinedps = "Оффлайн"
	tukuilocal.unitframes_ouf_deaddps = "Труп"
	tukuilocal.unitframes_ouf_ghostheal = "ПРИЗРАК"
	tukuilocal.unitframes_ouf_deadheal = "ТРУП"
	tukuilocal.unitframes_ouf_gohawk = "Дух Ястреба"
	tukuilocal.unitframes_ouf_goviper = "Дух Гадюки"
	tukuilocal.unitframes_disconnected = "D/C"

	tukuilocal.tooltip_targetyou = "|cffff4444>>ВЫ<<|r"

	tukuilocal.priest_wsdebuff = "Ослабленная душа"
	tukuilocal.priest_ifbuff = "Внутренний огонь"

	tukuilocal.bags_noslots = "невозможно купить еще ячеек!"
	tukuilocal.bags_costs = "Цена: %.2f золотых"
	tukuilocal.bags_buyslots = "Купить новую ячейку коммандой /bags purchase yes"
	tukuilocal.bags_openbank = "Сначала откройте банк."
	tukuilocal.bags_sort = "Сортировать предметы в сумке или банке, если они открыты."
	tukuilocal.bags_stack = "Заполнить неполные стопки в сумках или банке, если они открыты."
	tukuilocal.bags_buybankslot = "купить банковскую ячейку. (банк должен быть открыт)"
	tukuilocal.bags_search = "Поиск"
	tukuilocal.bags_sortmenu = "Сортировать"
	tukuilocal.bags_sortspecial = "Сортировать в спецсумках"
	tukuilocal.bags_stackmenu = "Сложить"
	tukuilocal.bags_stackspecial = "Сложить в спецсумках"
	tukuilocal.bags_showbags = "Показать сумки"
	tukuilocal.bags_sortingbags = "Сортировка завершена."
	tukuilocal.bags_nothingsort= "Нечего сортировать."
	tukuilocal.bags_bids = "Использование сумок: "
	tukuilocal.bags_stackend = "Заполнение завершено."

	tukuilocal.chat_invalidtarget = "Неверная цель"

	tukuilocal.mount_wintergrasp = "Озеро Ледяных Оков"

	tukuilocal.playermenu_freeforall = "Каждый за себя"
	tukuilocal.playermenu_group = "|cff1eff00Групповая|r"
	tukuilocal.playermenu_master = "|cff0070ddРаспределяет ответственный|r"
	tukuilocal.playermenu_global_needbeforegreed = "Добыча: %sПриоритет по нужности|r"
	tukuilocal.playermenu_global_freeforall = "Добыча: %sКаждый за себя|r"
	tukuilocal.playermenu_global_group = "Добыча: %sГрупповая|r"
	tukuilocal.playermenu_global_master = "Добыча: %sРаспределяет ответственный|r"
	tukuilocal.playermenu_normal = "5 |cffffff50Обычный|r"
	tukuilocal.playermenu_heroic = "5 |cffff5050Героический|r"
	tukuilocal.playermenu_raid10 = "10 |cffffff50Обычный|r"
	tukuilocal.playermenu_raid25 = "25 |cffffff50Обычный|r"
	tukuilocal.playermenu_raid10h = "10 |cffff5050Героический|r"
	tukuilocal.playermenu_raid25h = "25 |cffff5050Героический|r"

	tukuilocal.core_autoinv_enable = "Автоприглашение ВКЛ: invite"
	tukuilocal.core_autoinv_enable_c = "Автоприглашение ВКЛ: "
	tukuilocal.core_autoinv_disable = "Автоприглашение ВЫКЛ"
	tukuilocal.core_wf_unlock = "Окно отслеживания заданий разблокировано"
	tukuilocal.core_wf_lock = "Окно отслеживания заданий закреплено"
	tukuilocal.core_welcome1 = "Welcome on |cffC495DDTukui|r version "
	tukuilocal.core_welcome2 = "Type |cff00FFFF/uihelp|r for more infos"
	
	tukuilocal.core_uihelp1 = "|cff00ff00Общие комманды|r"
	tukuilocal.core_uihelp2 = "|cffFF0000/tracker|r - Tukui Arena Enemy Cooldown Tracker - PVP-таймер вражеских перезарядок . (только иконка)"
	tukuilocal.core_uihelp3 = "|cffFF0000/rl|r - Перезагрузить интерфейс."
	tukuilocal.core_uihelp4 = "|cffFF0000/gm|r - Связь с ГМ-ом и игровая помощь."
	tukuilocal.core_uihelp5 = "|cffFF0000/frame|r - Показать имя рамки под курсором мыши. (очень удобно для редактирования LUA)"
	tukuilocal.core_uihelp6 = "|cffFF0000/heal|r - Включить healing раскладку рейдовых фремов."
	tukuilocal.core_uihelp7 = "|cffFF0000/dps|r - Включить Dps/Tank раскладку рейдовых фреймов."
	tukuilocal.core_uihelp8 = "|cffFF0000/uf|r - ВКЛ/ВЫКЛ перемещение рамок юнитов."
	tukuilocal.core_uihelp9 = "|cffFF0000/bags|r - сортировка, покупка банковских ячеек и складывание предметов в ваших сумках."
	tukuilocal.core_uihelp10 = "|cffFF0000/resetui|r - сбросить переменные и настройки чата в значения Tukui по умолчанию"
	tukuilocal.core_uihelp11 = "|cffFF0000/rd|r - распустить рейд."
	tukuilocal.core_uihelp12 = "|cffFF0000/wf|r - разблокировать окно отслеживания заданий для перемещения."
	tukuilocal.core_uihelp13 = "|cffFF0000/mss|r - передвинуть панель стоек/тотемов."
	tukuilocal.core_uihelp15 = "|cffFF0000/ainv|r - Включить автоприглашение по слову. Вы можете установить нужное слово, напечатав `/ainv слово`"
	tukuilocal.core_uihelp14 = "(Прокрутите вверх, чтобы увидеть больше комманд ...)"
	
	tukuilocal.symbol_CLEAR = "Очистить"
	tukuilocal.symbol_SKULL = "Череп"
	tukuilocal.symbol_CROSS = "Крест"
	tukuilocal.symbol_SQUARE = "Квадрат"
	tukuilocal.symbol_MOON = "Полумесяц"
	tukuilocal.symbol_TRIANGLE = "Треугольник"
	tukuilocal.symbol_DIAMOND = "Ромб"
	tukuilocal.symbol_CIRCLE = "Круг"
	tukuilocal.symbol_STAR = "Звезда"
	
	tukuilocal.bind_combat = "Вы не можете назначать клавиши в бою."
	tukuilocal.bind_saved = "Все назначения клавиш сохранены."
	tukuilocal.bind_discard = "Все новые назначения клавиш были отменены."
	tukuilocal.bind_instruct = "Наведите указатель мыши на кнопку действия, чтобы назначить клавишу. Нажмите клавишу ESC или правую кнопку мыши чтобы убрать назначение."
	tukuilocal.bind_save = "Сохранить назначения"
	tukuilocal.bind_discardbind = "Отменить назначения"
end

