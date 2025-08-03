
//////////////////////////////////////////
// Clown radio - plays anecdotes
/datum/find/clownradio
	find_type = /obj/item/device/clownradio
	find_name = "pink radio"
	find_origin = ORIGIN_HUMAN
	find_prob = FIND_PROBABILITY_DEBUG

/obj/item/device/clownradio
	name = "pink radio"
	cases = list("радио", "радио", "радио", "радио", "радио", "радио")
	desc = "розовое радио, с виду непримечательно."
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "radio_clown"

	COOLDOWN_DECLARE(anecdote_cooldown)
	COOLDOWN_DECLARE(anecdote_phrase_cooldown)

	var/powered = FALSE
	var/list/anecdotes = list(
		list("В общем, взрывается космическая станция, а на поды успели только трое: парамедик из Вэй Меда, учёный из Киберсан Индастриз и офицер СБ из НаноТразен.",
		"Прилетают поды на Могес, и всех выживших захватывает дикое племя унатхов - несут их к своему главарю.",
		"Привели, а он выжившим и говорит: — Пусть каждый из вас скажет по слову. Если мы это слово не знаем - отпустим, а если знаем - съедим.",
		"Садятся трое выживших и начинают думать. Первым решается высказаться парамедик из Вэй Меда. Встаёт перед главарём племени и гордо выдаёт — Одиссей!",
		"Встают унатхи в круг, шушукаются, шушукаются и говорят: — Это огромный железный лекарь, знаем мы это. И съели парамедика.",
		"Вторым решается высказаться учёный из Киберсан Индастриз. Встаёт перед главарём племени и гордо выдаёт: — Форон!",
		"Встают унатхи в круг, шушукаются, шушукаются и говорят: — Это дорогой уголь, знаем мы это. И съели учёного.",
		"Третьим приходится высказываться офицеру из НаноТразен. Встаёт перед главарём племени и гордо выдаёт: — СОП!",
		"Встают унатхи в круг, шушукаются час, шушукаются второй, пожимают плечами и говорят: — Не знаем мы, что это за вещь такая, СОП ваш. И оставили его жить.",
		"Погостил офицер у племени несколько часов, а вот уже и шаттл из НаноТразен прилетел его спасать.",
		"Взбирается офицер на шаттл, а в догонку унатхи его спрашивают:  — Слушай, ну раз ты уже улетаешь, можешь всё таки скажешь, что же такое этот СОП?",
		"А он и отвечает: — Да хуй его знает."
		),
		list("Плывёт по бескрайним просторам космоса научная станция “Исход”. У себя в каюте, капитан спокойно поедает пончики и потягивает сигару.",
		"Вдруг, его спокойствие прерывает писк факса. Ознакомившись с содержанием присланного отчёта, капитан зовет ХоСа.",
		"— ХоС, плохие новости. Синдикат пульнул по нам новейшей ракетой, аппараты на ЦК засекли её слишком поздно. До попадания три минуты, станции хана.",
		"Ты иди, как нибудь подготовь экипаж, чтобы паники не было и все такое... ХоС собирает весь персонал возле мостика и говорит:",
		"— Спорим, что я хером по стене ёбну и станция развалится? Персонал соглашается. ХоС достает свой хер, бьет им по стене.",
		"БАБАХ!!! Исход вдребезги. Среди обломков и человеческих тел дрейфует уцелевший ХоС в своем риге.",
		"К нему на джетпаке подплетает капитан: — НУ, БЛЯДЬ, И УРОД ТЫ, ХОС!!! РАКЕТА МИМО ПРОШЛА!"
		),
		list("Идёт ассистент по станции, приходит оповещение об аномалии, и вдруг прямо перед ним открывается червоточина.",
		"Ну он засунул в неё руку, вытаскивает - нет руки. Засунул вторую, вытаскивает - нет руки.",
		"Засовывает туда голову и орет: — Вам шо там, блять, делать нехуй?!"
		),
		list("Экзамен на поступление в СБ НаноТразен: В стене сделаны три отверстия разной формы: круглое, квадратное и треугольное.",
		"На столе лежат три фигуры: куб, шар и и пирамида. Задача - вставить фигуру в соответствующее ей отверстие.",
		"Все поступившие делятся на две группы: - супер умные и - супер сильные."
		),
		list("Стоят два СБшника возле торговых автоматов, попивают кофе, жуют пончики.",
		"Мимо них едет мех, останавливается, кричит: — СБ пидорасы! - и пускается наутёк.",
		"Офицеры бегут за ним по коридору, заворачивают за угол, видят, стоит мех и из него вылазит человек.",
		"Они сразу же его хватают за шкирку и давай пиздить кулаками и дубинками. Этот паренёк орет что-то не разбирочивое: -О-д-д-ди!!! О-д-д-и!!!",
		"Но вошедшие в раж СБшники уже забивают его ногами. Всё, лежит он в луже крови, над ним стоят довольные, уставшие офицеры.",
		"Один из них спрашивает: — Ну и чего ты там орал? — Одисей, это, долбаёбы! Я в слипере был!"
		)
	)
	var/list/anecdotes_told = list()
	var/list/current_anecdote = list()
	var/current_phrase = 0
	var/current_anecdote_index = 0

	var/list/anecdotes_laughsounds = list('sound/voice/fake_laugh/laugh1.ogg',
									'sound/voice/fake_laugh/laugh2.ogg',
									'sound/voice/fake_laugh/laugh3.ogg')

