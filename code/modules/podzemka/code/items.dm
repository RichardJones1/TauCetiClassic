
// self-charging flashlight //
/obj/item/device/flashlight/self_charging
	desc = "A hand-held self-charging light. Just spin that hendle, because darkness is bad."
	icon = 'code/modules/podzemka/icons/items.dmi'
	icon_state = "fl"
	item_state = "fl"
	var/power = 30
	var/spinning = FALSE

/obj/item/device/flashlight/self_charging/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, "You cannot turn the light on while in this [user.loc].") // To prevent some lighting anomalities.
		return 0
	if(!on && power <= 0 && !spinning)
		to_chat(user, "You start spinning the handle.")
		spinning = TRUE
		icon_state = "[initial(icon_state)]_turning_on"
		sleep(20)
		power = 30
		spinning = FALSE
	on = !on
	update_brightness(user)
	action_button_name = null
	if(on)
		START_PROCESSING(SSobj, src)
	return 1

/obj/item/device/flashlight/self_charging/Destroy()
	if(on)
		kill_light()
	return ..()

/obj/item/device/flashlight/self_charging/process()
	if(!on)
		STOP_PROCESSING(SSobj, src)
	if(prob(40))
		power--
	if(on && power <= 5)
		icon_state = "[initial(icon_state)]_turning_off"
	if(on && power <= 0)
		on = FALSE
		icon_state = initial(icon_state)
		kill_light()

// metro 2033 guitar //
/obj/item/device/guitar/metro
	name = "old guitar"
	desc = "It's made of wood and has steel strings."
	icon = 'code/modules/podzemka/icons/items.dmi'

// old bandages //
/obj/item/stack/medical
	name = "bandage"
	singular_name = "medical pack"
	icon = 'code/modules/podzemka/icons/items.dmi'
	icon_state = "bandage"
	amount = 5
	max_amount = 5










