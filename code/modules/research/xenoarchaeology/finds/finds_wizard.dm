//////////////////////////////////////////
// Magical cape - lets you "fly" around
/datum/find/magicalcape
	find_type = /obj/item/clothing/accessory/magicalcape
	find_name = "magical cape"
	find_origin = ORIGIN_WIZARD
	find_prob = FIND_PROBABILITY_UNCOMMON

/obj/item/clothing/accessory/magicalcape
	name = "magical cape"
	cases = list("волшебный плащ", "волшебного плаща", "волшебному плащу", "волшебный плащ", "волшебным плащем", "волшебному плащу")
	desc = "На вид обычный, но ткань этого плаща мерцает, будто отражает иное измерение."
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "magical_cape"
	item_state = "magical_cape"
	slot_flags = SLOT_FLAGS_NECK | SLOT_FLAGS_TIE
	COOLDOWN_DECLARE(flying_cooldown)

	item_action_types = list(/datum/action/item_action/hands_free/magical_cape_fly)

/obj/item/clothing/accessory/magicalcape/attack_self(mob/user)
	fly_away(user)

/obj/item/clothing/accessory/magicalcape/proc/fly_away(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!COOLDOWN_FINISHED(src, flying_cooldown))
		return
	if(!H.neck || H.neck != src)
		to_chat(H, "<span class='warning'>Воротник плаща начинает тускло светиться...</span>")
		return
	COOLDOWN_START(src, flying_cooldown, 2 SECONDS)
	var/atom/target_turf = get_edge_target_turf(H, H.dir)
	H.throw_at(target_turf, 200, 4)
	playsound(get_turf(H), 'sound/magic/Teleport_diss.ogg', VOL_EFFECTS_MASTER, 50)
	new /obj/effect/temp_visual/sparkles(get_turf(H))
	H.visible_message(
		"<span class='notice'>[pick("[H] резко взмывает, словно подхваченный магическим ветром [CASE(src, GENITIVE_CASE)]!", "[capitalize(CASE(src, NOMINATIVE_CASE))] развевается, и [H] стремительно взлетает!", "[capitalize(CASE(src, NOMINATIVE_CASE))] вспыхивает магией, и [H] взлетает!")]</span>",
		"<span class='notice'>[pick("Вы резко взмываете вперед, словно подхваченный магическим ветром [CASE(src, GENITIVE_CASE)]!", "[capitalize(CASE(src, NOMINATIVE_CASE))] развевается, и вы стремительно взлетаете!", "[capitalize(CASE(src, NOMINATIVE_CASE))] вспыхивает магией, и вы взлетаете!")]</span>")

/datum/action/item_action/hands_free/magical_cape_fly
	name = "Сосредоточиться на плаще"
