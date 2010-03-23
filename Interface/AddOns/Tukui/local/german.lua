
local L = GetLocale()

if L == "deDE" then
	tukuilocal.datatext_guild = "Gilde"
	tukuilocal.datatext_noguild = "Keine Gilde"
	tukuilocal.datatext_bags = "Tasche: "
	tukuilocal.datatext_friends = "Freunde"
	tukuilocal.datatext_online = "Online: "
	tukuilocal.datatext_armor = "Rüstung"
	tukuilocal.datatext_earned = "Erhalten:"
	tukuilocal.datatext_spent = "Ausgegeben:"
	tukuilocal.datatext_deficit = "Differenz:"
	tukuilocal.datatext_profit = "Gewinn:"
	tukuilocal.datatext_wg = "Zeit bis Tausendwinter:"
	tukuilocal.datatext_friendlist = "Freundesliste:"
	tukuilocal.datatext_inprogress = "In Bearbeitung"
	tukuilocal.datatext_unavailable = "Nicht verfügbar"
	tukuilocal.datatext_playersp = "sp"
	tukuilocal.datatext_playerap = "ap"
	tukuilocal.datatext_playerhaste = "haste"
	tukuilocal.datatext_dps = "dps"
	tukuilocal.datatext_hps = "hps"
	tukuilocal.datatext_playerarp = "arp"
	tukuilocal.datatext_session = "Session: "
	tukuilocal.datatext_character = "Charakter: "
	tukuilocal.datatext_server = "Server: "
	tukuilocal.datatext_totalgold = "Gesamt: "
	tukuilocal.datatext_savedraid = "Instanz ID(s)"
	tukuilocal.datatext_currency = "Abzeichen:"
	tukuilocal.datatext_fps = " fps & "
	tukuilocal.datatext_ms = " ms"
	tukuilocal.datatext_playercrit = " crit"
	tukuilocal.datatext_playerheal = " heal"
	tukuilocal.datatext_avoidancebreakdown = "Avoidance Breakdown"
	tukuilocal.datatext_lvl = "lvl"
	tukuilocal.datatext_boss = "boss"
	tukuilocal.datatext_miss = "Miss"
	tukuilocal.datatext_dodge = "Dodge"
	tukuilocal.datatext_block = "Block"
	tukuilocal.datatext_parry = "Parry"
	tukuilocal.datatext_playeravd = "avd: "
	tukuilocal.datatext_servertime = "Server Zeit: "
	tukuilocal.datatext_localtime = "Lokale Zeit: "
	tukuilocal.datatext_mitigation = "Mitigation By Level: "

	tukuilocal.Slots = {
		[1] = {1, "Kopf", 1000},
		[2] = {3, "Schulter", 1000},
		[3] = {5, "Brust", 1000},
		[4] = {6, "Gürtel", 1000},
		[5] = {9, "Handgelenke", 1000},
		[6] = {10, "Hände", 1000},
		[7] = {7, "Beine", 1000},
		[8] = {8, "Füße", 1000},
		[9] = {16, "Main Hand", 1000},
		[10] = {17, "Off Hand", 1000},
		[11] = {18, "Fernkampf", 1000}
	}

	tukuilocal.popup_disableui = "Tukui funktioniert nicht mit deiner Auflösung, möchtest du Tukui ausschalten? (Drücke Abbrechen, falls du eine andere Auflösung testen willst.)"
	tukuilocal.popup_install = "Dies ist das erste mal mit Tukui V10 mit diesem Charakter.Du musst dein UI neuladen um Aktionsleisten, Variabeln und den Chat einzustellen."

	tukuilocal.merchant_repairnomoney = "Du hast nicht genügend Gold zum reparieren!"
	tukuilocal.merchant_repaircost = "Deine Rüstung wurde repariert für"
	tukuilocal.merchant_trashsell = "Dein Trash wurde verkauft und du erhälst"

	tukuilocal.goldabbrev = "|cffffd700g|r"
	tukuilocal.silverabbrev = "|cffc7c7cfs|r"
	tukuilocal.copperabbrev = "|cffeda55fk|r"

	tukuilocal.error_noerror = "Kein Fehler bis jetzt."

	tukuilocal.unitframes_ouf_offline = "Offline"
	tukuilocal.unitframes_ouf_dead = "Tod"
	tukuilocal.unitframes_ouf_ghost = "Geist"
	tukuilocal.unitframes_ouf_lowmana = "WENIG MANA"
	tukuilocal.unitframes_ouf_threattext = "Bedrohung am aktuellen Ziel:"
	tukuilocal.unitframes_ouf_offlinedps = "Offline"
	tukuilocal.unitframes_ouf_deaddps = "TOD"
	tukuilocal.unitframes_ouf_ghostheal = "GEIST"
	tukuilocal.unitframes_ouf_deadheal = "TOD"
	tukuilocal.unitframes_ouf_gohawk = "GO FALKE"
	tukuilocal.unitframes_ouf_goviper = "GO VIPER"
	tukuilocal.unitframes_disconnected = "D/C"

	tukuilocal.tooltip_targetyou = "|cffff4444>>TARGETING YOU<<|r"

	tukuilocal.priest_wsdebuff = "Geschwächte Seele"
	tukuilocal.priest_ifbuff = "Inneres Feuer"

	tukuilocal.bags_noslots = "Kann keine weiteren Taschenplätze kaufen!"
	tukuilocal.bags_costs = "Kosten: %.2f gold"
	tukuilocal.bags_buyslots = "Kaufe neuen Platz mit /bags purchase yes"
	tukuilocal.bags_openbank = "Du musst erst das Bankfach öffnen."
	tukuilocal.bags_sort = "sortiert deine Taschen oder die Bank, falls geöffnet."
	tukuilocal.bags_stack = "stapelt Items neu in deinen Taschen und der Bank, falls geöffnet."
	tukuilocal.bags_buybankslot = "kaufe Bankplatz. (Bank muss geöffnet sein)"
	tukuilocal.bags_search = "Suchen"
	tukuilocal.bags_sortmenu = "Sortieren"
	tukuilocal.bags_sortspecial = "Sortieren Special"
	tukuilocal.bags_stackmenu = "Stapeln"
	tukuilocal.bags_stackspecial = "Stapeln Special"
	tukuilocal.bags_showbags = "Zeige Taschen"
	tukuilocal.bags_sortingbags = "Sortieren fertig."
	tukuilocal.bags_nothingsort= "Nichts zu sortieren."
	tukuilocal.bags_bids = "Benutze Taschen: "
	tukuilocal.bags_stackend = "Neu stapeln fertig."

	tukuilocal.chat_invalidtarget = "Falsches Ziel"

	tukuilocal.mount_wintergrasp = "Tausendwinter"
	
	tukuilocal.playermenu_freeforall = "Jeder gegen Jeden"
	tukuilocal.playermenu_group = "|cff1eff00Plündern als Gruppe|r"
	tukuilocal.playermenu_master = "|cff0070ddPlündermeister|r"
	tukuilocal.playermenu_global_needbeforegreed = "Loot: %sNeed & Greed|r"
	tukuilocal.playermenu_global_freeforall = "Loot: %sJeder gegen Jeden|r"
	tukuilocal.playermenu_global_group = "Loot: %sPlündern als Gruppe|r"
	tukuilocal.playermenu_global_master = "Loot: %sPlündermeister|r"
	tukuilocal.playermenu_normal = "5 |cffffff50Normal|r"
	tukuilocal.playermenu_heroic = "5 |cffff5050Heroic|r"
	tukuilocal.playermenu_raid10 = "10 |cffffff50Normal|r"
	tukuilocal.playermenu_raid25 = "25 |cffffff50Normal|r"
	tukuilocal.playermenu_raid10h = "10 |cffff5050Heroic|r"
	tukuilocal.playermenu_raid25h = "25 |cffff5050Heroic|r"
	
	tukuilocal.core_autoinv_enable = "Autoinvite ON: invite"
	tukuilocal.core_autoinv_enable_c = "Autoinvite ON: "
	tukuilocal.core_autoinv_disable = "Autoinvite OFF"
	tukuilocal.core_wf_unlock = "Quest Tracker unlocked"
	tukuilocal.core_wf_lock = "Quest Tracker lock"
	tukuilocal.core_welcome1 = "Willkommen bei |cffC495DDTukui|r version "
	tukuilocal.core_welcome2 = "Tippe |cff00FFFF/uihelp|r für mehr Informationen"
	
	tukuilocal.core_uihelp1 = "|cff00ff00Allgemeine Slash Befehle|r"
	tukuilocal.core_uihelp2 = "|cffFF0000/tracker|r - Tukui Arena Gegner Cooldown Tracker - Low-memory Gegner PVP cooldown tracker. (Icon only)"
	tukuilocal.core_uihelp3 = "|cffFF0000/rl|r - User Interface neu laden."
	tukuilocal.core_uihelp4 = "|cffFF0000/gm|r - Schicke GM Tickets oder öffnet die WoW Ingame Hilfe."
	tukuilocal.core_uihelp5 = "|cffFF0000/frame|r - Zeigt im chat den Namen des Frame über dem sich die Maus befindet. (Hilfreich für Lua Editoren)"
	tukuilocal.core_uihelp6 = "|cffFF0000/heal|r - Aktiviert Heal Raid Layout."
	tukuilocal.core_uihelp7 = "|cffFF0000/dps|r - Aktiviert DPS/Tank Raid Layout."
	tukuilocal.core_uihelp8 = "|cffFF0000/uf|r - Aktiviert oder Deaktiviert das Bewegen der Unit Frames."
	tukuilocal.core_uihelp9 = "|cffFF0000/bags|r - zum sortieren, kaufen von Bankplätzen oder neu stapeln von Items in deiner Tasche."
	tukuilocal.core_uihelp10 = "|cffFF0000/resetui|r - wiederherstellung der Tukui Original Einstellungen."
	tukuilocal.core_uihelp11 = "|cffFF0000/rd|r - Raid auflösen."
	tukuilocal.core_uihelp12 = "|cffFF0000/wf|r - Befehl um den Blizzard Quest Tracker frei zu verschieben."
	tukuilocal.core_uihelp13 = "|cffFF0000/mss|r - Befehl um die Haltungs(Krieger), Präsenz(Todesritter), Auren(Paladin), Formen(Druide), Schattengestalt(Priester) und Totem(Schamane) Leisten zu bewegen."
	tukuilocal.core_uihelp15 = "|cffFF0000/ainv|r - Aktiviere autoinvite per Flüsterkeyword. Du kannst dein eigenes Keyword setzen, durch tippen von `/ainv myword`"
	tukuilocal.core_uihelp14 = "(Scrolle hoch für mehr Befehle ...)"
	
	tukuilocal.symbol_CLEAR = "Clear"
	tukuilocal.symbol_SKULL = "Schädel"
	tukuilocal.symbol_CROSS = "Kreuz"
	tukuilocal.symbol_SQUARE = "Quadrat"
	tukuilocal.symbol_MOON = "Mond"
	tukuilocal.symbol_TRIANGLE = "Grün"
	tukuilocal.symbol_DIAMOND = "Diamant"
	tukuilocal.symbol_CIRCLE = "Kreis"
	tukuilocal.symbol_STAR = "Stern"
	
	tukuilocal.bind_combat = "Du kannst keine Tasten im Kampf belegen."
	tukuilocal.bind_saved = "Alle Tastenbelegungen wurden gespeichert."
	tukuilocal.bind_discard = "Alle grade neu belegten Tastenbelegungen wurden verworfen."
	tukuilocal.bind_instruct = "Bewege deine Maus über jeglichen Aktionbutton um es mit einem Hotkey zu belegen. Drücke Escape oder Rechte-Maustaste um die aktuelle Tastenbelegeung des Buttons zu löschen."
	tukuilocal.bind_save = "Tastenbelegung speichern"
	tukuilocal.bind_discardbind = "Tastenbelegung verwerfen"
end