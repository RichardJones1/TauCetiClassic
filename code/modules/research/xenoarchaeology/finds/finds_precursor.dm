//////////////////////////////////////////
// Ancient Armor - completely laserproof armor
/datum/find/ancient_laserproof
	find_type = /obj/item/clothing/suit/armor/ancient_laserproof
	find_name = "ancient armor"

	find_origin = ORIGIN_PRECURSOR
	find_prob = FIND_PROBABILITY_COMMON

/datum/find/ancient_laserproof/spawn_find(atom/loc, mob/living/carbon/human/H)
	. = ..()
	new /obj/item/clothing/head/helmet/ancient_laserproof(loc)

/obj/item/clothing/suit/armor/ancient_laserproof
	name = "ancient armor"
	cases = list("древняя космическая броня", "древней космической брони", "древней космической броне", "древнюю космическую броню", "древней космической бронёй", "древней космической броне")
	desc = "Доспех, состоящий из переплетающихся пластин, напоминающих крылья бабочки. Материал не поддается стандартному анализу - при ударе по поверхности возникают концентрические волны света, расходящиеся от точки воздействия. В местах соединения пластин заметны следы неизвестной технологии сборки."
	icon_state = "ancient_laserproof"
	item_state = "ancient_laserproof"
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	pierce_protection = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(
		melee = 65,
		bullet = 55,
		energy = 100,
		laser = 0,
		bomb = 20,
		bio = 100,
		rad = 100
	)
	flags_inv = HIDEJUMPSUIT|HIDEGLOVES|HIDESHOES
	w_class = SIZE_NORMAL
	gas_transfer_coefficient = 0
	permeability_coefficient = 0
	slowdown = 0.7
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0
	flags_pressure = STOPS_LOWPRESSUREDMAGE
	allowed = list(/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy, /obj/item/weapon/gun/projectile, /obj/item/ammo_box/magazine, /obj/item/ammo_casing, /obj/item/weapon/melee/baton, /obj/item/weapon/handcuffs, /obj/item/weapon/tank/jetpack)
	heat_protection = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/suit/armor/ancient_laserproof/IsReflect(def_zone)
	if(!(def_zone in body_parts_covered))
		return FALSE
	return TRUE

/obj/item/clothing/suit/armor/ancient_laserproof/equipped(mob/user, slot)
	..()
	if(slot == SLOT_WEAR_SUIT)
		to_chat(user, "<span class='notice'>Вы чувствуете, как древние технологии оживают вокруг вас, создавая защитное силовое поле.</span>")
		playsound(user, 'sound/magic/charge.ogg', 100, 1)

/obj/item/clothing/suit/armor/ancient_laserproof/dropped(mob/user)
	..()
	to_chat(user, "<span class='notice'>Защитное поле исчезает по мере того, как вы снимаете броню.</span>")

/obj/item/clothing/head/helmet/ancient_laserproof
	name = "ancient helmet"
	cases = list("древний космическая шлем", "древний космической шлем", "древнем космическом шлеме", "древний космический шлем", "древним космическим шлемом", "древнем космическом шлеме")
	desc = "Шлем из неизвестного металла, поверхность которого кажется одновременно матовой и бесконечно отражающей. При повороте под разными углами создается иллюзия, будто сквозь него видны звезды. На внутренней стороне выгравированы странные символы, пульсирующие слабым голубым свечением."
	icon_state = "ancient_laserproof"
	item_state = "ancient_laserproof"
	armor = list(
		melee = 65,
		bullet = 55,
		energy = 100,
		laser = 0,
		bomb = 20,
		bio = 100,
		rad = 100
	)
	flags = HEADCOVERSEYES | HEADCOVERSMOUTH | PHORONGUARD
	render_flags = parent_type::render_flags | HIDE_ALL_HAIR
	flags_pressure = STOPS_LOWPRESSUREDMAGE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	permeability_coefficient = 0
	siemens_coefficient = 0
	heat_protection = HEAD

/obj/item/clothing/head/helmet/ancient_laserproof/IsReflect(def_zone)
	return TRUE // 100% chance to reflect

/obj/item/clothing/head/helmet/ancient_laserproof/equipped(mob/user, slot)
	..()
	if(slot == SLOT_HEAD)
		to_chat(user, "<span class='notice'>Вы чувствуете, как древние технологии оживают вокруг вас, создавая защитное силовое поле.</span>")
		playsound(user, 'sound/magic/charge.ogg', 100, 1)

/obj/item/clothing/head/helmet/ancient_laserproof/dropped(mob/user)
	..()
	to_chat(user, "<span class='notice'>Защитное поле исчезает по мере того, как вы снимаете шлем.</span>")
