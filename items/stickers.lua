SMODS.Sticker({
	key = "vamp",
	badge_colour = HEX("830000"),
	atlas = "enh",
	pos = {
		x = 2,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	rate = 0.3,
	needs_enable_flag = true,
	calculate = function(self, card, context)
		if context.setting_blind then
			local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
			if G.jokers.cards[rr + 1] == nil or G.jokers.cards[rr - 1] == nil and not context.blueprint then
				card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			end
		end
	end,
})

SMODS.Sticker({
	key = "haunted",
	badge_colour = HEX("232323"),
	atlas = "enh",
	pos = {
		x = 3,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	rate = 0.2,
	needs_enable_flag = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
		end
	end,
})

SMODS.Sticker({
	key = "radioactive",
	badge_colour = HEX("008c24"),
	atlas = "enh",
	pos = {
		x = 4,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	rate = 0.1,
	needs_enable_flag = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
			local lc = { "Left", "Right" }
			local choosencard = pseudorandom_element(lc, pseudoseed("radioactive"))
			if choosencard == "Left" and G.jokers.cards[rr - 1] ~= nil then
				G.jokers.cards[rr - 1]:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			elseif choosencard == "Right" and G.jokers.cards[rr + 1] ~= nil then
				G.jokers.cards[rr + 1]:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			end
		end
	end,
})

SMODS.Sticker({
	key = "absolute",
	badge_colour = HEX("ffe9b5"),
	atlas = "enh",
	pos = {
		x = 2,
		y = 3,
	},
	sets = {
		Joker = true,
	},
	rate = 0.2,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {G.GAME.probabilities.normal},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
            if pseudorandom("absolute") < G.GAME.probabilities.normal / 4 then
                local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
                local card2 = G.jokers.cards[rr].config.center_key
                SMODS.add_card({
                    area = G.jokers,
                    key = card2,
                })
		end
	end
end
})

SMODS.Sticker({
	key = "marked",
	badge_colour = HEX("000000"),
	atlas = "enh",
	pos = {
		x = 3,
		y = 3,
	},
	sets = {
		Joker = true,
	},
	rate = 0.1,
	needs_enable_flag = true,
})