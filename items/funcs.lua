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

function RevosVault.shop_card(with, replace, set, keep)
	local c = false
	if replace and set then
		local inshop = {}
		for i = 1, #G.shop_jokers.cards do
			if G.shop_jokers.cards[i].ability.set == set then
				inshop[#inshop + 1] = G.shop_jokers.cards[i]
			end
		end
		if #inshop > 0 then
			if keep then
				local ca = pseudorandom_element(inshop)
				ca:juice_up()
				ca:set_ability(with.key)
			else
			SMODS.destroy_cards(pseudorandom_element(inshop), true, true)
			end
			c = true
		else
			c = false
		end
	end
	if not replace then
		local carde = SMODS.create_card({
			key = with.key,
			area = G.shop_jokers,
			skip_materialize = true,
		})
		create_shop_card_ui(carde, "Joker", G.shop_jokers)
		carde.states.visible = false
		carde:start_materialize()
		carde.ability.couponed = true
		carde:set_cost()
		G.shop_jokers:emplace(carde)
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


--Holy Yap. Also, needs playing card support!!!!
function RevosVault.replacecards(area, replace, bypass_eternal, keep, keeporiginal) --Cards not keeping editions/seals/stickers is intended. //Probably extremely inefficient /// Like why tf did i make the keep n entire seperate section. I probably wont even use "replace" or teh destruction part of this like ever.
	if G.shop_booster and area == G.shop_booster.cards or G.shop_vouchers and area == G.shop_vouchers.cards then --Setting the area as these 2 disables the entire thing below and will not have a support for them anytime soon cause NONE of the jokers does anything with destroyed booster PACKS and VOUCHERS. Including mods
		if area == G.shop_booster.cards then
			for i = 1, #area do
				local tab = {}
				for i = 1, #G.P_CENTER_POOLS.Booster do
					tab[#tab + 1] = G.P_CENTER_POOLS.Booster[i].key
				end
				if area[i] ~= keeporiginal then
					area[i]:juice_up()
					area[i]:set_ability(pseudorandom_element(tab))
				end
				tab = {}
			end
		end
		if area == G.shop_vouchers.cards then
			for i = 1, #area do
				local tab = {}
				for i = 1, #G.P_CENTER_POOLS.Voucher do
					tab[#tab + 1] = G.P_CENTER_POOLS.Voucher[i].key
				end
				if area[i] ~= keeporiginal then
					area[i]:juice_up()
					area[i]:set_ability(pseudorandom_element(tab))
				end
				tab = {}
			end
		end
	else
		if keep then
			for i = 1, #area do
				if area[i].config.center.rarity then
					local b
					local rarity
					if not replace then
						for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
							if area[i].config.center.rarity == k then
								rarity = k
								b = k
							end
						end
						if rarity == 1 then
							rarity = "Common"
						elseif rarity == 2 then
							rarity = "Uncommon"
						elseif rarity == 3 then
							rarity = "Rare"
						elseif rarity == 4 then
							rarity = "Legendary"
						end
						local set = area[i].ability.set
						local tab = {}
						for i = 1, #G.P_CENTER_POOLS.Joker do
							if G.P_CENTER_POOLS.Joker[i].rarity == b then
								tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
							end
						end
						if area[i] ~= keeporiginal then
							area[i]:juice_up()
							area[i]:set_ability(pseudorandom_element(tab))
							tab = {}
						end
					else
						local set = area[i].ability.set
						local rarity = SMODS.poll_rarity(set)
						local b = rarity
						if rarity == 1 then
							rarity = "Common"
						elseif rarity == 2 then
							rarity = "Uncommon"
						elseif rarity == 3 then
							rarity = "Rare"
						elseif rarity == 4 then
							rarity = "Legendary"
						end
						local tab = {}
						for i = 1, #G.P_CENTER_POOLS.Joker do
							if G.P_CENTER_POOLS.Joker[i].rarity == b then
								tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
							end
						end
						if area[i] ~= keeporiginal then
							area[i]:juice_up()
							area[i]:set_ability(pseudorandom_element(tab))
						end
						tab = {}
					end
				elseif area[i].ability.set then
					local set = area[i].ability.set
					local tab = {}
					--[[	if G.STATE == G.STATES.STANDARD_PACK or area == G.hand.cards then
						area[i]:juice_up()
						local _suit, _rank =
							pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
						SMODS.change_base(area[i], _suit, _rank)
						area[i]:set_ability(SMODS.poll_enhancement())
						area[i]:set_edition(poll_edition())
					else]]
					for i = 1, #G.P_CENTER_POOLS.Consumeables do
						if G.P_CENTER_POOLS.Consumeables[i].set == set then
							tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
						end
					end
					if area[i] ~= keeporiginal then
						area[i]:juice_up()
						area[i]:set_ability(pseudorandom_element(tab))
					end
				end
			end
			--end
		else
			if replace then --Doesnt stick to joker rarities
				for i = 1, #area do
					if bypass_eternal then
						if area[i].ability.set and area[i] ~= keeporiginal then
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					else
						if area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					end
				end
			else
				for i = 1, #area do
					if bypass_eternal then
						if area[i].config.center.rarity and area[i] ~= keeporiginal then --Reroll them while keeping the same rarity
							local rarity
							if area[i].config.center.rarity == 1 then
								rarity = "Common"
							elseif area[i].config.center.rarity == 2 then
								rarity = "Uncommon"
							elseif area[i].config.center.rarity == 3 then
								rarity = "Rare"
							elseif area[i].config.center.rarity == 4 then
								rarity = "Legendary"
							else
								rarity = area[i].config.center.rarity
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								rarity = rarity,
								area = G.pack_cards,
							})
						elseif area[i].ability.set and area[i] ~= keeporiginal then
							--[[			if G.STATE == G.STATES.STANDARD_PACK or area == G.hand.cards then
								SMODS.destroy_cards(area[i])
								local _suit, _rank =
									pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
								local acard = SMODS.create_card({
									set = "Playing Card",
									area = area,
								})
								SMODS.change_base(acard, _suit, _rank)
								acard:set_ability(SMODS.poll_enhancement())
								acard:set_edition(poll_edition())
							else]]
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
						--end
					else
						if area[i].config.center.rarity and not area[i].ability.eternal and area[i] ~= keeporiginal then
							local rarity
							if area[i].config.center.rarity == 1 then
								rarity = "Common"
							elseif area[i].config.center.rarity == 2 then
								rarity = "Uncommon"
							elseif area[i].config.center.rarity == 3 then
								rarity = "Rare"
							elseif area[i].config.center.rarity == 4 then
								rarity = "Legendary"
							else
								rarity = area[i].config.center.rarity
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								rarity = rarity,
								area = G.pack_cards,
							})
						elseif area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
							--[[if G.STATE == G.STATES.STANDARD_PACK or area == G.hand.cards then
								SMODS.destroy_cards(area[i])
								local _suit, _rank =
									pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
								local acard = SMODS.create_card({
									set = "Playing Card",
									area = area,
								})
								SMODS.change_base(acard, _suit, _rank)
								acard:set_ability(SMODS.poll_enhancement())
								acard:set_edition(poll_edition())
							else]]
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					end
				end
			end
		end
	end
end
--end


function RevosVault.check(check)
	if check == "inblind" then
		return G.STATE == G.STATES.SELECTING_HAND
	end
end