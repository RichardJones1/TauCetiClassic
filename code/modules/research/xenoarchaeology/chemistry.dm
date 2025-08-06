
//chemistry stuff here so that it can be easily viewed/modified
/datum/reagent/tungsten
	name = "Tungsten"
	id = "tungsten"
	description = "A chemical element, and a strong oxidising agent."
	reagent_state = SOLID
	color = "#dcdcdc"  // rgb: 220, 220, 220, silver

/obj/item/weapon/reagent_containers/glass/solution_tray
	name = "solution tray"
	desc = "A small, open-topped glass container for delicate research samples. It sports a re-useable strip for labelling with a pen."
	icon = 'icons/obj/device.dmi'
	icon_state = "solution_tray"
	m_amt = 0
	g_amt = 5
	w_class = SIZE_TINY
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1, 2)
	volume = 2
	flags = OPENCONTAINER

/obj/item/weapon/reagent_containers/glass/solution_tray/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/pen))
		var/new_label = sanitize_safe(input("What should the new label be?","Label solution tray"), MAX_NAME_LEN)
		if(new_label)
			name = "solution tray ([new_label])"
			to_chat(user, "<span class='notice'>You write on the label of the solution tray.</span>")
	else
		return ..()

/obj/item/weapon/reagent_containers/glass/beaker/water
	name = "beaker 'water'"

/obj/item/weapon/reagent_containers/glass/beaker/water/atom_init()
	. = ..()
	reagents.add_reagent("water",50)
	update_icon()

/obj/item/weapon/reagent_containers/glass/beaker/fuel
	name = "beaker 'fuel'"

/obj/item/weapon/reagent_containers/glass/beaker/fuel/atom_init()
	. = ..()
	reagents.add_reagent("fuel",50)
	update_icon()
