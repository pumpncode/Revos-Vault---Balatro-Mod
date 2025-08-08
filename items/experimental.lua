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

local rerol_old = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
	if (#SMODS.find_card("j_crv_exexe") > 0) then
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
	add_to_deck = function(self,card,context)
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
