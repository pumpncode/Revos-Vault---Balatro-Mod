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
	rarity = 4,
	pos = { x = 0, y = 0 },
	calculate = function(self, card, context) end,
})

local rerol_old = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
	if #SMODS.find_card("j_crv_exexe") > 0 then
		RevosVault.replacecards(G.shop_vouchers.cards)
		RevosVault.replacecards(G.shop_booster.cards)
	end
	rerol_old(e)
end

local can_reroll_old = G.FUNCS.can_reroll
function G.FUNCS.can_reroll(e)
	if #SMODS.find_card("j_crv_2") > 0 then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		return can_reroll_old(e)
	end
end

SMODS.Joker({
	key = "2",
	atlas = "wip",
	rarity = 2,
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			timer = 1,
		},
	},
	add_to_deck = function(self, card, context)
		G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
		calculate_reroll_cost(true)
	end,
	update = function(self, card, context)
		if RevosVault.check("inshop") and card.area == G.jokers then
			card.ability.extra.timer = card.ability.extra.timer - G.real_dt
			if card.ability.extra.timer <= 0 then
				G.FUNCS.reroll_shop()
				G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
				G.CONTROLLER.locks.shop_reroll = true
				card.ability.extra.timer = 1
			end
		end
	end,
})

SMODS.Edition({
	key = "bloom_edition",
	shader = "bloom",
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
				p_chips = 60,
			}
		end
	end,
})

SMODS.Shader({
	key = "bloom",
	path = "bloom.fs",
})

SMODS.Edition({
	key = "magnetised_edition",
	shader = "magnetised",
	config = {
		odds = 0.2,
	},
	loc_vars = function(self, info_queue, card)
		if G.jokers and G.jokers.cards and G.playing_cards then
			local areas = {}
			for k, v in pairs(G.jokers.cards) do
				areas[#areas+1] = v
			end
			for k, v in pairs(G.playing_cards) do
				areas[#areas+1]=  v
			end
			return {
				vars = {
					RevosVault.check_edition(areas),
					self.config.odds,
					RevosVault.check_edition(areas) * self.config.odds + 1,
				},
			}
		else
			return {
				vars = {
					1,
					self.config.odds,
					1,
				},
			}
		end
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			local areas = {}
			for k, v in pairs(G.jokers.cards) do
				areas[#areas+1] = v
			end
			for k, v in pairs(G.playing_cards) do
				areas[#areas+1]=  v
			end
			return {
				xmult = RevosVault.check_edition(areas) * self.config.odds + 1
			}
		end
	end,
})

SMODS.Shader({
	key = "magnetised",
	path = "magnetised.fs",
})


SMODS.Edition({
	key = "antichrome_edition",
	shader = "antichrome",
	config = {
		odds = 0.5,
	},
	loc_vars = function(self, info_queue, card)
		local cards = {}
		if G.jokers and G.jokers.cards then
			return {
				vars = {
					#G.jokers.cards,
					self.config.odds,
					RevosVault.stencil(G.jokers.cards,"j_stencil","e_crv_antichrome_edition") * self.config.odds,
				},
			}
		else
			return {
				vars = {
					1,
					self.config.odds,
					0.5,
				},
			}
		end
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			return {
				xmult = RevosVault.stencil(G.jokers.cards,"j_stencil","e_crv_antichrome_edition") * self.config.odds
			}
		end
	end,
})

SMODS.Shader({
	key = "antichrome",
	path = "antichrome.fs",
})
