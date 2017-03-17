/obj/item/weapon/spacecash
	name = "0 credit chip"
	desc = "It's worth 0 credits."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "spacecash"
	opacity = 0
	density = 0
	anchored = 0.0
	force = 1.0
	throwforce = 1.0
	throw_speed = 1
	throw_range = 2
	w_class = 2.0
	var/access = list()
	access = access_crate_cash
	var/worth = 0

/obj/item/weapon/spacecash/New()
	..()
	price = worth

/obj/item/weapon/spacecash/c1
	name = "1 token"
	icon_state = "token"
	desc = "It's worth 1 token."
	worth = 1

/obj/item/weapon/spacecash/c10
	name = "10 tokens"
	icon_state = "moretokens"
	desc = "It's worth 10 tokens."
	worth = 10

/obj/item/weapon/spacecash/c20
	name = "20 tokens"
	icon_state = "moretokens"
	desc = "It's worth 20 tokens."
	worth = 20

/obj/item/weapon/spacecash/c50
	name = "50 tokens"
	icon_state = "moretokens"
	desc = "It's worth 50 tokens."
	worth = 50

/obj/item/weapon/spacecash/c100
	name = "100 tokens"
	icon_state = "moretokens"
	desc = "It's worth 100 tokens."
	worth = 100

/obj/item/weapon/spacecash/c200
	name = "200 tokens"
	icon_state = "moretokens"
	desc = "It's worth 200 tokens."
	worth = 200

/obj/item/weapon/spacecash/c500
	name = "500 tokens"
	icon_state = "moretokens"
	desc = "It's worth 500 tokens."
	worth = 500

/obj/item/weapon/spacecash/c1000
	name = "1000 credit chip"
	icon_state = "spacecash1000"
	desc = "It's worth 1000 credits."
	worth = 1000

proc/spawn_money(sum, spawnloc)
	var/cash_type
	for(var/i in list(1000,500,200,100,50,20,10,1))
		cash_type = text2path("/obj/item/weapon/spacecash/c[i]")
		while(sum >= i)
			sum -= i
			new cash_type(spawnloc)
	return

/obj/item/weapon/spacecash/ewallet
	name = "Charge card"
	icon_state = "efundcard"
	desc = "A card that holds an amount of money."
	var/owner_name = "" //So the ATM can set it so the EFTPOS can put a valid name on transactions.

/obj/item/weapon/spacecash/ewallet/examine(mob/user)
	..()
	if(src in view(1, user))
		to_chat(user, "<span class='notice'>Charge card's owner: [src.owner_name]. Credits remaining: [src.worth].</span>")
