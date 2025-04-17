SMODS.Joker({
	key = "letterprinter",
	atlas = "aiko",
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
	loc_vars = function(self, info_queue, center)
	end,

	calculate = function(self, card, context)
        local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
			if G.GAME.used_vouchers["v_crv_printerup"] == true then
				SMODS.add_card{
                    set = "Alphabet",
                    editon = "e_negative"
                }
			else
				if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                    SMODS.add_card{
                        set = "Alphabet",
                        editon = "e_negative"
                    }
				end
			end
		end
    end,
    in_pool = function(self, args)
        return G.GAME.akyrs_character_stickers_enabled
    end,
    set_badges = function(self, card, badges)
        G.C.AIKOR = HEX("ff475a")
		badges[#badges+#badges] = create_badge("AikoShenanigans",G.C.AIKOR,nil,1)
	end
})