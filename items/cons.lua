SMODS.Consumable({
	key = "inkintuition",
	set = "Tarot",
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	pos = { x = 0, y = 0 },
	atlas = "tarots",
	cost = 3,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
			return true
		end
	end,
	use = function(self, card)
		if pseudorandom("inkintuition") < G.GAME.probabilities.normal / card.ability.extra.odds then
			SMODS.add_card({ set = "Joker", area = G.jokers, rarity = "crv_p" })
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
						backdrop_colour = G.C.SECONDARY_SET.Tarot,
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
		delay(0.6)
	end,
})

local machine_keys = { "j_crv_head", "j_crv_body", "j_crv_back" }

SMODS.ObjectType({
	key = "megaprinter",
	cards = {
		["j_crv_head"] = true,
		["j_crv_body"] = true,
		["j_crv_back"] = true,
	},
})

SMODS.Consumable({
	key = "dreamsdesires",
	set = "Tarot",
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	pos = { x = 1, y = 0 },
	atlas = "tarots",
	cost = 3,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
			return true
		end
	end,
	use = function(self, card)
		SMODS.add_card({ set = "megaprinter", area = G.jokers })
		delay(1.5)
	end,
})

SMODS.ConsumableType({
	key = "scrap",
	collection_rows = { 4, 5 },
	primary_colour = G.C.RED,
	secondary_colour = G.C.RED,
	shop_rate = nil,
})

SMODS.UndiscoveredSprite({
	key = "scrap",
	atlas = "documents2.png",
	pos = { x = 0, y = 0 },
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "horn",
	discovered = true,
	unlocked = true,
	set = "scrap",
	atlas = "scrapss",
	cost = 0,
	pos = { x = 2, y = 0 },
	can_use = function(self, card)
		return true
	end,
	use = function()
		return {
			ease_dollars(30),
		}
	end,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "pickles",
	discovered = true,
	unlocked = true,
	set = "scrap",
	atlas = "scrapss",
	cost = 0,
	pos = { x = 0, y = 0 },
	can_use = function(self, card)
		return true
	end,
	use = function()
		return {
			ease_dollars(25),
		}
	end,
})
SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "mp",
	discovered = true,
	unlocked = true,
	set = "scrap",
	atlas = "scrapss",
	cost = 0,
	pos = { x = 1, y = 0 },
	can_use = function(self, card)
		return true
	end,
	use = function()
		return {
			ease_dollars(20),
		}
	end,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "ap",
	discovered = true,
	unlocked = true,
	set = "scrap",
	atlas = "scrapss",
	cost = 0,
	pos = { x = 3, y = 0 },
	can_use = function(self, card)
		return true
	end,
	use = function()
		return {
			ease_dollars(35),
		}
	end,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "dc",
	discovered = true,
	unlocked = true,
	set = "scrap",
	atlas = "scrapss",
	cost = 0,
	pos = { x = 4, y = 0 },
	can_use = function(self, card)
		return true
	end,
	use = function()
		return {
			ease_dollars(15),
		}
	end,
})

SMODS.ConsumableType({
	key = "EnchancedDocuments",

	collection_rows = { 4, 5 },
	primary_colour = G.C.WHITE,
	secondary_colour = G.C.BLACK,
})

SMODS.UndiscoveredSprite({
	key = "EnchancedDocuments",
	atlas = "documents_u",
	pos = { x = 0, y = 0 },
})

SMODS.Consumable({
	key = "glassdocument",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			cards = 1,
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		if pseudorandom("glassdocument") < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_bulletproofglass"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		else
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_glass"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		end
	end,
})

