

SMODS.Joker({
	key = "stoneoven",
	atlas = "prismc",
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
	config = {
		extra = {
            pizza = 1
        },
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
	end,
	dependencies = "Prism",
	calculate = function(self, card, context)
        local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
			if G.GAME.used_vouchers["v_crv_printerup"] == true then
				local card = create_card(nil, G.jokers, nil, nil, nil, nil, nil,"Pizza")
				card:add_to_deck()
				card:set_edition({negative = true},true)
				G.jokers:emplace(card)
                end
			else
				if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
					local card = create_card(nil, G.jokers, nil, nil, nil, nil, nil,"Pizza")
					card:add_to_deck()
					G.jokers:emplace(card)
				end
			end
		end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})


if G.PRISM.config.myth_enabled then
SMODS.Joker({
	key = "mythprint",
	atlas = "prismc",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 1,
		y = 0,
	},
	config = {
		extra = {
            pizza = 1
        },
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
	end,
	dependencies = "Prism",
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if G.GAME.used_vouchers["v_crv_printerup"] == true then
                SMODS.add_card{
                    set = "Myth",
                    edition = "e_negative"
                }
            else
                if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                    SMODS.add_card{
                        set = "Myth",
                    }
                end
            end
        end
    end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})
end

SMODS.Enhancement({
    key = "saphire",
    atlas = "prismc",
    pos = {x = 0, y = 1},
    discovered = false,
    config = {extra = {x_mult = 1,x_gain = 0.75}},
    effect = "Glass Card",
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.x_mult, card_ability.extra.x_gain}
        }
    end,
	dependencies = "Prism",
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
        if context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_gain
            return{
				colour = G.C.RED,
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				card = card,
            }
        end
	end,
})

SMODS.Consumable({
	key = "saphirecontract",
	set = "EnchancedDocuments",
	discovered = true,
	atlas = "prismc",    
	pos = { x = 2, y = 1},
	config = {
		extra = {
			cards = 1,
			odds = 4,
		},
	},
	dependencies = "Prism",
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
				card:set_ability(G.P_CENTERS["m_crv_saphire"])
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
				card:set_ability(G.P_CENTERS["m_prism_crystal"])
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
	key = "crystalprinter",
	atlas = "prismc",
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
		extra = {
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_crv_crystalcontract
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if
				 G.GAME.used_vouchers["v_crv_printerup"] == true
			then
				SMODS.add_card{
                    key = "c_crv_saphirecontract",
                    area = G.consumeables,
                    edition = "e_negative"
                }
            else 
                SMODS.add_card{
                    key = "c_crv_saphirecontract",
                    area = G.consumeables,
                }
            end
        end
    end,

	in_pool = function(self, wawa, wawa2)
		return true
	end,
	dependencies = "Prism",
})
