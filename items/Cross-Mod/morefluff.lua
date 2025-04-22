

SMODS.Joker({
	key = "45degreeprinter",
	config = {
		extra = {
		},
	},
	rarity = "crv_p",
	atlas = "morefluff45",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 0,
		y = 0,
	},
    display_size = {
		w = 114,
		h = 114,
	},
	cost = 6,
    dependencies = "MoreFluff",
	loc_vars = function(self, info_queue, card)
		return {
			vars = { },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if G.GAME.used_vouchers["v_crv_printerup"] == true then
				SMODS.add_card{
                    set = "Rotarot",
                    edition = "e_negative"
                }
			else
				if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
                    SMODS.add_card{
                        set = "Rotarot",
                    }
				end
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})