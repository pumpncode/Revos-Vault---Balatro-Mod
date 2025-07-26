SMODS.Joker({
	key = "prismaticprinter",
	atlas = "entropy",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 0,
		y = 1,
	},
	config = {
		extra = {},
	},
	dependencies = "entr",
	calculate = function(self, card, context)
		if context.setting_blind then
if G.GAME.used_vouchers["v_crv_printerup"] == true and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4  or G.GAME.used_vouchers["v_crv_printeruptier"] == true then
				SMODS.add_card({
					area = G.consumeables,
					edition = "e_negative",
					key = "c_crv_prismaticcontract",
				})
			else
				if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
					SMODS.add_card({
						area = G.consumeables,
						key = "c_crv_prismaticcontract",
					})
				end
			end
		end
	end,
})

SMODS.Enhancement({
	key = "brightest",
	atlas = "entropy",
	pos = { x = 0, y =2 },
	shatters = true,
    config = {
        extra = {
            eemult = 2,
            eemult_mod = 0.5
        }
    },
	dependencies = "entr",
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.eemult,
				card.ability.extra.eemult_mod
            }
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			card.ability.extra.eemult = card.ability.extra.eemult + card.ability.extra.eemult_mod
			return {
				emult = card.ability.extra.eemult
			}
		end
	end,
	
})

SMODS.Consumable{
	key = 'prismaticcontract', 
	set = 'EnchancedDocuments', 
	discovered = true,
	atlas = 'entropy', 
	pos = {x = 0, y = 0}, 
	config = {
		extra = {
			cards = 1, odds = 4}
	},
	dependencies = "entr",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	  end,
	can_use = function(self,card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
				return true
			end
		end
		return false
	end,
	use = function(self,card,area,copier)
		if pseudorandom('coppercontract') < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_brightest"])
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
				delay(0.5)
			end
	else 
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_entr_prismatic"])
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
			delay(0.5)
	end
	
	 end
	 
	end,
}

--

SMODS.Joker({
	key = "darkprinter",
	atlas = "entropy",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 1,
		y = 1,
	},
	config = {
		extra = {},
	},
	dependencies = "entr",
	calculate = function(self, card, context)
		if context.setting_blind then
if G.GAME.used_vouchers["v_crv_printerup"] == true and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4  or G.GAME.used_vouchers["v_crv_printeruptier"] == true then
				SMODS.add_card({
					area = G.consumeables,
					edition = "e_negative",
					key = "c_crv_darkcontract",
				})
			else
				if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
					SMODS.add_card({
						area = G.consumeables,
						key = "c_crv_darkcontract",
					})
				end
			end
		end
	end,
})

SMODS.Enhancement({
	key = "darkest",
	atlas = "entropy",
	pos = { x = 1, y = 2 },
	shatters = true,
    config = {
        extra = {
            eechips = 1,
            eechips_mod = 0.50
        }
    },
	dependencies = "entr",
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.eechips,
				card.ability.extra.eechips_mod
            }
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.main_scoring then
			local cards = {}
			local suits = {}
			for i, v in ipairs(G.play.cards) do
				if v.config.center.key == "m_cry_abstract" or v.config.center.key == "m_stone" or v.config.center.key == "m_wild" then
					if not suits[v.config.center.key] then
						suits[v.config.center.key] = true
						cards[#cards+1]=true
					end
				else
					if not suits[v.base.suit] then
						suits[v.base.suit] = true
						cards[#cards+1]=true
					end
				end
			end
			for i, v in ipairs(cards) do
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
				card.ability.extra.eechips = card.ability.extra.eechips + card.ability.extra.eechips_mod
				delay(0.3)
			end
			return {
				echips = card.ability.extra.eechips
			}
		end
    end
	
})

SMODS.Consumable{
	key = 'darkcontract', 
	set = 'EnchancedDocuments', 
	discovered = true,
	atlas = 'entropy', 
	pos = {x = 1, y = 0}, 
	config = {
		extra = {
			cards = 1, odds = 4}
	},
	dependencies = "entr",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	  end,
	can_use = function(self,card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
				return true
			end
		end
		return false
	end,
	use = function(self,card,area,copier)
		if pseudorandom('coppercontract') < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_darkest"])
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
				delay(0.5)
			end
	else 
		for i, card in pairs(G.hand.highlighted) do
			card:set_ability(G.P_CENTERS["m_entr_dark"])
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
			delay(0.5)
	end
	
	 end
	 
	end,
}