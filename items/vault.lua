local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.consumable_uses = 0
    return ret
end

SMODS.Rarity {
    key = "va",
    badge_colour = G.C.PURPLE,
    pools = {}
}

SMODS.Consumable {
    key = 'VaultKey',
    set = 'Spectral',
    discovered = true,
    atlas = 'spec',
    hidden = true,
    soul_set = 'Spectral',
    soul_rate = 0.03,
    can_repeat_soul = false,
    pos = {
        x = 1,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = {}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        SMODS.add_card({
            set = "Joker",
            area = G.jokers,
            rarity = 'crv_va'
        })
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end

}

SMODS.Joker {
    key = 'vjim',
    atlas = 'Jokers2',
    rarity = 'crv_va',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {
        x = 3,
        y = 3
    },
    config = {
        extra = {
            odds = 4,
            xmult = 6,
            discards = 'N/A'

        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.xmult, card.ability.extra.odds, card.ability.extra.discards}
        }
    end,

    calculate = function(self, card, context)
        if G.GAME.current_round.discards_left > 0 then
            card.ability.extra.discards = G.GAME.current_round.discards_left
        end
        if G.GAME.current_round.discards_left == 0 then
            card.ability.extra.discards = 1
        end
        if context.joker_main and pseudorandom('vjim') < card.ability.extra.discards / card.ability.extra.odds then
            return {
                x_mult = -card.ability.extra.xmult
            }
        elseif context.joker_main then
            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end
}

local multi = {-100, -99, -98, -97, -96, -95, -94, -93, -92, -91, -90, -89, -88, -87, -86, -85, -84, -83, -82, -81, -80,
               -79, -78, -77, -76, -75, -74, -73, -72, -71, -70, -69, -68, -67, -66, -65, -64, -63, -62, -61, -60, -59,
               -58, -57, -56, -55, -54, -53, -52, -51, -50, -49, -48, -47, -46, -45, -44, -43, -42, -41, -40, -39, -38,
               -37, -36, -35, -34, -33, -32, -31, -30, -29, -28, -27, -26, -25, -24, -23, -22, -21, -20, -19, -18, -17,
               -16, -15, -14, -13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
               12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
               38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
               64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
               90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100}

SMODS.Joker {
    key = 'vsix',
    atlas = 'Jokers2',
    rarity = 'crv_va',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = {
        x = 4,
        y = 3
    },
    config = {
        extra = {
            multip2 = 'N/A'

        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multip2}
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        local random2_key = (pseudorandom_element(multi, pseudoseed("vsix")))
        card.ability.extra.multip2 = random2_key
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * card.ability.extra.multip2
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / card.ability.extra.multip2
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end
}


SMODS.Joker {
    key = 'vdna',
    atlas = 'Jokers2',
    pos = {
        x = 4,
        y = 4
    },
    rarity = 'crv_va',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    config = {
        extra = {}
    },
    calculate = function(self, card, context)

        if context.first_hand_drawn and not context.blueprint then
            local eval = function()
                return G.GAME.current_round.hands_played == 0
            end
            juice_card_until(card, eval, true)
        end

        if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_played == 0 then
            if #context.full_hand == 1 then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                _card:add_to_deck()
                if context.full_hand[1].ability.effect == "Base" then
                    _card:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true,})], true, false)
                end
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                G.hand:emplace(_card)
                _card.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = 'Mutated!',
                    colour = G.C.PURPLE,
                    playing_cards_created = {true}
                }
            end
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end
}

SMODS.Joker {
    key = 'vface',
    atlas = 'Jokers2',
    rarity = 'crv_va',
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = {
        x = 0,
        y = 5
    },
    config = {
        extra = {
            pmult = 20,
            mmult = -15,
            mxmult = -2,
            timer = 0

        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.pmult, card.ability.extra.mmult, card.ability.extra.mxmult,
                    card.ability.extra.timer}
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and (card.ability.extra.timer >= 15) then
            card.ability.extra.timer = 0
            return {
                xmult = card.ability.extra.mxmult
            }
        end
        if context.individual and context.cardarea == G.play and (card.ability.extra.timer < 15) then
            if context.other_card:is_face() then
                card.ability.extra.timer = card.ability.extra.timer + 1
                return {
                    mult = card.ability.extra.pmult
                }
            end
        end

        if context.individual and context.cardarea == G.play and (card.ability.extra.timer < 15) then
            if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 10 then
                card.ability.extra.timer = 0
                return {
                    mult = card.ability.extra.mmult
                }
            end
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end
}

--this def needs more abilities and downsides but as of now, im leavin it like that

SMODS.Joker {
    key = 'vprint',
    atlas = 'Jokers2',
    rarity = 'crv_va',
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {
        x = 7,
        y = 4
    },
    config = {
        extra = {

        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.pmult, card.ability.extra.mmult, card.ability.extra.mxmult,
                    card.ability.extra.timer}
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then

        local jokers = {}
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card then
                jokers[#jokers + 1] = G.jokers.cards[i] 
            end
        end
            --select the joker
        local other_joker = pseudorandom_element(jokers, pseudoseed('vprint'))
            --copy it
        if other_joker and other_joker ~= card then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then
                return
            end
            local other_joker_ret = other_joker:calculate_joker(context)
            if other_joker_ret then
                other_joker_ret.card = other_joker_ret.card or card
                other_joker_ret.colour = G.C.PURPLE
                return other_joker_ret
            end
        end
    end
end,
    in_pool = function(self, wawa, wawa2)
        return true
    end
}
SMODS.Joker {
    key = 'vmichel',
    atlas = 'Jokers2',
    rarity = 'crv_va',
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {
        x = 3,
        y = 6
    },
    config = {
        extra = { xmult = 30, odds = 12

        }
    },
    loc_vars = function(self, info_queue, card)
        local crv = card.ability.extra
        return {
            vars = {crv.xmult,crv.odds,(G.GAME.probabilities.normal or 1)}
        }
    end,

    calculate = function(self, card, context)
        local crv = card.ability.extra
        if context.setting_blind and pseudorandom('vmichel') < G.GAME.probabilities.normal / crv.odds and not context.repetition and not context.individual and not context.blueprint then
            local _first_dissolve = nil
                for k, v in pairs(G.jokers.cards) do
                    if (not v.ability.eternal) then v:start_dissolve(nil, _first_dissolve);_first_dissolve = true end
                end
            end
        if context.joker_main then
            return {
                x_mult = crv.xmult
            }
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end
}

