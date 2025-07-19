SMODS.Blind({
	key = "minimalizm",
	name = "jud-minimalizm",
	debuff = {
		h_size_le = 3,
	},
	atlas = "blinds",
	pos = { x = 0, y = 1 },
	boss = { min = 3, max = 10 },
	boss_colour = HEX("f84b4b"),
})


SMODS.Blind({
	key = "fragile",
	boss = { min = 1, max = 10 },
	atlas = "blinds",
	pos = { x = 0, y = 0 },
	boss_colour = HEX("ffffff"),
		calculate = function(self, blind, context)
		if context.final_scoring_step then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				local cards = {}
				for i = 1, #G.play.cards do
					cards[#cards + 1] = G.play.cards[i]
				end
				local _card = pseudorandom_element(cards, pseudoseed("fragile"))
				if _card then
					_card:start_dissolve({ HEX("ffffff") }, nil, 1.6)
				end
				return true
			end,
		}))
		self.triggered = true
		return true
	end
end,
})

SMODS.Blind({
	key = "no",
	boss = { min = 1, max = 10, showdown = true },
	atlas = "blinds",
	pos = { x = 0, y = 3 },
	boss_colour = HEX("008016"),
	set_blind = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips * #G.jokers.cards
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		self.triggered = true
	end,
})

SMODS.Blind({
	key = "rrp",
	boss = {
		min = 1,
		max = 10,
		showdown = true,
	},
	atlas = "blinds",
	pos = { x = 0, y = 2 },
	boss_colour = HEX("3e3e3e"),
	drawn_to_hand = function(self)
		if G.jokers.cards[1] and self.prepped then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
				G.jokers.cards[i]:set_debuff(false)
			end
			local _card = pseudorandom_element(jokers, pseudoseed("rrp"))
			if _card then
				_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
				self.triggered = true
			end
			self.prepped = false
		end
	end,
	press_play = function(self)
		self.prepped = true
	end,
})
