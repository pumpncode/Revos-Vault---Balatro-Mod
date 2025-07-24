SMODS.Enhancement({
	key = "ignited",
	atlas = "paradox",
	pos = { x = 2, y = 0 },
	shatters = true,
	config = {
		extra = {
            add = 0.1
        },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.add},
		}
	end,
	dependencies = "paradox_ideas",
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            for _, v in ipairs(context.scoring_hand) do
                v.ability.perma_x_mult = (v.ability.perma_x_mult or 0) + card.ability.extra.add
                v:juice_up()
            end
    end
    end
})

SMODS.Consumable({
	key = "ashencontract",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "paradox",
	pos = { x = 1, y = 0 },
	config = {
		extra = {
			cards = 1,
			odds = 4,
		},
	},
	dependencies = "paradox_ideas",
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
		if pseudorandom("honeycontract") < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, card in pairs(G.hand.highlighted) do
				card:set_ability(G.P_CENTERS["m_crv_ignited"])
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
				card:set_ability(G.P_CENTERS["m_para_ashen"])
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

SMODS.Joker({
	key = "ahsenprinter",
	atlas = "paradox",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	dependencies = "paradox_ideas",
	loc_vars = function(self, info_queue, center) end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
			if G.GAME.used_vouchers["v_crv_printerup"] == true then
				SMODS.add_card({
					key = "c_crv_ashencontract",
					editon = "e_negative",
				})
			else
				if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
					SMODS.add_card({
					key = "c_crv_ashencontract",
					})
				end
			end
		end
	end,
})
