

SMODS.Joker({
	key = "holoface",
	atlas = "Jokers2",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 3,
		y = 12,
	},
	config = {
		extra = {
			chipx = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = { crv.chipx },
		}
	end,
	calculate = function(self, card, context) end,
})

SMODS.Edition({
	key = "sunbleached",
	shader = "sunwashed",
	loc_txt = {
		name = "Sunbleached",
		text = { "suns your wash" },
	},
})

SMODS.Shader({
	key = "sunwashed",
	path = "sunwashed.fs",
})

--This part is fucked up

local quests = {
	level_one = {
		"Play a Flush",
		"Use a Planet Card",
		"Play a High Card",
		"Use a Strength Tarot Card",
	},
	level_two = {
		"Score a Stone Card",
		"Beat the current blind in one hand",
		"Get 10 Rerolls in one shop",
	},
	level_three = {
		"Play a Four of a Kind",
		"Get 20 Rerolls in one shop",
		"Have over $100 while entering shop",
	},
	level_four = {
		"Play a Five of a Kind",
		"Win a blind without playing your most played hand",
		"Have over $120 while entering shop",
	},
}

SMODS.Joker({
	key = "inga",
	atlas = "Jokers2",
	rarity = 2,
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 5,
	},
	config = {
		extra = {
			one = "Inactive",
			two = "Inactive",
			three = "Inactive",
			four = "Inactive",
			quest = 0,
			questa = 0,
			questb = "Not Set",
			xmult = 2,
			xchips = 4,
			odds = 4,
			counter = 0,
			rerolls = 0,
			perma_mult = 5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.one, --State of the quest 1
				card.ability.extra.two, --State of the quest 2
				card.ability.extra.three, --State of the quest 3
				card.ability.extra.four, --State of the quest 4
				card.ability.extra.quest, --Completed quest count
				card.ability.extra.questa, -- ?
				card.ability.extra.questb, -- Current quest
				card.ability.extra.xmult, -- The Xmult
				card.ability.extra.xchips, -- The Xchip
				card.ability.extra.odds, -- Not used
				(G.GAME.probabilities.normal or 1), -- Not used
				card.ability.extra.counter, -- ?
				card.ability.extra.rerolls, --Reroll count in one shop
				card.ability.extra.perma_mult, -- perma mult go brrr
			},
		}
	end,

	add_to_deck = function(self, card) --set the first quest
		local crv = card.ability.extra
		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
				if crv.questb == "Not Set" then
					crv.questb = pseudorandom_element(quests.level_one, pseudoseed("inga"))
				end
				return true
			end,
		}))
	end,

	calculate = function(self, card, context)
		local crv = card.ability.extra

		--Starting shop events
		if context.starting_shop then
			if crv.questb == quests.level_three[3] and to_big(G.GAME.dollars) >= to_big(100) then
				crv.three = "Active"
				crv.quest = crv.quest + 1
				SMODS.calculate_context({ change_quest = true, card = card, quest_set = "3" })
			elseif crv.questb == quests.level_four[3] and to_big(G.GAME.dollars) >= to_big(120) then
				crv.four = "Active"
				crv.quest = crv.quest + 1
				SMODS.calculate_context({ change_quest = true, card = card, quest_set = "4" })
			end
		end

		--Ending shop events
		if context.ending_shop then
			crv.rerolls = 0
		end

		--Reroll Shop events
		if context.reroll_shop then
			crv.rerolls = crv.rerolls + 1
			if crv.rerolls >= 10 and crv.questb == quests.level_two[3] then
				crv.two = "Active"
				crv.quest = crv.quest + 1
				SMODS.calculate_context({ change_quest = true, card = card, quest_set = "2" })
			elseif crv.rerolls >= 20 and crv.questb == quests.level_three[2] then
				crv.three = "Active"
				crv.quest = crv.quest + 1
				SMODS.calculate_context({ change_quest = true, card = card, quest_set = "3" })
			end
		end

		--End of round events
		if context.end_of_round and context.main_eval then
			if G.GAME.current_round.hands_played == 1 and crv.questb == quests.level_two[2] then
				crv.two = "Active"
				crv.quest = crv.quest + 1
				SMODS.calculate_context({ change_quest = true, card = card, quest_set = "2" })
			end
		end

		--Individual events
		if context.individual and context.cardarea == G.play then
			if crv.three == "Active" then
				context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
				context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + crv.perma_mult
				return {
					message = localize("k_upgrade_ex"),
				}
			end
			if crv.questb == quests.level_two[1] then
				if SMODS.has_enhancement(context.other_card, "m_stone") then
					crv.two = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "2" })
				end
			end
		end

		--Joker Main events
		if context.joker_main then
			if crv.one == "Active" and crv.two == "Inactive" then
				return {
					xmult = crv.xmult,
				}
			elseif crv.one == "Active" and crv.two == "Active" then
				return {
					xmult = crv.xmult,
					xchips = crv.xchips,
				}
			end
			if crv.questb == quests.level_one[1] then
				if context.scoring_name == "Flush" then
					crv.one = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "1" })
				end
			elseif crv.questb == quests.level_one[3] then
				if context.scoring_name == "High Card" then
					crv.one = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "1" })
				end
			elseif crv.questb == quests.level_three[1] then
				if context.scoring_name == "Four of a Kind" then
					crv.three = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "3" })
				end
			elseif crv.questb == quests.level_four[1] then
				if context.scoring_name == "Five of a Kind" then
					crv.four = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "4" })
				end
			elseif crv.questb == quests.level_four[2] then
				if context.scoring_name ~= RevosVault.most_played() then
					crv.four = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "4" })
				end
			end
		end

		-- Consumable events

		if context.using_consumeable then
			if crv.questb == quests.level_one[2] then
				if context.consumeable.ability.set == "Planet" then
					crv.one = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "1" })
				end
			elseif crv.questb == quests.level_one[4] then
				if context.consumeable.config.center.key == "c_strength" then
					crv.one = "Active"
					crv.quest = crv.quest + 1
					SMODS.calculate_context({ change_quest = true, card = card, quest_set = "1" })
				end
			end
		else
			if crv.questb == quests.level_four[4] then
				crv.four = "Active"
				crv.quest = crv.quest + 1
				SMODS.calculate_context({ change_quest = true, card = card, quest_set = "4" })
			end
		end

		--Changing quests
		if context.change_quest and context.card == card then
			if context.quest_set == "1" then
				crv.questb = pseudorandom_element(quests.level_two, pseudoseed("inga"))
			elseif context.quest_set == "2" then
				crv.questb = pseudorandom_element(quests.level_three, pseudoseed("inga"))
			elseif context.quest_set == "3" then
				crv.questb = pseudorandom_element(quests.level_four, pseudoseed("inga"))
			elseif context.quest_set == "4" then
				crv.questb = "No More Quests!"
				crv.xmult = crv.xmult * 2
				crv.xchips = crv.xchips * 2
			end
			card_eval_status_text(card, "extra", nil, nil, nil, { message = "New Quest!" })
		end
	end,

	in_pool = function(self, wawa, wawa2)
		return true
	end,
})