--Had to happen one day.

function RevosVault.check_enhancement(area, enhancement)
	local blss = 0
	if area and type(area) == "table" then
		for _, v in pairs(area) do
			if SMODS.has_enhancement(v, enhancement) then
				blss = blss + 1
			end
		end
		return blss
	end
	return 0
end

function joker_add(jKey)
	if type(jKey) == "string" then
		local j = SMODS.create_card({
			key = jKey,
		})

		j:add_to_deck()
		G.jokers:emplace(j)
		-- (Credit to @AstroLighz for the deck codes) --My dumbass couldn't figure this out back then ;-;
		SMODS.Stickers["eternal"]:apply(j, true)
	end
end

function RevosVault.suitcheck(suit, area)
	local suitcheck = 0
	if G.playing_cards then
		for _, v in pairs(area) do
			if v:is_suit(suit, nil, true) then
				suitcheck = suitcheck + 1
			end
		end
		return suitcheck
	end
	return 0
end

function RevosVault.discard(ammount, area)
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 1,
		func = function()
			local any_selected = nil
			local _cards = {}
			for i = 1, #area do
				_cards[#_cards + 1] = area[i]
			end
			RevosVault.discard_limit(ammount)
			for i = 1, ammount do
				if #area > 0 then
					local selected_card, card_key = pseudorandom_element(_cards, pseudoseed("hook"))
					G.hand:add_to_highlighted(selected_card, true)
					table.remove(_cards, card_key)
					any_selected = true
					play_sound("card1", 1)
				end
			end
			if any_selected then
				G.FUNCS.discard_cards_from_highlighted(nil, true)
				RevosVault.discard_limit(-ammount)
			end
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 1,
		func = function()
			if ammount > #area then
				for i = 1, #area do
					draw_card(G.deck, G.hand, i * 100 / #area, "up", true)
				end
			elseif ammount <= #area then
				for i = 1, ammount do
					draw_card(G.deck, G.hand, i * 100 / ammount, "up", true)
				end
			end
			return true
		end,
	}))
end

--Silent discard and play increase (idk if exists)
--Taken straight from SMODS

function RevosVault.discard_limit(mod)
	G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit + mod
	if G.GAME.starting_params.discard_limit < 0 then
		sendErrorMessage("Discard limit is less than 0", "HandLimitAPI")
	end
	G.hand.config.highlighted_limit =
		math.max(G.GAME.starting_params.discard_limit, G.GAME.starting_params.play_limit, 5)
end

function RevosVault.play_limit(mod)
	G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + mod
	if G.GAME.starting_params.play_limit < 1 then
		sendErrorMessage("Play limit is less than 1", "HandLimitAPI")
	end
	G.hand.config.highlighted_limit =
		math.max(G.GAME.starting_params.discard_limit, G.GAME.starting_params.play_limit, 5)
end

function RevosVault.total_limit(mod, silent)
	if silent then
		RevosVault.discard_limit(mod)
		RevosVault.play_limit(mod)
	else
		SMODS.change_discard_limit(mod)
		SMODS.change_play_limit(mod)
	end
end

function RevosVault.defeat()
	G.GAME.chips = G.GAME.blind.chips
	G.STATE = G.STATES.HAND_PLAYED
	G.STATE_COMPLETE = true
	end_round()
end

function RevosVault.find_lowest(area, reverse, card)
	if not card then
		if reverse then
			local low = 1
			local key = nil
			for i = 1, #area do
				if low <= area[i].base.id then
					low = area[i].base.id
					key = area[i]
				end
			end
			return key
		else
			local high = 15
			local key = nil
			for i = 1, #area do
				if high >= area[i].base.id then
					high = area[i].base.id
					key = area[i]
				end
			end
			return key
		end
	else
		if not reverse then
			local high = 0
			local key

			for i = 1, #area do
				local rcard = area
				if rcard[i].base.times_played > high then
					high = rcard[i].base.times_played
					key = rcard[i]
				end
			end
			return key
		else
			local high = 15
			local key

			for i = 1, #area do
				local rcard = area
				if rcard[i].base.times_played < high then
					high = rcard[i].base.times_played
					key = rcard[i]
				end
			end
			return key
		end
	end
