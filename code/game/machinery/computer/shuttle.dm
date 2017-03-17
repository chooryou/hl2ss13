/obj/machinery/computer/shuttle
	name = "Shuttle"
	desc = "For shuttle control."
	icon_state = "shuttle"
	var/auth_need = 3.0
	var/list/authorized = list()

	light_color = "#7BF9FF"


	attackby(obj/item/weapon/card/W, mob/user)
		if(stat & (BROKEN|NOPOWER))	return
		if ((!( istype(W, /obj/item/weapon/card) ) || !( ticker ) || SSshuttle.location != 1 || !( user )))	return
		if (istype(W, /obj/item/weapon/card/id)||istype(W, /obj/item/device/pda))
			if (istype(W, /obj/item/device/pda))
				var/obj/item/device/pda/pda = W
				W = pda.id
			if (!W:access) //no access
				to_chat(user, "The access level of [W:registered_name]\'s card is not high enough. ")
				return

			var/list/cardaccess = W:access
			if(!istype(cardaccess, /list) || !cardaccess.len) //no access
				to_chat(user, "The access level of [W:registered_name]\'s card is not high enough. ")
				return

			if(!(access_heads in W:access)) //doesn't have this access
				to_chat(user, "The access level of [W:registered_name]\'s card is not high enough. ")
				return 0

			var/choice = alert(user, text("Would you like to (un)authorize a shortened launch time? [] authorization\s are still needed. Use abort to cancel all authorizations.", src.auth_need - src.authorized.len), "Shuttle Launch", "Authorize", "Repeal", "Abort")
			if(SSshuttle.location != 1 && user.get_active_hand() != W)
				return 0
			switch(choice)
				if("Authorize")
					src.authorized -= W:registered_name
					src.authorized += W:registered_name
					if (src.auth_need - src.authorized.len > 0)
						message_admins("[key_name_admin(user)] has authorized early shuttle launch")
						log_game("[user.ckey] has authorized early shuttle launch")
						to_chat(world, text("\blue <B>Alert: [] authorizations needed until shuttle is launched early</B>", src.auth_need - src.authorized.len))
					else
						message_admins("[key_name_admin(user)] has launched the shuttle")
						log_game("[user.ckey] has launched the shuttle early")
						to_chat(world, "\blue <B>Alert: Shuttle launch time shortened to 10 seconds!</B>")
						SSshuttle.online = 1
						SSshuttle.settimeleft(10)
						src.authorized.Cut()

				if("Repeal")
					src.authorized -= W:registered_name
					to_chat(world, text("\blue <B>Alert: [] authorizations needed until shuttle is launched early</B>", src.auth_need - src.authorized.len))

				if("Abort")
					to_chat(world, "\blue <B>All authorizations to shortening time for shuttle launch have been revoked!</B>")
					src.authorized.Cut()

		else if (istype(W, /obj/item/weapon/card/emag) && !emagged)
			var/choice = alert(user, "Would you like to launch the shuttle?","Shuttle control", "Launch", "Cancel")

			if(!emagged && SSshuttle.location == 1 && user.get_active_hand() == W)
				switch(choice)
					if("Launch")
						to_chat(world, "\blue <B>Alert: Shuttle launch time shortened to 10 seconds!</B>")
						SSshuttle.settimeleft( 10 )
						emagged = 1
					if("Cancel")
						return
		return
