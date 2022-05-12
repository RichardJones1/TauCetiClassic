/obj/structure/vilage
	name = ""
	desc = ""
	icon = 'icons/obj/Events/human/vilage.dmi'
	anchored = TRUE
	layer = 11

/obj/structure/vilage/anvil
	icon_state = "anvil"
	name = "����������"
	desc = "��� ������, ���� ������"
	density = 1

/obj/structure/vilage/fence
	icon_state = "fence"
	name = "�����"
	desc = "�����������"
	density = 1

/obj/structure/sign/poster/banner
	icon = 'icons/obj/Events/human/vilage.dmi'
	icon_state = "banner"
	name = "�����"
	desc = "����� ����� ������"

/obj/structure/vilage/velikiy_sup
	icon_state = "velikiy_sup"
	name = "�����"
	desc = "� ������� ��� ��������.."
	density = 1
	anchored = FALSE
	var/on = FALSE
	var/obj/item/frying = null
	var/fry_time = 0.0


/obj/structure/vilage/velikiy_sup/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/deepfryholder))
		to_chat(user, "<span class='notice'>��� �������.</span>")
		return

	if (ishuman(user) && !(I.flags & DROPDEL))
		to_chat(user, "<span class='notice'>�� ����� [I] � [src].</span>")
		on = TRUE
		frying = I
		user.drop_from_inventory(frying, src)

/obj/structure/vilage/velikiy_sup/process()
	..()
	if(frying)
		fry_time++
		if(fry_time == 30)
			playsound(src, 'sound/effects/water_turf_exited_mob.ogg', VOL_EFFECTS_MASTER)
			visible_message("[src] �����!")
		else if (fry_time == 60)
			visible_message("[src] ������� ����������")

/obj/structure/vilage/velikiy_sup/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(frying)
		to_chat(user, "<span class='notice'>�� ������� [frying] �� [src].</span>")
		var/obj/item/weapon/reagent_containers/food/snacks/deepfryholder/S = new(loc)
		switch(fry_time)
			if(0 to 15)
				S.color = rgb(166,103,54)
				S.name = "������ ����� [frying.name]"
			if(16 to 49)
				S.color = rgb(103,63,24)
				S.name = "��������� �������� [frying.name]"
			if(50 to 59)
				S.color = rgb(63, 23, 4)
				S.name = "[frying.name] � ������"
			if(60 to INFINITY)
				S.color = rgb(33,19,9)
				S.name = "������ ���� ��� ���"
				S.desc = "������� ���-�� ���� ����� - ��� ������ � ���"
		S.appearance = frying.appearance
		S.desc = frying.desc
		qdel(frying)
		user.put_in_hands(S)
		frying = null
		on = FALSE
		fry_time = 0

/obj/machinery/seed_extractor/vilage
	name = "����� ������� �����"
	desc = "������� �������� - �����"
	icon = 'icons/obj/Events/human/vilage.dmi'
	icon_state = "seed"
	use_power = NO_POWER_USE
	seed_multiplier = 2

/obj/machinery/processor/vilage
	name = "��������������"
	desc = "�� ������ ����"
	icon = 'icons/obj/Events/human/vilage.dmi'
	icon_state = "processor"
	use_power = NO_POWER_USE

/obj/machinery/kitchen_machine/microwave/vilage
	name = "������������� �����"
	desc = "� ��� ����� ����������?"
	icon = 'icons/obj/Events/human/vilage.dmi'
	icon_state = "microwave"
	off_icon = "microwave"
	on_icon = "microwave_procces"
	open_icon = "ready"
	use_power = NO_POWER_USE

/obj/machinery/kitchen_machine/oven/vilage
	name = "�����"
	desc = "� ��������!"
	icon = 'icons/obj/Events/human/vilage.dmi'
	icon_state = "oven"
	off_icon = "oven"
	on_icon = "oven_on"
	open_icon = "oven_on"
	use_power = NO_POWER_USE

/obj/machinery/kitchen_machine/grill/vilage
	name = "������"
	desc = "���������, ���������� ��� �������"
	icon = 'icons/obj/Events/human/vilage.dmi'
	icon_state = "grill"
	off_icon = "grill"
	on_icon = "grill_on"
	open_icon = "grill_on"
	use_power = NO_POWER_USE


/obj/structure/tree_of_greed
	name = "���� ����� ��������"
	desc = "��� ������ �������� ���� �� �������, <span class='warning'> �����������...</span>"
	anchored = TRUE
	layer = 11
	icon = 'icons/obj/flora/tree_of_greed.dmi'
	icon_state = "tree_of_greed"
	pixel_x = -48
	pixel_y = -20
	density = 1

/obj/structure/tree_of_greed/attack_hand(mob/living/carbon/human/user)
	var/question = sanitize(input(user, "������� ������ �����."))
	to_chat_admin_pm(usr,"<span class='adminsay'><span class='prefix'>TREE QUESTION:</span> <EM>[key_name(usr, 1)]</EM> (<a href='?_src_=holder;adminplayerobservejump=\ref[user]'>JMP</A>): <span class='message emojify linkify'>[question]</span></span>")
