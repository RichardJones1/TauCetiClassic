/obj/item/uncurs_ointment
	name = "�������� ���������"
	desc = "���������. ����� ������ �� �����."
	icon = 'icons/obj/items.dmi'
	icon_state = "ointment"
	item_state = "ointment"

/obj/item/uncurs_ointment/attack(mob/living/simple_animal/chicken/C, mob/user)
	var/mob/living/M = C
	if(C.health == 0 )
		to_chat(user, "<span class='notice'> ��� �������� ������</span>")
		return
	if(!M.MyTrueNotChikenBody)
		to_chat(user, "<span class='notice'> ��� �� ������ ���������.</span>")
		return
	M.MyTrueNotChikenBody.loc = M.loc
	M.mind.transfer_to(M.MyTrueNotChikenBody)
	M.MyTrueNotChikenBody.health = M.health
	M.MyTrueNotChikenBody.MyTrueNotChikenBody = null
	playsound(M, 'sound/Event/uncursed.ogg', VOL_EFFECTS_MASTER)
	qdel(C)
	qdel(src)