/obj/item/device/clownradio/attack_self(mob/user)
	if(do_after(user, 1 SECOND, target = src) && src)
		powered = !powered
		var/powered_verb = "включается"
		if(powered)
			START_PROCESSING(SSobj, src)
		else
			STOP_PROCESSING(SSobj, src)
			powered_verb = "выключается"
		playsound(loc, pick('sound/effects/radio1.ogg', 'sound/effects/radio2.ogg'), VOL_EFFECTS_MASTER, 100, TRUE)
		user.visible_message("[bicon(src)][capitalize(CASE(src, NOMINATIVE_CASE))] с треском [powered_verb]!",
		"Вы нажимаете кнопку на [CASE(src, NOMINATIVE_CASE)], и оно с треском [powered_verb]")

/obj/item/device/clownradio/process()
	if(!COOLDOWN_FINISHED(src, anecdote_cooldown))
		return
	if(!current_anecdote.len) // no current anecdote, lets pick one
		if(!anecdotes.len) // all of the anecdotes had been told, lets reset
			anecdotes = anecdotes_told
		COOLDOWN_START(src, anecdote_cooldown, 10 SECONDS)
		current_anecdote = pick(anecdotes)
		return
	if(!COOLDOWN_FINISHED(src, anecdote_phrase_cooldown))
		return
	COOLDOWN_START(src, anecdote_phrase_cooldown, 6 SECOND)
	if(!current_anecdote_index) // if we havent chosen an anecdote to tell, lets do it now.
		current_anecdote_index = rand(1, anecdotes.len)
		current_anecdote = anecdotes[current_anecdote_index]
	current_phrase += 1
	visible_message("[bicon(src)]<b>[capitalize(CASE(src, NOMINATIVE_CASE))]</b> произносит: \"[current_anecdote[current_phrase]]\"")
	if(current_phrase == current_anecdote.len) // we are done with this one
		playsound(loc, pick(anecdotes_laughsounds), VOL_EFFECTS_MASTER, 100, TRUE)
		anecdotes -= anecdotes[current_anecdote_index]
		anecdotes_told.Add(list(list(current_anecdote)))
		current_anecdote_index = 0
		current_phrase = 0
		current_anecdote = list()
	else
		playsound(loc, pick('sound/effects/radio1.ogg', 'sound/effects/radio2.ogg'), VOL_EFFECTS_MASTER, 100, TRUE)

//////////////////////////////////////////
// Ancient Mining Hud - can see living beings through walls
/datum/find/ancienthud
	find_type = /obj/item/clothing/glasses/hud/mining
	find_name = "strange looking HUD"
	find_cases = list("загадочный HUD", "загадочного HUD", "загадочному HUD", "загадочный HUD", "загадочным HUD", "загадочному HUD")
	find_desc = "Модифицированный визор, имеет встроенные датчики сканирования живых существ."

	find_icon = 'icons/obj/xenoarchaeology/finds.dmi'
	find_icon_state = "HUDmining"
	find_item_state_world = "HUDmining_w"

	find_origin = ORIGIN_HUMAN
	find_prob = FIND_PROBABILITY_COMMON