SMODS.Consumable({
	key = "steeldocument",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 3, y = 0 },
	config = {
		extra = {
			cards = 1,
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		if pseudorandom("steeldocument") < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_diamondcard"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		else
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_steel"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		end
	end,
})

local imsofckntired = { "m_crv_aflame", "m_crv_mugged" }

SMODS.Consumable({
	key = "devilscontract",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 1, y = 0 },
	config = {
		extra = { cards = 1, odds = 4 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		if pseudorandom("devilscontract") < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_soulcard"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		else
			local random_key = imsofckntired[math.random(#imsofckntired)]
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS[random_key])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		end
	end,
})

SMODS.Consumable({
	key = "megadoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "megaenh",
	pos = { x = 1, y = 0 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_crv_mega"])
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "t1doc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "t",
	pos = { x = 0, y = 1 },
	config = { extra = { cards = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_crv_tier1card"])
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})
SMODS.Consumable({
	key = "t2doc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "t",
	pos = { x = 1, y = 1 },
	config = { extra = { cards = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_crv_tier2card"])
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})
SMODS.Consumable({
	key = "t3doc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "t",
	pos = { x = 2, y = 1 },
	config = { extra = { cards = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_crv_tier3card"])
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "boostdoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "t",
	pos = { x = 3, y = 1 },
	config = { extra = { cards = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_crv_boostcard"])
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "luckydocument",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 2, y = 0 },
	config = {
		extra = {
			cards = 1,
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				return true
			end
		end
		return true
	end,
	use = function(self, card, area, copier)
		if pseudorandom("luckydocument") < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_blessedcard"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		else
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_lucky"])
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
				delay(0.5)
			end
		end
	end,
})

SMODS.Consumable({
	key = "polydoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 2, y = 1 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_edition({ polychrome = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
		for i, card in pairs(G.jokers.highlighted) do
			card:set_edition({ polychrome = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "foildoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 0, y = 1 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_edition({ foil = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
		for i, card in pairs(G.jokers.highlighted) do
			card:set_edition({ foil = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "holdoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 1, y = 1 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_edition({ holo = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
		for i, card in pairs(G.jokers.highlighted) do
			card:set_edition({ holo = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "negdoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 3, y = 1 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_edition({ negative = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
		for i, card in pairs(G.jokers.highlighted) do
			card:set_edition({ negative = true }, true)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "uedoc",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 0, y = 2 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_edition(poll_edition(pseudorandom("uedoc"), nil, true, true))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
		for i, card in pairs(G.jokers.highlighted) do
			card:set_edition(poll_edition(pseudorandom("uedoc"), nil, true, true))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

SMODS.Consumable({
	key = "rdocument",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "documents",
	pos = { x = 1, y = 2 },
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			card:set_edition()
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
		for i, card in pairs(G.jokers.highlighted) do
			card:set_edition()
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})

-- Superior Cards

SMODS.ConsumableType({
	key = "Superior",

	collection_rows = { 4, 5 },
	primary_colour = RevosVault.C.SUP,
	secondary_colour = RevosVault.C.SUP,
	default = "c_crv_supfool",
})


SMODS.Consumable({
	key = "supfool",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 0,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.GAME and G.GAME.last_destroyed_joker then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		SMODS.add_card({
			key = G.GAME.last_destroyed_joker.config.center.key,
		})
	end,
})

SMODS.Consumable({
	key = "supmagician",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 1,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_lucky")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_lucky") then
				return {
					repetitions = 1,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suppriestess",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 2,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local _planet, _hand = nil, RevosVault.most_played()
		for _, v in pairs(G.P_CENTER_POOLS.Planet) do
			if v.config.hand_type == _hand then
				_planet = v.key
			end
		end
		for i = 1, 3 do
			SMODS.add_card({
				key = _planet,
				edition = "e_negative",
			})
		end
	end,
})

SMODS.Consumable({
	key = "supempress",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 3,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 2,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_crv_xmultcard")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "supemperor",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 4,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		for i = 1, 2 do
			SMODS.add_card({
				key = pseudorandom_element(G.P_CENTER_POOLS.Superior).key,
				area = G.consumeables
			})
		end
	end,
})

SMODS.Consumable({
	key = "suphierophant",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 5,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_bonus")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_bonus") then
				return {
					repetitions = 1,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suplovers",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 6,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_wild")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_wild") then
				return {
					mult = context.other_card.base.id / 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "supchariot",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 7,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_steel")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand then
			if SMODS.has_enhancement(context.other_card, "m_steel") then
				return {
					xchips = 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "supjustice",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 8,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_glass")
					v:set_edition("e_polychrome")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_glass") then
				return {
					mult = context.other_card.base.id / 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suphermit",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 9,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {
			money = 100,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.money } }
	end,
	can_use = function(self,card)
		return true
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				card:juice_up(0.3, 0.5)
				ease_dollars(math.max(0, math.min(G.GAME.dollars + G.GAME.dollars, card.ability.extra.money)), true)
				return true
			end,
		}))
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			return {
				dollars = 5,
			}
		end
	end,
})

SMODS.Consumable({
	key = "supwheel",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 0,
		y = 1,
	},
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	can_use = function(self, card)
		local jokas = {}
		for i = 1, #G.jokers.cards do
			if not G.jokers.cards[i].edition then
				jokas[#jokas + 1] = G.jokers.cards[i]
			end
		end
		if #G.jokers.cards > 0 and #jokas > 0 then
			return true
		end
	end,
	use = function(self, card, area, copier)
		RevosVault.wheeloffortune(1, G.jokers.cards)
	end,
})

SMODS.Consumable({
	key = "supstrength",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 1,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v, nil, "King")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "suphangedman",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 2,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,min_highlighted = 1,
		extra = {
			chips = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			G.GAME.hangedmanchips = G.GAME.hangedmanchips + v.base.id
			SMODS.destroy_cards(v)
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = G.GAME.hangedmanchips,
			}
		end
	end,
})

SMODS.Consumable({
	key = "supdeath",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 3,
		y =1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,min_highlighted = 1,
		extra = {
			chips = 0,
		},
	},
	can_use = function(self, card)
		if
			#G.hand.highlighted <= 2
			and #G.hand.highlighted > 0
			and RevosVault.find_lowest(G.playing_cards, nil, true)
		then
			return true
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					copy_card((RevosVault.find_lowest(G.playing_cards, nil, true)), v)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "suptemp",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 4,
		y = 1,
	},
	discovered = true,
	config = {
		extra = {
			money = 0,
		},
	},
	can_use = function(self, card)
			return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].ability.set == "Joker" then
				card.ability.extra.money = card.ability.extra.money + G.jokers.cards[i].sell_cost
			end
		end
		for i = 1, #G.consumeables.cards do
			card.ability.extra.money = card.ability.extra.money + G.consumeables.cards[i].sell_cost
		end
		ease_dollars(math.max(0, math.min(card.ability.extra.money, 100)), true)
	end,
})

SMODS.Consumable({
	key = "supdevil",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 5,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 3,min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_gold")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_gold") then
				return {
					dollars = 5,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suptower",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 6,
		y = 1,
	},
	discovered = true,
	config = {
			max_highlighted = 2,min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_stone")
					v:set_edition("e_negative")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_stone") then
				return {
					xmult = 2,
				}
			end
		end
	end,
})

--All suits and suit releated stuff will be done later

SMODS.Consumable({
	key = "supstar",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 7,
		y = 1,
	},
	discovered = true,
	config = {
			max_highlighted = 2, min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v,"Diamonds",nil)
					v:set_ability("m_crv_superiore")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "supmoon",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 8,
		y = 1,
	},
	discovered = true,
	config = {
			max_highlighted = 2,min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v,"Clubs",nil)
					v:set_ability("m_crv_superiore")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "supsun",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 9,
		y = 1,
	},
	discovered = true,
	config = {
			max_highlighted = 2,min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v,"Hearts",nil)
					v:set_ability("m_crv_superiore")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

SMODS.Consumable({
	key = "supworld",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 1,
		y = 2,
	},
	discovered = true,
	config = {
			max_highlighted = 2,min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v,"Spades",nil)
					v:set_ability("m_crv_superiore")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
})

--

SMODS.Consumable({
	key = "supjudgement",
	set = "Superior",
	atlas = "Superior",
	hidden = true,
	soul_set = "Tarot",
	sout_rate = 0.1,
	pos = {
		x = 0,
		y = 2,
	},
	discovered = true,
	config = {
		extra = {
			default = 0,
			default2 = 0,
		},
	},
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
			local one
			local two
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				blockable = false,
				blocking = false,
				func = function()
					one = SMODS.ObjectTypes["Joker"].rarities[1].weight
					two = SMODS.ObjectTypes["Joker"].rarities[2].weight
					SMODS.ObjectTypes["Joker"].rarities[1].weight = 0
					SMODS.ObjectTypes["Joker"].rarities[2].weight = 0
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				delay = 0.2,
				blockable = false,
				blocking = false,
				func = function()
					local acard = SMODS.add_card({
						set = "Joker",
					})
					local transform = {}
					if acard.config.center.key == "j_joker" then
						print("Jimbo got created. Transforming it into a random rare joker")
						for i = 1, #G.P_CENTER_POOLS.Joker do
							local rcard = G.P_CENTER_POOLS.Joker
								if rcard[i].rarity == 3 then
									transform[#transform+1] = rcard[i]
								end
						end
						acard:set_ability(pseudorandom_element(transform).key)
					end
					return true
				end,
			}))
			SMODS.ObjectTypes["Joker"].rarities[1].weight = one
			SMODS.ObjectTypes["Joker"].rarities[2].weight = two
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_stone") then
				return {
					xmult = 2,
				}
			end
		end
	end,
})
