SMODS.Joker({
	key = "burgerpr",
	atlas = "sdm0",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_sdm_burger
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if G.GAME.used_vouchers["v_crv_printerup"] == true then
				SMODS.add_card{
                    key = "j_sdm_burger",
                    edition = "e_negative",
                    area = G.jokers
                }
			else
				if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                    SMODS.add_card{
                        key = "j_sdm_burger",
                        area = G.jokers
                    }
				end
			end
		end
	end,
	set_badges = function(self, card, badges)
		G.C.REV10 = HEX("c20000")
		badges[#badges+#badges] = create_badge("SDM_0's Stuff", G.C.REV10, nil,1)
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})