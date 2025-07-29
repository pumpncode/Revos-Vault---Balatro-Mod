SMODS.Joker({
	key = "replacetest",
	rarity = 2,
	cost = 4,
	atlas = "wip",
	config = {
		extra = {
			shop = nil,
			rerolls = 3,
			limit = 3,
			can_roll = false,
		},
	},
	loc_txt = {
		name = "Reroll",
		text = { "#1#" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.rerolls },
		}
	end,
	pos = { x = 0, y = 0 },
	discovered = true,
	blueprint_compat = false,
	keep_on_use = function(self, card)
		return true
	end,
	calculate = function(self, card, context)
		if context.reroll_cards and not context.blueprint then
			RevosVault.replacecards(G.jokers.highlighted, nil, nil, true, card)
			card_eval_status_text(card, "extra", nil, nil, nil, { message = "Reroll!" })
			card.ability.extra.rerolls = card.ability.extra.rerolls - 1
			G.jokers:unhighlight_all()
		end
		if context.end_of_round and G.GAME.blind.boss and context.main_eval then
			card.ability.extra.rerolls = 3
			return {
				message = localize("k_reset"),
			}
		end
	end,
	update = function(self, card, context)
		if card.ability.extra.limit < 3 then
			card.ability.extra.limit = 3
		end
		if card.ability.extra.rerolls > 0 then
			if G and G.jokers and G.jokers.highlighted then
				if #G.jokers.highlighted > 1 and #G.jokers.highlighted < card.ability.extra.limit then
					card.ability.extra.can_roll = true
				else
					card.ability.extra.can_roll = false
				end
			end
		else
			card.ability.extra.can_roll = false
		end
	end,
})

local card_highlighted_ref12 = Card.highlight
function Card:highlight(is_highlighted)
	self.highlighted = is_highlighted
	if self.highlighted and string.find(self.ability.name, "j_crv_replacetest") and self.area == G.jokers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = RevosVault.create_sell_and_switch_buttons11(self, {
				sell = true,
				use = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -0.4,
					y = 0,
				},
				parent = self,
			},
		})
	else
		card_highlighted_ref12(self, is_highlighted)
	end
end

RevosVault.create_sell_and_switch_buttons11 = function(card, args)
	local args = args or {}
	local sell = nil
	local use = nil

	if args.sell then
		sell = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "sell_card",
						func = "can_sell_card",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_sell"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("$"),
												colour = G.C.WHITE,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = card,
												ref_value = "sell_cost_label",
												colour = G.C.WHITE,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	if args.use then
		use = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						maxw = 1.25,
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						minh = 0,
						hover = true,
						shadow = true,
						colour = G.C.RED,
						button = "use_card",
						func = "can_reroll_cards",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = "Reroll",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = "Selected",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.3,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cr",
			padding = 0,
			colour = G.C.CLEAR,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.15,
					align = "cl",
				},
				nodes = {
					sell and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { sell },
					} or nil,
					use and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { use },
					} or nil,
				},
			},
		},
	}
end

G.FUNCS.can_reroll_cards = function(e)
	local card = e.config.ref_table
	if card.ability.extra.can_roll == true then
		e.config.colour = G.C.RED
		e.config.button = "reroll_cards"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.reroll_cards = function(e)
	local card = e.config.ref_table
	Card:reroll_cards()
end

function Card:reroll_cards()
	SMODS.calculate_context({ reroll_cards = true })
end

--Corrupt Cards

SMODS.ConsumableType({
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
					print(crv.timer)
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
})]]

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
