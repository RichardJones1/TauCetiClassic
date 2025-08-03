
//////////////////////////////////////////
// Magical claymore - played by a ghost!
/datum/find/magicalclaymore
	find_type = /obj/item/weapon/claymore/light
	find_name = "magical claymore"
	find_cases = list("волшебный клеймор", "волшебного клеймора", "волшебному клеймору", "волшебный клеймор", "волшебным клеймором", "волшебному клеймору")
	find_desc = "Двуручный боевой меч древнего образца. Тяжёлый, устрашающий и смертельно опасный в умелых руках. Рубин на его рукояти странно блестит..."

	find_icon = 'icons/obj/xenoarchaeology/finds.dmi'
	find_icon_state = "talking_claymore"
	find_item_state = "claymore"

	find_origin = ORIGIN_WIZARD
	find_prob = FIND_PROBABILITY_UNCOMMON

/datum/find/magicalclaymore/spawn_find(atom/loc, mob/living/carbon/human/H)
	if(!loc)
		return
	var/obj/item/new_find = new find_type

	stylize_find(new_find)

	var/mob/living/simple_animal/hostile/mimic/copy/magicalclaymore/C = new /mob/living/simple_animal/hostile/mimic/copy/magicalclaymore(loc, new_find, H)
	C.ChangeOwner(H)
	create_spawner(/datum/spawner/living/talkingsword, C)

	H.visible_message("<span class='notice'>[CASE(H, NOMINATIVE_CASE)] достает из породы [new_find]!</span>",
		"<span class='notice'>Вы успешно заканчиваете раскопку, доставая из породы [new_find]!</span>")

/mob/living/simple_animal/hostile/mimic/copy/magicalclaymore
	name = "magical claymore"
	cases = list("волшебный клеймор", "волшебного клеймора", "волшебному клеймору", "волшебный клеймор", "волшебным клеймором", "волшебному клеймору")
	desc = "Двуручный боевой меч древнего образца. Тяжёлый, устрашающий и смертельно опасный в умелых руках. Рубин на его рукояти странно блестит..."
	see_in_dark = 6
	holder_type = /obj/item/weapon/holder/magicalclaymore

/mob/living/simple_animal/hostile/mimic/copy/magicalclaymore/helpReaction(mob/living/attacker, show_message = TRUE)
	if(!ishuman(attacker) || !Adjacent(attacker) || ismob(attacker.loc))
		return ..()
	get_scooped(attacker)

/obj/item/weapon/holder/magicalclaymore
	name = "magical claymore"
	cases = list("волшебный клеймор", "волшебного клеймора", "волшебному клеймору", "волшебный клеймор", "волшебным клеймором", "волшебному клеймору")
	desc = "Двуручный боевой меч древнего образца. Тяжёлый, устрашающий и смертельно опасный в умелых руках. Рубин на его рукояти странно блестит..."

	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "talking_claymore"
	item_state = "claymore"

	force = 20

	w_class = SIZE_SMALL
	flags = HEAR_PASS_SAY

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
