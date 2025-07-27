////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Boulders - sometimes turn up after excavating turf - excavate further to try and find large xenoarch finds

/obj/structure/boulder
	name = "rocky debris"
	desc = "Leftover rock from an excavation, it's been partially dug out already but there's still a lot to go."
	icon = 'icons/obj/mining.dmi'
	icon_state = "boulder1"
	density = TRUE
	opacity = 1
	anchored = TRUE
	var/excavation_level = 0
	var/datum/artifact_find/artifact_find
	var/datum/minigame/excavation/Game

/obj/structure/boulder/atom_init()
	. = ..()
	icon_state = "boulder[rand(1, 4)]"

/obj/structure/boulder/proc/setup_excavation_game()
	if(!artifact_find)
		return
	Game = new()
	Game.setup_game()

/obj/structure/boulder/attackby(obj/item/weapon/W, mob/user)
	user.SetNextMove(CLICK_CD_RAPID)

	if (user.is_busy(src))
		return

	if (istype(W, /obj/item/device/depth_scanner))
		var/obj/item/device/depth_scanner/C = W
		C.scan_atom(user, src)
		return

	if (istype(W, /obj/item/weapon/sledgehammer))
		var/obj/item/weapon/sledgehammer/S = W
		if(HAS_TRAIT(S, TRAIT_DOUBLE_WIELDED))
			user.do_attack_animation(src)
			shake_camera(user, 1, 0.37)
			playsound(src, 'sound/misc/sledgehammer_hit_rock.ogg', VOL_EFFECTS_MASTER)
			crumble_away(FALSE)
		else
			to_chat(user, "<span class='warning'>You need to take it with both hands to break it!</span>")

	if (istype(W, /obj/item/weapon/pickaxe))
		var/obj/item/weapon/pickaxe/P = W

		to_chat(user, "<span class='warning'>You start [P.drill_verb] [src].</span>")

		if(!W.use_tool(src, user, 2 SECONDS, volume = 100))
			return

		if(artifact_find)
			to_chat(user, "<span class='notice'>Seems like there is something inside!</span>")
			tgui_interact(user)
		else
			to_chat(user, "<span class='notice'>You finish [P.drill_verb] [src].</span>")
			excavation_level += P.excavation_amount
			if(excavation_level > 150)
				crumble_away(FALSE)

/obj/structure/boulder/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Excavation")
		ui.open()

/obj/structure/boulder/tgui_data(mob/user)
	var/list/data = list()

	data["grid"] = Game.grid
	data["width"] = Game.grid_x*30
	data["height"] = Game.grid_y*30
	data["n_title"] = "Раскопка артефакта"

	return data

/obj/structure/boulder/tgui_act(action, params)
	. = ..()
	if(.)
		return
	if(action == "button_press")
		if(Game.button_press(text2num(params["choice_y"]), text2num(params["choice_x"])))
			playsound(src, 'sound/items/pickaxe.ogg', VOL_EFFECTS_MASTER, 80, TRUE)
		else
			crumble_away(FALSE)
			SStgui.close_uis(src)
			return TRUE

	if(Game.check_complete())
		crumble_away(TRUE)
		SStgui.close_uis(src)
	return TRUE

/obj/structure/boulder/proc/crumble_away(successfull = FALSE)
	if(artifact_find)
		if(successfull)
			var/spawn_type = artifact_find.artifact_find_type
			var/obj/O = new spawn_type(get_turf(src))
			if(istype(O,/obj/machinery/artifact))
				var/obj/machinery/artifact/A = O
				if(A.first_effect)
					A.first_effect.artifact_id = artifact_find.artifact_id
			visible_message("<span class='notice'>[src] suddenly crumbles away, revealing [O.name].</span>")
		else
			visible_message("<span class='danger'>[src] suddenly crumbles away.</span>",\
			"<span class='danger'>[src] has disintegrated under your onslaught, any secrets it was holding are long gone.</span>")
	else
		visible_message("<span class='warning'>[src] crumbles away.</span>")
	qdel(src)

/obj/structure/boulder/Bumped(AM)
	. = ..()
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(istype(H.l_hand, /obj/item/weapon/pickaxe))
			attackby(H.l_hand, H)
		else if(istype(H.r_hand, /obj/item/weapon/pickaxe))
			attackby(H.r_hand, H)

	else if(isrobot(AM))
		var/mob/living/silicon/robot/R = AM
		if(istype(R.module_active, /obj/item/weapon/pickaxe))
			attackby(R.module_active, R)

	else if(istype(AM, /obj/mecha))
		var/obj/mecha/M = AM
		if(istype(M.selected, /obj/item/mecha_parts/mecha_equipment/drill))
			M.selected.action(src)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Strange rocks
// Can give a find. Has a chance of giving nothing

/obj/item/weapon/ore/strangerock
	name = "Strange rock"
	desc = "Seems to have some unusal strata evident throughout it."
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "strange"
	var/datum/find/find_inside
	origin_tech = "materials=5"

/obj/item/weapon/ore/strangerock/atom_init(mapload, find)
	. = ..()
	if(find)
		find_inside = find

/obj/item/weapon/ore/strangerock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/pickaxe/brush))
		if(I.use_tool(src, user, 20, volume = 50))
			reveal_find("is brushed", 20) // 20% to get the item
			qdel(src)
			return

	if(iswelding(I))
		var/obj/item/weapon/weldingtool/WT = I
		user.SetNextMove(CLICK_CD_INTERACT)
		if(WT.use_tool(src, user, 20, volume = 50))
			if(WT.isOn())
				if(WT.get_fuel() >= 4)
					reveal_find("burns", 35) // 35% to get the item
					qdel(src)
					WT.use(4)
				else
					visible_message("<span class='info'>A few sparks fly off [src], but nothing else happens.</span>")
					WT.use(1)
		return

	. = ..()
	if(prob(33))
		visible_message("<span class='warning'>[src] crumbles away, leaving some dust and gravel behind.</span>")
		qdel(src)

/obj/item/weapon/ore/strangerock/proc/reveal_find(tool_verb, prob_chance)
	if(!find_inside)
		visible_message("<span class='notice'>\The [src] reveals nothing!</span>")
		return
	if(prob(prob_chance))
		find_inside.spawn_find(get_turf(src))
		visible_message("<span class='notice'>\The [src] [tool_verb] away revealing something!</span>")
	else
		visible_message("<span class='warning'>\The [src] [tool_verb] away, but something that was inside crumbles into dust!</span>")