/datum/find/ancienthud/stylize_find(obj/item/new_find)
	. = ..()
	if(istype(new_find, /obj/item/clothing/glasses/hud/mining))
		var/obj/item/clothing/glasses/hud/mining/M = new_find
		M.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
		M.icon_custom = 'icons/mob/eyes.dmi'
		M.item_state = "glasses"
		M.vision_flags = SEE_MOBS

/datum/find/ancienthud/martian
	find_origin = ORIGIN_MARTIAN
	find_prob = FIND_PROBABILITY_UNCOMMON

/datum/find/ancienthud/precursor
	find_origin = ORIGIN_PRECURSOR
	find_prob = FIND_PROBABILITY_RARE

//////////////////////////////////////////
// Katana - strong weapon with force of 20, that can block
/datum/find/katana
	find_type = /obj/item/weapon/katana
	find_name = "katana"
	find_cases = list("катана", "катаны", "катане", "катана", "катаной", "катане")
	find_desc = "Лезвие катаны острое и прочное, способно быстро прорезать большинство материалов и нанести критический урон врагам в ближнем бою. Также поможет блокировать удары противника."
	find_origin = ORIGIN_HUMAN
	find_prob = FIND_PROBABILITY_COMMON

/datum/find/katana/stylize_find(obj/item/new_find)
	. = ..()
	new_find.force = 20 // default 40 is too overpowered

//////////////////////////////////////////
// Sleepy pen - straight up traitors item. humans are bad for the environment...
/datum/find/sleepypen
	find_type = /obj/item/weapon/pen/sleepypen
	find_name = "pen"
	find_cases = list("ручка", "ручки", "ручке", "ручка", "ручкой", "ручке")
	find_desc = "Обычная, на первый взгляд, ручка. На вес ощущается чуть тяжеловатой."
	find_origin = ORIGIN_HUMAN
	find_prob = FIND_PROBABILITY_UNCOMMON

//////////////////////////////////////////
// Pip-Boy - back in the day people used to wear these
/datum/find/pipboy
	find_type = /obj/item/clothing/gloves/pipboy
	find_name = "pip-boy 3000"
	find_origin = ORIGIN_HUMAN
	find_prob = FIND_PROBABILITY_COMMON

/datum/find/pipboy/mark4
	find_type = /obj/item/clothing/gloves/pipboy/pipboy3000mark4
	find_name = "pip-boy 3000 mark IV"
	find_prob = FIND_PROBABILITY_RARE

/datum/find/pipboy/billion
	find_type = /obj/item/clothing/gloves/pipboy/pimpboy3billion
	find_name = "pimp-boy 3 billion"
	find_prob = FIND_PROBABILITY_MYTHICAL

/obj/item/clothing/gloves/pipboy
	name = "pip-boy 3000"
	cases = list("Пип-бой 3000", "Пип-боя 3000", "Пип-бою 3000", "Пип-бой 3000", "Пип-боем 3000", "Пип-бою 3000")
	desc = "Странного вида девайс с экраном. По ощущениям, его носят на руке. Эта штука видала лучшие дни."
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "pipboy3000"
	item_state = "pipboy3000"
	slot_flags = SLOT_FLAGS_BELT | SLOT_FLAGS_GLOVES
	item_action_types = list(/datum/action/item_action/hands_free/toggle_pip_boy)
	species_restricted = null
	protect_fingers = FALSE
	clipped = TRUE

	var/on = 1 // Is it on.
	var/profile_name = null // Master's name.
	var/screen = 1 // Which screen is currently showing.

	var/alarm_1 = "Истек: 200 лет назад"
	var/alarm_2 = null
	var/alarm_3 = null
	var/alarm_4 = null
	var/alarm_playing = 0 // So they can't abuse alarm's sound

	var/health_analyze_mode = FALSE
	var/output_to_chat = TRUE

/datum/action/item_action/hands_free/toggle_pip_boy
	name = "Включить Пип-Бой"

/datum/action/item_action/hands_free/toggle_pip_boy/Activate()
	var/obj/item/clothing/gloves/pipboy/S = target
	S.open_interface()

/obj/item/clothing/gloves/pipboy/atom_init()
	. = ..()
	START_PROCESSING(SSobj, src)
	icon_state = "[initial(icon_state)]_off"
	on = 0
	verbs -= /obj/item/clothing/gloves/pipboy/verb/switch_off


