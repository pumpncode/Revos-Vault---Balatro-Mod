SMODS.Stake({
	key = "pitch_black",
	atlas = "stakes",
	pos = { x = 2, y = 1 },
	colour = HEX("fdffa8"),
	sticker_atlas = "enh",
	sticker_pos = { x = 6, y = 3 },
	applied_stakes = { "crv_overt" },
	shiny = true,
	unlocked = false,
	prefix_config = { applied_stakes = { mod = false } },
	loc_txt = {
		name = "Pitch Black Stake",
		text = { "Vouchers {C:red}Cannot{} apear in shop voucher slot" },
		sticker = {
			name = "Pitch Black Sticker",
			text = {
				"Used this Joker",
				"to win on {C:attention}Pitch Black",
				"{C:attention}Stake{} difficulty",
			},
		},
	},
	modifiers = function()
		G.GAME.modifiers.enable_no_vouchers = true
	end,
})

SMODS.Joker({
	key = "exexe",
	atlas = "wip",
	pos = { x = 0, y = 0 },
	calculate = function(self, card, context)
		if context.before then
			local add = 0
			for k, v in pairs(G.play.cards) do
				if SMODS.has_enhancement(v, "m_wild") then
					add = add + 1
				end
			end
			for i = 1, add do
				print("+1")
			end
		end
	end,
})

SMODS.Edition({
	key = "pastel",
	shader = "pastel_shader",
	config = {
		odds = 3,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				(G.GAME.probabilities.normal or 1),
				self.config.odds,
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			return {
				p_mult = 50,
			}
		end
	end,
})

SMODS.Shader({
	key = "pastel_shader",
	path = "pastel_shader.fs",
})
