--Corrupt Cards

--[[SMODS.ConsumableType({
	key = "Corrupt",

	collection_rows = { 4, 5 },
	primary_colour = SMODS.Gradients["crv_corrupt"],
	secondary_colour = SMODS.Gradients["crv_corrupt"],
	default = "c_crv_corruption",
})

SMODS.Consumable({
	key = "corruption",
	set = "Corrupt",
	pos = {
		x = 0,
		y = 0,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = { cards = nil },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return RevosVault.check("inblind")
	end,
	use = function(self, card, area, copier)
		RevosVault.defeat()
		ease_ante(-1)
		local destroytab = {}
		local suit = pseudorandom_element(SMODS.Suits, pseudoseed("corruption")).key
		for i = 1, #G.playing_cards do
			if G.playing_cards[i]:is_suit(suit, nil, true) then
				destroytab[#destroytab + 1] = G.playing_cards[i]
			end
		end
		SMODS.destroy_cards(destroytab)
	end,
})

SMODS.Consumable({
	key = "broken",
	set = "Corrupt",
	pos = {
		x = 1,
		y = 0,
	},
	discovered = true,
	config = {
		extra = { cards = true, actv = nil, timer = 0, max = 2 },
	},
	atlas = "corrupt",
	keep_on_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		if RevosVault.check("hasjoker") == true and card.ability.extra.cards == true then
			return true
		end
	end,
	use = function(self, card, area, copier)
		card.ability.extra.cards = false
		card.ability.extra.actv = true
		local acard = RevosVault.random_joker(G.jokers.cards)
		SMODS.destroy_cards(acard)
		local eval = function()
			return card.ability.extra.actv == true
		end
		juice_card_until(card, eval, true)
	end,
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.starting_shop then
			if crv.actv == true then
				if crv.timer >= crv.max then
					RevosVault.shop_card(pseudorandom_element(G.P_JOKER_RARITY_POOLS[3]), true, "Joker", true)
					SMODS.destroy_cards(card)
				else
					crv.timer = crv.timer + 1
				end
			end
		end
	end,
})

SMODS.Consumable({
	key = "dishonour",
	set = "Corrupt",
	pos = {
		x = 2,
		y = 0,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = { odds = 3 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		if RevosVault.check("hasjoker") then
			return true
		end
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		if G.GAME.talisman == 1 then
			ease_dollars(to_number(-G.GAME.dollars))
		else
			ease_dollars(-G.GAME.dollars)
		end
		if pseudorandom("dishonour") < G.GAME.probabilities.normal / crv.odds then
			local joktab = {}
			for i = 1, #G.jokers.cards do
				if not G.jokers.cards[i].edition then
					joktab[#joktab + 1] = G.jokers.cards[i]
				end
			end
			RevosVault.random_joker(joktab):set_edition("e_negative")
		else
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					attention_text({
						text = localize("k_nope_ex"),
						scale = 1.3,
						hold = 1.4,
						major = card,
						backdrop_colour = SMODS.Gradients["crv_corrupt"],
						align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm",
						offset = {
							x = 0,
							y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0,
						},
						silent = true,
					})
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound("tarot2", 0.76, 0.4)
							return true
						end,
					}))
					play_sound("tarot2", 1, 0.4)
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "fraud",
	set = "Corrupt",
	pos = {
		x = 3,
		y = 0,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		ease_dollars(-50)
		G.GAME.crv_cashout = G.GAME.crv_cashout + 3
	end,
})

SMODS.Consumable({
	key = "loneliness",
	set = "Corrupt",
	pos = {
		x = 4,
		y = 0,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		return RevosVault.check("highlight", G.jokers) == 1
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		for i = 1, #G.jokers.highlighted do
			G.jokers.highlighted[i]:set_edition("e_negative")
			if pseudorandom("loneliness") < G.GAME.probabilities.normal / 3 then
				SMODS.Stickers["crv_sharpedge"]:apply(G.jokers.highlighted[i], true)
			end
		end
	end,
})

SMODS.Consumable({
	key = "fall",
	set = "Corrupt",
	pos = {
		x = 0,
		y = 1,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {
			usable = true,
			weg = nil,
			timer = 0,
			max = 3,
		},
	},
	keep_on_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		return card.ability.extra.usable == true
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		ease_dollars(50)
		crv.weg = SMODS.ObjectTypes["Joker"].rarities[1].weight
		SMODS.ObjectTypes["Joker"].rarities[1].weight = 9999999999999999999999999999999
		card.ability.extra.usable = false
		local eval = function()
			card.ability.extra.usable = false
		end
		juice_card_until(card, eval, true)
	end,
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if card.ability.extra.usable == false then
			if context.end_of_round and not context.blueprint then
				if crv.timer < crv.max then
					crv.timer = crv.timer + 1
				else
					SMODS.ObjectTypes["Joker"].rarities[1].weight = crv.weg
					SMODS.destroy_cards(card)
				end
			end
		end
	end,
})

--[[SMODS.Consumable({
	key = "crysis",
	set = "Corrupt",
	pos = {
		x = 0,
		y = 0,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {}},
	keep_on_use = function(self,card)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
	can_use = function(self, card)
	end,	
	use = function(self, card, area, copier)
	end,
	calculate = function(self,card,context)
	end
})]]

--[[SMODS.Consumable({
	key = "ruthless",
	set = "Corrupt",
	pos = {
		x = 0,
		y = 0,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {}},
	keep_on_use = function(self,card)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
	can_use = function(self, card)
	end,	
	use = function(self, card, area, copier)
	end,
	calculate = function(self,card,context)
	end
})

SMODS.Consumable({
	key = "dept",
	set = "Corrupt",
	pos = {
		x = 1,
		y = 1,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {
			dept = 30,
		},
	},
	keep_on_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		return card.ability.extra.usable == true
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		ease_dollars(-(G.GAME.dollars + crv.dept))
		G.GAME.crv_payout = G.GAME.crv_payout + 0.5
	end,
})

SMODS.Consumable({
	key = "apocalypse",
	set = "Corrupt",
	pos = {
		x = 1,
		y = 1,
	},
	atlas = "corrupt",
	discovered = true,
	config = {
		extra = {
			dept = 30,
			usable = true,
			size = 0
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.actv, card.ability.extra.timer } }
	end,
	can_use = function(self, card)
		return  RevosVault.check("highlight", G.jokers) == 1
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		crv.size = #G.jokers.cards / 2
		card.ability.extra.usable = false
		G.hand:change_size(-crv.size)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + (-crv.size)
		RevosVault.modify_rarity(G.jokers.highlighted[1],1)
		G.jokers:unhighlight_all()
	end,
})
]]



SMODS.Joker({
	key = "holoface",
	atlas = "Jokers2",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 3,
		y = 12,
	},
	config = {
		extra = {
			chipx = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = { crv.chipx },
		}
	end,
	calculate = function(self, card, context) end,
})

SMODS.Edition({
	key = "sunbleached",
	shader = "sunwashed",
	loc_txt = {
		name = "Sunbleached",
		text = { "suns your wash" },
	},
})

SMODS.Shader({
	key = "sunwashed",
	path = "sunwashed.fs",
})

SMODS.Joker({
	key = "facmulttest",
	atlas = "wip",
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			-- f_mult = 1,
			p_mult = 20,
		},
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				-- f_mult = card.ability.extra.f_mult,
				p_mult = card.ability.extra.p_mult,
			}
		end
	end,
})