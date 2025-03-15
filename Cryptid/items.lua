local mrinter = {
    object_type = "Joker",
    name = "Mrinter",
    key = "mrinter",
    atlas = 'cryp',
    rarity = 'crv_p',
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    gameset_config = {
        modest = {disabled = true}, 
        mainline = {center = {rarity = "crv_p", cost = 10, blueprint_compat = false}}, 
        madness = {center = {rarity = "crv_p", cost = 6, blueprint_compat = true}} 
      },
    dependencies = {
        items = {
           "set_cry_m"
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {}
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_cry_m
    end,

    calculate = function(self, card, context)

        if context.setting_blind then
            SMODS.add_card({
                set = "Joker",
                area = G.jokers,
                key = 'j_cry_m'
            })
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end,
    pools = { ["M"] = true },
}


local glprinter = {
    object_type = "Joker",
    name = "Glitched Printer",
    key = "glprinter",
    atlas = 'cryp',
    rarity = 'crv_p',
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    dependencies = {
		items = {
			"set_cry_misc",
		},
	},
    gameset_config = {
        modest = {disabled = true}, 
        mainline = {center = {rarity = "crv_p", cost = 10, blueprint_compat = false}}, 
        madness = {center = {rarity = "crv_p", cost = 6, blueprint_compat = true}} 
      },
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = {}
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_crv_gldoc
    end,

    calculate = function(self, card, context)

        if context.setting_blind then
            local card = create_card("Consumable", G.consumeables, nil, nil, nil, nil, "c_crv_gldoc")
            card:add_to_deck()
            G.consumeables:emplace(card)
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end,
    draw = function(self, card, layer)
        card.children.center:draw_shader('cry_glitched', nil, card.ARGS.send_to_shader)
    end,
}



local gldoc = {
    object_type = "Consumable",
    key = 'gldoc', 
    name = "Glitched Document",
    set = 'EnchancedDocuments', 
    discovered = true,
    atlas = 'cryp', 
    pos = {x = 2, y = 1}, 
    gameset_config = {
        modest = {disabled = true}, 
        mainline = {disabled = false}, 
        madness = {disabled = false}
      },
    dependencies = {
		items = {
			"set_cry_misc",
		},
	},
    config = {
        extra = {
            cards = 1,}
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_glitched
        return { vars = { card.ability.extra.cards} }
      end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards and #G.jokers.highlighted == 0 then
                return true
            elseif #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= card.ability.extra.cards and #G.hand.highlighted == 0 then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
            for i, card in pairs(G.hand.highlighted) do
                card:set_edition({cry_glitched = true}, true)
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                delay(0.5)
            end
            for i, card in pairs(G.jokers.highlighted) do
                card:set_edition({cry_glitched = true}, true)
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                delay(0.5)
            end
        end,
        draw = function(self, card, layer)
            card.children.center:draw_shader('cry_glitched', nil, card.ARGS.send_to_shader)
        end,
}

local printorium = {
    object_type = "Joker",
    name = "Printorium",
    key = "printorium",
    atlas = 'cryp',
    rarity = 'cry_exotic',
    cost = 50,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    dependencies = {
		items = {
			"set_cry_exotic",
		},
	},
    gameset_config = {
        modest = {disabled = true}, 
        mainline = {extra = {odds = 4},center = {rarity = "cry_exotic", cost = 50, blueprint_compat = false}}, 
        madness = {extra = {odds = 1},center = {rarity = "cry_exotic", cost = 45, blueprint_compat = true}} 
      },
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {odds = 4}
    },
    loc_vars = function(self, info_queue, card, center)
        return {
            vars = {(G.GAME.probabilities.normal or 1),card.ability.extra.odds,}
        }
    end,

    calculate = function(self, card, context)

        if context.setting_blind then
            if pseudorandom('printorium') < G.GAME.probabilities.normal / card.ability.extra.odds then
            SMODS.add_card({set = "Joker",area = G.jokers,rarity = 'cry_exotic'})
        end
    end
end,
    in_pool = function(self, wawa, wawa2)
        return true
    end,
}

return {
    init = function(self)
    end,
    items = {
        mrinter,
        glprinter,
        gldoc,
        printorium
    }
}
  