/obj/item/clothing/gloves/pipboy/process()
	if(alarm_playing == 1)
		return
	if(("[worldtime2text()]" == alarm_1) || ("[worldtime2text()]" == alarm_2) || ("[worldtime2text()]" == alarm_3) || ("[worldtime2text()]" == alarm_4))
		var/turf/T = get_turf(src)
		for(var/mob/M in T)
			for(var/obj/item/clothing/gloves/pipboy/P in M.contents)
				if(P == src)
					M.visible_message("<span class='warning'>[bicon(src)][capitalize(CASE(src, NOMINATIVE_CASE))] громко звенит!</span>")
					alarm_playing = 1
		playsound(src, 'sound/weapons/ring.ogg', VOL_EFFECTS_MASTER)
		if(alarm_playing != 1)
			visible_message("<span class='warning'>[bicon(src)][capitalize(CASE(src, NOMINATIVE_CASE))] громко звенит!</span>")
			alarm_playing = 1
		addtimer(CALLBACK(src, PROC_REF(alarm_stop)), 60)

/obj/item/clothing/gloves/pipboy/proc/alarm_stop()
	alarm_playing = 0
	return

/obj/item/clothing/gloves/pipboy/attackby(obj/item/I, mob/user, params)
	if(iscoil(I) || istype(I, /obj/item/weapon/stock_parts/cell) || iscutter(I) || istype(I, /obj/item/weapon/scalpel))
		return
	return ..()


/obj/item/clothing/gloves/pipboy/verb/open_interface()
	set name = "Открыть Интерфейс"
	set category = "Object"

	if(usr.incapacitated())
		return
	interact(usr)

/obj/item/clothing/gloves/pipboy/verb/switch_off()
	set name = "Выключить"
	set category = "Object"
	icon_state = "[initial(icon_state)]_off"
	playsound(src, 'sound/items/buttonclick.ogg', VOL_EFFECTS_MASTER)
	on = 0
	set_light(0)
	verbs -= /obj/item/clothing/gloves/pipboy/verb/switch_off

/obj/item/clothing/gloves/pipboy/verb/toggle_output()
	set name = "Переключить вывод"
	set category = "Object"

	output_to_chat = !output_to_chat
	if(output_to_chat)
		to_chat(usr, "Теперь сканер выводит данные в чат.")
	else
		to_chat(usr, "Теперь сканер выводит данные в отдельное окно.")

/obj/item/clothing/gloves/pipboy/attack(mob/living/M, mob/living/user, def_zone)
	if(!health_analyze_mode || !on)
		return
	if(!ishuman(M))
		to_chat(user, "<span class = 'warning'>Результаты анализа не собраны. Обнаружена неизвестная анатомия.</span>")
		return
	add_fingerprint(user)
	var/mob/living/carbon/human/H = M
	if(H.species.flags[NO_MED_HEALTH_SCAN])
		to_chat(user, "<span class='userdanger'>Это существо невозможно просканировать.</span>")
		return
	if(H.species.flags[IS_SYNTHETIC] || H.species.flags[IS_PLANT])
		var/message = ""
		if(!output_to_chat)
			message += "<HTML><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>"
			message += get_browse_zoom_style(user.client)
			message += "<title>[M.name]'s scan results</title></head><BODY>"

		message += "<span class = 'notice'>Analyzing Results for ERROR:\n&emsp; Overall Status: ERROR</span><br>"
		message += "&emsp; Key: <font color='blue'>Suffocation</font>/<font color='green'>Toxin</font>/<font color='#FFA500'>Burns</font>/<font color='red'>Brute</font><br>"
		message += "&emsp; Damage Specifics: <font color='blue'>?</font> - <font color='green'>?</font> - <font color='#FFA500'>?</font> - <font color='red'>?</font><br>"
		message += "<span class = 'notice'>Body Temperature: [H.bodytemperature-T0C]&deg;C ([H.bodytemperature*1.8-459.67]&deg;F)</span><br>"
		message += "<span class = 'warning bold'>Warning: Blood Level ERROR: --% --cl.</span><span class = 'notice bold'>Type: ERROR</span><br>"
		message += "<span class = 'notice'>Subject's pulse:</span><font color='red'>-- bpm.</font><br>"

		if(output_to_chat)
			to_chat(user, message)
			return
		message += "</BODY></HTML>"
		user << browse(message, "window=[M.name]_scan_report;[get_browse_size_parameter(user.client, 400, 400)];can_resize=1")
		onclose(user, "[M.name]_scan_report")
		return
	var/dat = health_analyze(M, user, TRUE, output_to_chat)
	if(output_to_chat)
		to_chat(user, dat)
		return
	user << browse(dat, "window=[M.name]_scan_report;[get_browse_size_parameter(user.client, 400, 400)];can_resize=1")
	onclose(user, "[M.name]_scan_report")

