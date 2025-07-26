 // only available at RnD
/obj/item/weapon/pickaxe/excavationdrill
	name = "excavation drill"
	icon = 'icons/obj/xenoarchaeology/tools.dmi'
	icon_state = "excavationdrill0"
	item_state = "excavationdrill"
	excavation_amount = 1
	toolspeed = 0.6
	desc = "Basic archaeological drill combining ultrasonic excitation and bluespace manipulation to provide extreme precision. The tip is adjustable from 1 to 30 cms."
	usesound = 'sound/weapons/thudswoosh.ogg'
	drill_verb = "drilling"
	force = 15.0
	w_class = SIZE_SMALL
	attack_verb = list("drills")
	hitsound = list('sound/weapons/circsawhit.ogg')

/obj/item/weapon/pickaxe/excavationdrill/attack_self(mob/user)
	var/depth = input("Put the desired depth (1-30 centimeters).", "Set Depth", excavation_amount)
	if(depth > 30 || depth < 1)
		to_chat(user, "<span class='notice'>Invalid depth.</span>")
		return
	excavation_amount = depth
	to_chat(user, "<span class='notice'>You set the depth to [excavation_amount]cm.</span>")
	if (excavation_amount < 4)
		icon_state = "excavationdrill0"
	else if (excavation_amount >= 4 && excavation_amount < 8)
		icon_state = "excavationdrill1"
	else if (excavation_amount >= 8 && excavation_amount < 12)
		icon_state = "excavationdrill2"
	else if (excavation_amount >= 12 && excavation_amount < 16)
		icon_state = "excavationdrill3"
	else if (excavation_amount >= 16 && excavation_amount < 20)
		icon_state = "excavationdrill4"
	else if (excavation_amount >= 20 && excavation_amount < 24)
		icon_state = "excavationdrill5"
	else if (excavation_amount >= 24 && excavation_amount < 28)
		icon_state = "excavationdrill6"
	else
		icon_state = "excavationdrill7"

/obj/item/weapon/pickaxe/excavationdrill/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>It is currently set at [excavation_amount]cm.</span>")

/obj/item/weapon/pickaxe/excavationdrill/adv
	name = "diamond excavation drill"
	icon_state = "Dexcavationdrill0"
	item_state = "Dexcavationdrill"
	toolspeed = 0.3
	desc = "Advanced archaeological drill combining ultrasonic excitation and bluespace manipulation to provide extreme precision. The diamond tip is adjustable from 1 to 100 cms."

/obj/item/weapon/pickaxe/excavationdrill/adv/attack_self(mob/user)
	var/depth = input("Put the desired depth (1-100 centimeters).", "Set Depth", excavation_amount)
	if(depth > 100 || depth < 1)
		to_chat(user, "<span class='notice'>Invalid depth.</span>")
		return
	excavation_amount = depth
	to_chat(user, "<span class='notice'>You set the depth to [excavation_amount]cm.</span>")
	if (excavation_amount < 12)
		icon_state = "Dexcavationdrill0"
	else if (excavation_amount >= 12 && excavation_amount < 24)
		icon_state = "Dexcavationdrill1"
	else if (excavation_amount >= 24 && excavation_amount < 36)
		icon_state = "Dexcavationdrill2"
	else if (excavation_amount >= 36 && excavation_amount < 48)
		icon_state = "Dexcavationdrill3"
	else if (excavation_amount >= 48 && excavation_amount < 60)
		icon_state = "Dexcavationdrill4"
	else if (excavation_amount >= 60 && excavation_amount < 72)
		icon_state = "Dexcavationdrill5"
	else if (excavation_amount >= 72 && excavation_amount < 84)
		icon_state = "Dexcavationdrill6"
	else
		icon_state = "Dexcavationdrill7"