end

function RevosVault.add_tag(random, ammount, key)
	if random and ammount then
		local tags = {}
		for k, v in pairs(G.P_TAGS) do
			table.insert(tags, v.key)
		end
		play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
		play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
		for i = 1, ammount do
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag(pseudorandom_element(tags, pseudoseed("jud_add_tag"))))
					return true
				end,
			}))
		end
	elseif key then
		play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
		play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
		for i = 1, ammount do
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag(key))
					return true
				end,
			}))
		end
	end
end

function RevosVault.random_joker(area)
	local jokers = {}
	for i = 1, #area do
		jokers[#jokers + 1] = area[i]
	end
	local result = pseudorandom_element(jokers, pseudoseed("jud_random_joker"))
	return result
end

function RevosVault.wheeloffortune(odds, area)
	local jokas = {}
	if pseudorandom("wof") < G.GAME.probabilities.normal / odds then
		for i = 1, #area do
			if not area[i].edition then
				jokas[#jokas + 1] = area[i]
			end
		end
		RevosVault.random_joker(jokas):set_edition(poll_edition("wheel_of_fortune", nil, true, true))
	end
end

function RevosVault.level_up_hand(hand, level)
	update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
		handname = localize(hand, "poker_hands"),
		chips = G.GAME.hands[hand].chips,
		mult = G.GAME.hands[hand].mult,
		level = G.GAME.hands[hand].level,
	})
	level_up_hand(used_consumable, hand, nil, level)
	update_hand_text({ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 }, {
		mult = 0,
		chips = 0,
		handname = localize(hand, "poker_hands"),
		level = G.GAME.hands[hand].level,
	})
end

function RevosVault.most_played()
	local _hand, _tally = nil, -1
	for k, v in ipairs(G.handlist) do
		if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
			_hand = v
			_tally = G.GAME.hands[v].played
		end
	end
	return _hand
end

function RevosVault.create_booster(pack)
	local key = pack
	local card = Card(
		G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
		G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
		G.CARD_W * 1.27,
		G.CARD_H * 1.27,
		G.P_CARDS.empty,
		G.P_CENTERS[key],
		{ bypass_discovery_center = true, bypass_discovery_ui = true }
	)
	card.cost = 0
	G.FUNCS.use_card({ config = { ref_table = card } })
	card:start_materialize()
	return true
end

function RevosVault.facepool()
	local faces = {}
	for _, v in ipairs(SMODS.Rank.obj_buffer) do
		local r = SMODS.Ranks[v]
		if r.face then
			table.insert(faces, r)
		end
	end
	return faces
end

function RevosVault.remove_all(area)
	for _, v in pairs(area) do
		if #area > 0 then
			SMODS.destroy_cards(v)
		end
	end
end

function RevosVault.crash()
	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function()
			error(message or "Force Crash")
		end,
	}))
end

function RevosVault.shop_card(acard, replace, set)
	local c = false
	if replace and set then
		local inshop = {}
		for i = 1, #G.shop_jokers.cards do
			if G.shop_jokers.cards[i].ability.set == set then
				inshop[#inshop + 1] = G.shop_jokers.cards[i]
			end
		end
		if #inshop > 0 then
			SMODS.destroy_cards(pseudorandom_element(inshop), true, true)
			c = true
		else
			c = false
		end
	end
	if not replace or c == true then
		local card = SMODS.create_card({
			key = pseudorandom_element(G.P_CENTER_POOLS.Superior).key,
			area = G.shop_jokers,
			skip_materialize = true,
		})
		create_shop_card_ui(card, "Joker", G.shop_jokers)
		card.states.visible = false
		card:start_materialize()
		card.ability.couponed = true
		card:set_cost()
		G.shop_jokers:emplace(card)
	end
end

function RevosVault.index(table, cards)
	for i, v in ipairs(table) do
		if v == cards then
			return i
		end
	end
	return nil
end