/obj/item/clothing/gloves/pipboy/attack_self(mob/user)
	return interact(user)

/obj/item/clothing/gloves/pipboy/interact(mob/user)
	health_analyze_mode = FALSE
	if(on)
		if(profile_name)
			playsound(src, 'sound/items/buttonclick.ogg', VOL_EFFECTS_MASTER)
			var/dat = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>[get_browse_zoom_style(user.client)]</head><body link='#30CC30' alink='white' bgcolor='#1A351A'><font color='#30CC30'>[name]<br>"
			switch(screen)
				if(1)
					dat += "Hello, [profile_name]!<br>"
					dat += "<h3>МЕНЮ</h3>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];menu=2'>ЗДОРОВЬЕ</A><br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];menu=3'>ПРЕДМЕТЫ</A><br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];menu=4'>ДАННЫЕ</A><br>"
					dat += "<br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];close=1'>Закрыть</A><br>"
				if(2)
					health_analyze_mode = TRUE
					dat += "<h3>ЗДОРОВЬЕ</h3>"
					dat += "[capitalize(CASE(src, NOMINATIVE_CASE))] готов анализировать здоровье!"
					dat += "<br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];menu=1'>Вернуться в меню</A><br>"
				if(3)
					dat += "<h3>ПРЕДМЕТЫ</h3>"
					dat += "<A href='byond://?src=\ref[src];menu=1'>Вернуться в меню</A><br>"
					dat += "<br>"
					dat += list_of_items(user)
					dat += "<br>"
				if(4)
					dat += "<h3>ДАННЫЕ</h3>"
					dat += "<br>"
					dat += "СПИСОК БУДИЛЬНИКОВ<br>"
					dat += "<br>"
					for(var/i in 1 to 4)
						dat += "Будильник [i]. Установленное время:      "
						var/current_alarm = null
						switch(i)
							if(1)
								current_alarm = alarm_1
							if(2)
								current_alarm = alarm_2
							if(3)
								current_alarm = alarm_3
							if(4)
								current_alarm = alarm_4
						if(current_alarm)
							dat += "[current_alarm]<br>"
						else
							dat += "НЕ УСТАНОВЛЕНО<br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];setalarm=1'>Установить Будильник 1</A><br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];setalarm=2'>Установить Будильник 2</A><br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];setalarm=3'>Установить Будильник 3</A><br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];setalarm=4'>Установить Будильник 4</A><br>"
					dat += "<br>"
					dat += "<br>"
					dat += "<A href='byond://?src=\ref[src];menu=1'>Вернуться в меню</A><br>"
			dat += "</font></body>"
			user << browse(dat, "window=pipboy")
			onclose(user, "pipboy")
			return
		else
			var/mob/living/U = usr
			create_personality(U)
			to_chat(user, "<span class='notice'>[bicon(src)]Вы успешно создали профиль! Здравствуйте, [profile_name]!</span>")
			return
	else
		icon_state = "[initial(icon_state)]"
		to_chat(user, "<span class='notice'>[bicon(src)]Вы сдуваете пыль с экрана [CASE(src, GENITIVE_CASE)] и нажимаете кнопку питания. Маленький экран радостно загорается. Теперь устройство включено.</span>")
		set_light(2, 1, "#59f65f")
		on = 1
		verbs += /obj/item/clothing/gloves/pipboy/verb/switch_off
		playsound(src, 'sound/mecha/powerup.ogg', VOL_EFFECTS_MASTER, 30)
		return

