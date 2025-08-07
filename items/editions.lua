SMODS.Edition({
	key = "sunbleached",
	shader = "sunwashed",
	config = {
			odds  = 3
	},
    loc_vars = function(self, info_queue, card)
		return {
			vars = {
                (G.GAME.probabilities.normal or 1),
				self.config.odds
			},
		}
	end,
	calculate = function(self,card,context)
		if context.other_card == card and ((context.repetition and context.cardarea == G.play) or (context.retrigger_joker_check and not context.retrigger_joker)) then
			if pseudorandom("sunbleached") < G.GAME.probabilities.normal / self.config.odds then
			return {
				repetitions = 1,
			}
		end
	end
end
})

SMODS.Shader({
	key = "sunwashed",
	path = "sunwashed.fs",
})

SMODS.Edition({
	key = "showcase",
	shader = "test",
})

SMODS.Shader({
	key = "test",
	path = "test.fs",
})