/obj/item/clothing/gloves/pipboy/Topic(href, href_list, mob/user)
	..()
	usr.set_machine(src)

	if(href_list["menu"]) // Switches menu screens. Converts a sent text string into a number. Saves a LOT of code.
		screen = text2num(href_list["menu"])

	if(href_list["close"])
		usr.unset_machine()
		usr << browse(null, "window=pipboy")
	if(href_list["setalarm"])
		var/newnumberalarm = text2num(href_list["setalarm"])
		create_alarm_clock(usr, newnumberalarm)

	updateSelfDialog()

/obj/item/clothing/gloves/pipboy/proc/create_personality(mob/living/U = usr)
	playsound(src, 'sound/items/buttonclick.ogg', VOL_EFFECTS_MASTER)
	U.visible_message("<span class='notice'>[CASE(U, NOMINATIVE_CASE)] нажимает на экран [CASE(src, GENITIVE_CASE)].</span>")
	U.last_target_click = world.time
	var/t = sanitize(input(U, "Пожалуйста, введите имя", name, null) as text)
	t = replacetext(t, "&#34;", "\"")

	if (!t)
		return

	if (!Adjacent(U))
		return

	if (!(on))
		return

	if(U.incapacitated())
		return

	playsound(src, 'sound/machines/twobeep.ogg', VOL_EFFECTS_MASTER)
	profile_name = "[t]"

/obj/item/clothing/gloves/pipboy/proc/create_alarm_clock(mob/living/U = usr, numb_of_alarm)
	playsound(src, 'sound/items/buttonclick.ogg', VOL_EFFECTS_MASTER)
	U.visible_message("<span class='notice'>[CASE(U, NOMINATIVE_CASE)] нажимает на экран [CASE(src, GENITIVE_CASE)].</span>")
	U.last_target_click = world.time
	var/alarm = sanitize(input(U, "Введите время для будильника(например: 12:00)", name, null) as text)
	switch(numb_of_alarm)
		if(1)
			alarm_1 = "[alarm]"
		if(2)
			alarm_2 = "[alarm]"
		if(3)
			alarm_3 = "[alarm]"
		if(4)
			alarm_4 = "[alarm]"

/obj/item/clothing/gloves/pipboy/proc/list_of_items(mob/user)
	var/message
	var/message_items
	var/message_clothing
	var/mob/living/H = user
	for(var/obj/item/T in H.contents)
		if(T == src)
			continue
		if(istype(T, /obj/item/clothing))
			message_clothing += "[bicon(T)][T.name]<br>"
		else
			if(istype(T, /obj/item/weapon/storage))
				message_clothing += "[bicon(T)][T.name]<br>"
				for(var/obj/item/B in T.contents)
					if(istype(B, /obj/item/clothing))
						message_clothing += "[bicon(B)][B.name]<br>"
					else
						if(istype(B, /obj/item/weapon/storage))
							for(var/obj/item/G in B.contents)
								if(istype(G, /obj/item/clothing))
									message_clothing += "[bicon(G)][G.name]<br>"
								else
									message_items += "[bicon(G)][G.name]<br>"
						message_items += "[bicon(B)][B.name]<br>"
				continue
			else
				message_items += "[bicon(T)][T.name]<br>"

	message = "ОДЕЖДА<br>"
	message += message_clothing
	message += "<br>"
	message += "ПРЕДМЕТЫ<br>"
	message += message_items

	return message

/obj/item/clothing/gloves/pipboy/pimpboy3billion
	name = "pimp-boy 3 billion"
	cases = list("Пимп-бой 3 миллиарда", "Пип-боя 3 милларда", "Пип-бою 3 миллиарда", "Пип-бой 3 миллиарда", "Пип-боем 3 милларда", "Пип-бою 3 миллиарда")
	desc = "Странного вида девайс в корпусе из золота и серебра, с инкрустированными алмазами. Кажется, его носили на руке."
	icon_state = "pimpboy3billion"
	item_state = "pimpboy3billion"

/obj/item/clothing/gloves/pipboy/pipboy3000mark4
	name = "pip-boy 3000 mark IV"
	cases = list("Пип-бой 3000 Марк 4", "Пип-боя 3000 Марк 4", "Пип-бою 3000 Марк 4", "Пип-бой 3000 Марк 4", "Пип-боем 3000 Марк 4", "Пип-бою 3000 Марк 4")
	icon_state = "pipboy3000mark4"
	item_state = "pipboy3000mark4"
