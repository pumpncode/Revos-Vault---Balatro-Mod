
-------------MOD CODE-------------


SMODS.Atlas{
    key = 'modicon', 
    path = 'modicon.png', 
    px = 34, 
    py = 34 
}
SMODS.Joker {
    key = 'revoo_.',
    loc_txt = {
      name = 'The Ace',
      text = {
        "Gains {X:mult,C:white}X#2#{} mult",
        "for each scored {C:attention}Ace.",
        "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"

      }
    },
    config = { extra = { xmult = 1,xmultg = 2 } },
    rarity = 4,
    atlas = 'rev',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 1, y = 0 },
    soul_pos = { x =0, y = 0 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = {  card.ability.extra.xmult,card.ability.extra.xmultg } }
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 14 and not context.blueprint and not context.repetition then
          card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultg
          return {
            message = "Upgraded!"
          }
         
        end
    end
        if context.joker_main then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

          in_pool = function(self, wawa, wawa2)
            return true
        end
  }

  
local ss = {
    G.P_CENTERS.m_bonus,
   G.P_CENTERS.m_mult,
   G.P_CENTERS.m_wild,
   G.P_CENTERS.m_glass,
   G.P_CENTERS.m_steel,
   G.P_CENTERS.m_stone,
   G.P_CENTERS.m_gold,
   G.P_CENTERS.m_lucky
                   }

                   

  SMODS.Joker {
    key = 'spuzzypp',
    loc_txt = {
      name = 'Blueberry',
      text = {
        "Every played {C:attention}card{}",
        "permanently gains",
        "{C:chips}+#1#{} Chips and", 
        "a {C:attention}Random Enhancement{} if",
        "the card has none when scored.",
        "+10 {C:attention}Extra Permanent {C:chips}Chips",
        "after a round ends"
      }
    },
    config = { extra = { chips = 50 } },
    rarity = 4,
    atlas = 'rev',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 1, y = 1 },
    soul_pos = { x =0, y = 1 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = {  card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
    if context.individual then
         if context.cardarea == G.play then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
                    for k, v in ipairs(context.scoring_hand) do 
                        if context.other_card.ability.effect == "Base" then
                            context.other_card:set_ability(pseudorandom_element(ss, pseudoseed("spuzzypp")))
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    return true
                                end
                            })) 
                        end

                    return {
                        extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                        colour = G.C.CHIPS,
                    }
            end
        end
    end
    if context.end_of_round and context.main_eval then
        card.ability.extra.chips = card.ability.extra.chips + 10
        return {
            message = '+10!',
            colour = G.C.CHIPS

        }
    end
end,

          in_pool = function(self, wawa, wawa2)
            return true
        end
  }

  local gvb = {'c_ankh', 'c_aura', 'c_black_hole', 'c_cryptid', 'c_deja_vu', 'c_ectoplasm', 'c_familiar', 'c_grim', 'c_hex', 'c_immolate', 'c_incantation', 'c_medium', 'c_ouija', 'c_sigil', 'c_soul', 'c_talisman', 'c_trance', 'c_wraith'
  }
  SMODS.Joker {
    key = 'adæm_',
    loc_txt = {
      name = 'Pandik',
      text = {
        "Allows {C:attention}Scrap{} to spawn in shop," ,
        "Gains {X:mult,C:white}x#2#{} Mult for each scrap used", 
        "after every {C:attention}5 Scraps{}, spawns a {C:dark_edition}Negative {C:attention}Spectral Card",
        "{C:inactive}(Currently #3#/5 Scrap and {X:mult,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = { extra = { xmult = 1, xmultg = 0.5, scrapc = 0, } },
    rarity = 4,
    atlas = 'rev',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 1, y = 2 },
    soul_pos = { x =0, y = 2 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = {  card.ability.extra.xmult,card.ability.extra.xmultg,card.ability.extra.scrapc } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center.key == 'c_crv_mp' and not context.blueprint or  context.using_consumeable and context.consumeable.config.center.key == 'c_crv_pickles'  and not context.blueprint or
             context.using_consumeable and context.consumeable.config.center.key == 'c_crv_horn' and not context.blueprint or context.using_consumeable and context.consumeable.config.center.key == 'c_crv_ap'  and not context.blueprint or
             context.using_consumeable and context.consumeable.config.center.key == 'c_crv_dc'  and not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultg
                card.ability.extra.scrapc = card.ability.extra.scrapc + 1
             end
             if context.joker_main then
                return {
                    x_mult = card.ability.extra.xmult
                }
             end
             if (card.ability.extra.scrapc == 5) then
                card.ability.extra.scrapc = 0
                local random_key = (pseudorandom_element(gvb, pseudoseed("adæm_")))
                local new_card = create_card(random_key, G.consumeables, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
             end
        end,
          in_pool = function(self, wawa, wawa2)
            return true
        end
  }

  SMODS.Joker {
    key = 'chainsawm',
    loc_txt = {
      name = 'The Ant',
      text = {
        "Gains {X:mult,C:white}X#2#{} mult",
        "for each scored {C:attention}Numbered Card.",
        "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"

      }
    },
    config = { extra = { xmult = 1,xmultg = 0.1 } },
    rarity = 4,
    atlas = 'rev',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 1, y = 3 },
    soul_pos = { x =0, y = 3 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = {  card.ability.extra.xmult,card.ability.extra.xmultg } }
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() >= 2 and  context.other_card:get_id() < 11  and not context.blueprint and not context.repetition then
          card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultg
          return {
            message = "Upgraded!"
          }
         
        end
    end
        if context.joker_main then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

          in_pool = function(self, wawa, wawa2)
            return true
        end
  }

  SMODS.Joker {
    key = 'snayn3',
    loc_txt = {
      name = 'Eren',
      text = {
        "{X:mult,C:white}X#1#{} Mult.",
        "Transforms into {C:attention}Titan{} if ready",
        "and there is a {C:attention}single hand{} remaining",
        "{C:inactive}(#2#/3 Rounds to be ready)"

      }
    },
    config = { extra = { xmult = 3, timer = 0  } },
    rarity = 4,
    atlas = 'rev',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 1, y = 4},
    soul_pos = { x = 0, y = 4 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult,card.ability.extra.timer } }
    end,
    calculate = function(self, card, context)
    if context.setting_blind and context.main_eval and not context.blueprint then
        card.ability.extra.timer = card.ability.extra.timer + 1
    end
    if (card.ability.extra.timer > 3) then
        card.ability.extra.timer = 3
    end
    if context.joker_main and G.GAME.current_round.hands_left == 1 and card.ability.extra.timer == 3 then 
        card.ability.extra.timer = 0
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            blockable = false,
            func = function()
              G.jokers:remove_card(card)
              card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              card = nil
              return true;
            end
          }))
          local new_card = create_card('Giant', G.jokers, nil, nil, nil, nil, 'j_crv_snayn3-2')
           new_card:add_to_deck()
          G.jokers:emplace(new_card)
        end
        if context.joker_main and not G.GAME.current_round.hands_left == 1 then
            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end
        
  }

  SMODS.Joker {
    key = 'snayn3-2',
    loc_txt = {
      name = 'Titan',
      text = {
        "{X:mult,C:white}X#1#{} Mult",
        "Transforms back to {C:attention}Eren",
        "when the round ends"

      }
    },
    config = { extra = { xmult = 20,} },
    rarity = 4,
    atlas = 'rev',
    blueprint_compat = true,
    discovered = false,
    no_collection = true,
    pos = { x = 1, y = 5},
    soul_pos = { x = 0, y = 5 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = {  card.ability.extra.xmult} }
    end,
    calculate = function(self, card, context)
    if context.joker_main then 
        return {
            x_mult = card.ability.extra.xmult
        }
    end
    if context.end_of_round and context.main_eval then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            blockable = false,
            func = function()
              G.jokers:remove_card(card)
              card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              card = nil
              return true;
            end
          }))
          local new_card = create_card('Eren', G.jokers, nil, nil, nil, nil, 'j_crv_snayn3')
           new_card:add_to_deck()
          G.jokers:emplace(new_card)
        end
    end
   
        
  }




--thanks to elial1(discord) for the example mod and youtube tutorials. Really helped me out

--HOLY BANANA AND PEDRO!!--

SMODS.Atlas{
    key = 'holybanana', 
    path = 'holybanana.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'pedro', 
    path = 'pedro.png', 
    px = 71, 
    py = 95 
}

SMODS.Rarity{
    key = "holy",
    badge_colour = G.C.RARITY[2],
    loc_txt = {
        name = 'Holy Banana', 
    },
    pools = {}, 
}

SMODS.Rarity{
    key = "pedro",
    badge_colour = G.C.RARITY[3],
    loc_txt = {
        name = 'Pedro', 
    },
    pools = {}, 
}

SMODS.Joker {
    key = 'holybanana',
    loc_txt = {
      name = '{C:uncommon}Holy Banana',
      text = {
        'Gives {X:mult,C:white}X#1# {} Mult',
        'and {C:chips}+#2#{} Chips.',
        '{C:green}#3# in #4#{} chance to get',
        'Sacrificed to the Divine',

      }
    },
    config = { extra = {  xmult = 4011, chips = 4011, odds = 4011 } },
    rarity = 'crv_holy',
    atlas = 'holybanana',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult,card.ability.extra.chips,(G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
          return {
            x_mult = card.ability.extra.xmult,
            chips = card.ability.extra.chips,
          }
        end
        if context.end_of_round and not context.repetition and not context.individual then
            if pseudorandom('holybanana') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                      play_sound('tarot1')
                      card.T.r = -0.2
                      card:juice_up(0.3, 0.4)
                      card.states.drag.is = true
                      card.children.center.pinch.x = true
                      G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                          G.jokers:remove_card(card)
                          card:remove()
                          card = nil
                          return true;
                        end,
                        
                  }))
                  return true
                end
              }))
              G.GAME.pool_flags.holybanana_extinct = true
              return {
                message = 'Sacrificed to the Divine!', 
                delay(0.6)
              }
            else
                return {
                    message = 'Shielded by Grace!', 
                    delay(0.6)
                }
    end
end
end
}       
SMODS.Joker {
    key = 'pedro',
    loc_txt = {
      name = '{C:rare}Pedro',
      text = {
        '{C:dark_edition}Rise and shine, sleepyhead',
      }
    },
    config = { extra = {  xmult = 42831398, chips = 42831398, } },
    rarity = 'crv_pedro',
    atlas = 'pedro',
    blueprint_compat = true,
    discovered = false,
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult,card.ability.extra.chips, } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
          return {
            x_mult = card.ability.extra.xmult,
            chips = card.ability.extra.chips,
          }
        end
end
}       


--atlass--

SMODS.Atlas{
    key = 'rev', 
    path = 'rev.png', 
    px = 71, 
    py = 95 
}



SMODS.Atlas{
    key = 'wip', 
    path = 'wip.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'v', 
    path = 'v.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'megaprinter', 
    path = 'mega.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'megaenh', 
    path = 'megaenh.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'ghost', 
    path = 'Ghost.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'Decks', 
    path = 'Decks.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'Decks2', 
    path = 'Decks2.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'Jokers', 
    path = 'Jokers.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'Jokers2', 
    path = 'Jokers2.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'tarots', 
    path = 'tarots.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'documents', 
    path = 'documents.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'documents_u', 
    path = 'documents2.png',
    px = 71,
    py = 95 
}

SMODS.Atlas{
    key = 'enh', 
    path = 'enh.png',
    px = 71,
    py = 95 
}

SMODS.Atlas{
    key = 'scrapss', 
    path = 'Scraps.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 't', 
    path = 'tiers.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'gb', 
    path = 'gb.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'gban', 
    path = 'gban.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'spec', 
    path = 'spectrals.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'tags', 
    path = 'tags.png', 
    px = 32, 
    py = 32 
}

SMODS.Atlas{
    key = 'mm', 
    path = 'mm.png', 
    px = 71, 
    py = 95 
}


---------------RARITIES-----------------

SMODS.Rarity{
    key = "p",
   badge_colour = G.C.RARITY[3],
   loc_txt = {
        name = 'Printer', -- used on rarity badge
    },
    pools = {
        ["Joker"] = { rate = 0.01 },
    }, 
    default_weight = 0.01
}

SMODS.Rarity{
    key = "va",
   badge_colour = G.C.PURPLE,
   loc_txt = {
        name = 'Vaulted', -- used on rarity badge
    },
    pools = {
        ["Joker"] = { rate = 0.01 },
    }, 
    default_weight = 0.01,
}






---------------ENHANCEMENTS-----------------


SMODS.Enhancement{
    key = "bulletproofglass",
    atlas = 'enh',
    pos = {x = 0, y = 0},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Bulletproof Glass',
        text = {
            '{X:mult,C:white}X#1#{} Mult.',
            '{C:green}#2# in #3# {}chance to',
            'turn into {C:attention}Glass',
        }},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    overrides_base_rank = false,
    any_suit = false,
    always_scores = false,
    weight = 0,
    config = {extra = {x_mult = 2, odds = 8}
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult,(G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
      end,
      calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
        return {
            x_mult = card.ability.extra.x_mult 
            }
        end
        if context.destroying_card and pseudorandom('bulletproofglass') < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.E_MANAGER:add_event(Event({
            
                func = function()
                    card:juice_up(0.3, 0.4)
                    card:set_ability(G.P_CENTERS["m_glass"])
                  card = nil
                  return true
                end
              }))
      end
    end


            

}

SMODS.Enhancement{
    key = "diamondcard",
    atlas = 'enh',
    pos = {x = 2, y = 0},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Diamond Card',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'while this card', 
            'stays in hand',
        }},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    overrides_base_rank = false,
    any_suit = false,
    always_scores = false,
    weight = 0,
    config = {extra = {x_mult = 2.5,}
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult} }
      end,
      calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.hand then
        return {
            x_mult = card.ability.extra.x_mult 
            }
        end
    end
}

SMODS.Enhancement{
    key = "soulcard",
    atlas = 'ghost',
    pos = {x = 0, y = 0},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Soul Card',
        text = {
            "{C:chips}A wandering soul",
        }},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    any_suit = false,
    always_scores = false,
    weight = 0,
    in_pool = function(self,wawa,wawa2)
        return false
    end,
}

SMODS.Enhancement{
    key = "mugged",
    atlas = 'enh',
    pos = {x = 1, y = 1},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Mugged',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'if played hand contains a {C:attention}Flush',
        }},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    overrides_base_rank = false,
    any_suit = false,
    always_scores = false,
    weight = 0,
    config = {extra = {xmult = 2,
    },},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,
      calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play and next(context.poker_hands['Flush']) then
            return {
                x_mult = card.ability.extra.xmult,
              }
    end
end
    }   

    SMODS.Enhancement{
        key = "aflame",
        atlas = 'enh',
        pos = {x = 1, y = 0},
        discovered = true,
        unlocked = true,
        loc_txt = { 
            name = 'Aflame',
            text = {
                '{X:mult,C:white}X#1#{} Mult',
                'if played hand contains a {C:attention}Full House',
            }},
        replace_base_card = false,
        no_rank = false,
        no_suit = false,
        overrides_base_rank = false,
        any_suit = false,
        always_scores = false,
        weight = 0,
        config = {extra = {xmult = 2,
        },},
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.xmult} }
          end,
          calculate = function(self, card, context, effect)
            if context.main_scoring and context.cardarea == G.play and next(context.poker_hands['Full House']) then
                return {
                    x_mult = card.ability.extra.xmult,
                  }
        end
    end
        }   

        SMODS.Enhancement{
            key = 'mega',
            atlas = 'megaenh',
            pos = {x = 0, y = 0},
            discovered = true,
            unlocked = true,
            loc_txt = { 
                name = 'Mega',
                text = {
                    '{X:mult,C:white}X#1#{} Mult when scored'
                }},
            replace_base_card = false,
            no_rank = false,
            no_suit = false,
            overrides_base_rank = false,
            any_suit = false,
            always_scores = false,
            weight = 0,
            config = {extra = {xmult = 4,
            },},
            loc_vars = function(self, info_queue, card)
                return { vars = {card.ability.extra.xmult} }
              end,
              calculate = function(self, card, context, effect)
                if context.main_scoring and context.cardarea == G.play then
                    return {
                        x_mult = card.ability.extra.xmult,
                      }
            end
        end
            }   

            SMODS.Enhancement{
                key = "tier1card",
                atlas = 't',
                pos = {x = 0, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Tier 1 Card',
                    text = {
                        '{C:chips}+#1#{} Chips',
                        'when scored'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 50,}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play then
                    return {
                        chips = card.ability.extra.chips
                        }
                    end
                end
            }
        
            SMODS.Enhancement{
                key = "tier2card",
                atlas = 't',
                pos = {x = 1, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Tier 2 Card',
                    text = {
                        '{C:chips}+#1#{} Chips and',
                        '{C:mult}+#2#{} Mult',
                        'when scored'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 100, mult = 10}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips,card.ability.extra.mult} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult
                        }
                    end
                end
            }
        
            SMODS.Enhancement{
                key = "tier3card",
                atlas = 't',
                pos = {x = 2, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Tier 3 Card',
                    text = {
                        '{C:chips}+#1#{} Chips and',
                        '{X:mult,C:white}X#2#{} Mult',
                        'when scored'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 200, x_mult = 3}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips,card.ability.extra.x_mult} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play then
                    return {
                        chips = card.ability.extra.chips,
                        x_mult = card.ability.extra.x_mult
                        }
                    end
                end
            }

            SMODS.Enhancement{
                key = "boostcard",
                atlas = 't',
                pos = {x = 3, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Boosted',
                    text = {
                        '{C:chips}+#1#{} Chips and',
                        '{X:mult,C:white}X#2#{} Mult',
                        'when scored',
                        'turns into a {C:attention}Tier 3 Card{}',
                        "after 3 times played",
                        '{C:inactive}(#3#/3)'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 250, x_mult = 4, handsp = 0}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips,card.ability.extra.x_mult,card.ability.extra.handsp} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play and not (card.ability.extra.handsp == 3) then
                        card.ability.extra.handsp = card.ability.extra.handsp + 1
                    return {
                        chips = card.ability.extra.chips,
                        x_mult = card.ability.extra.x_mult
                        }
                    end
                    if (card.ability.extra.handsp == 3) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:juice_up(0.3, 0.4)
                                card:set_ability(G.P_CENTERS["m_crv_tier3card"])
                              card = nil
                              return true
                            end
                        }))
            end
        end,
            in_pool = function(self,wawa,wawa2)
                return false
            end
            }

            SMODS.Enhancement{
                key = "blessedcard",
                atlas = 'enh',
                pos = {x = 0, y = 1},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Blessed',
                    text = {
                        '{C:green}#1# in #4#{} chance for {C:chips}+#8# {}Chips',
                        '{C:green}#1# in #3#{} chance for {C:mult}+#7#{{} Mult',
                        '{C:green}#1# in #2#{} chance for {X:mult,C:white}X#6#{} Mult',
                        '{C:green}#1# in #5#{} chance to win {C:money}$30{}',
                        '{C:inactive}(All can trigger on the same turn)'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = { odds = 5, odds2 = 3, odds3 = 2, odds4 = 10, xmult = 3, mult = 25, chips = 100, money = 30}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.odds2, card.ability.extra.odds3, card.ability.extra.odds4, card.ability.extra.xmult,card.ability.extra.mult,
                card.ability.extra.chips }} 
                  end,
                  calculate = function(self, card, context, effect)
                    local effect = {}
                    if pseudorandom('blessedcard') < G.GAME.probabilities.normal / card.ability.extra.odds2 and context.main_scoring and context.cardarea == G.play  then effect.mult = card.ability.extra.mult end
                    if pseudorandom('blessedcard') < G.GAME.probabilities.normal / card.ability.extra.odds and context.main_scoring and context.cardarea == G.play  then effect.x_mult = card.ability.extra.xmult end
                    if pseudorandom('blessedcard') < G.GAME.probabilities.normal / card.ability.extra.odds3 and context.main_scoring and context.cardarea == G.play  then effect.chips = card.ability.extra.chips end
                    if pseudorandom('blessedcard') < G.GAME.probabilities.normal / card.ability.extra.odds4 and context.main_scoring and context.cardarea == G.play  then effect.dollars = card.ability.extra.money end
                    return effect
                  end
            
                    }

                    SMODS.Enhancement{
                        key = "target",
                        atlas = 'enh',
                        pos = {x = 0, y = 2},
                        discovered = true,
                        unlocked = true,
                        loc_txt = { 
                            name = 'Target',
                            text = {
                                'Needs to go down!',
                                '{C:inactive} art by gmoonfucker'
                            }},
                        replace_base_card = true,
                        no_rank = true,
                        no_suit = true,
                        overrides_base_rank = true,
                        any_suit = false,
                        always_scores = false,
                        weight = 0,
                        config = {extra = {}
                        },
                        loc_vars = function(self, info_queue, card)
                            return { vars = {} }
                          end,
                          in_pool = function(self,wawa,wawa2)
                            return false
                        end
                    }


---------------CONSUMEABLES-----------------

SMODS.ConsumableType{
    key = 'scrap', --consumable type key
    collection_rows = {4,5}, --amount of cards in one page
    primary_colour = G.C.RED, --first color
    secondary_colour = G.C.RED , --second color
    loc_txt = {
        collection = 'Scraps', --name displayed in collection
        name = 'Scraps', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {'???'} --undiscovered text
        },
    },
    shop_rate = 1,
}

SMODS.UndiscoveredSprite{
    key = 'scrap',
    atlas = 'documents2.png',
    pos = {x = 0, y = 0}
}


SMODS.Consumable{
    in_pool = function(self,wawa,wawa2)
        if (#SMODS.find_card('j_crv_lpm') > 0) or (#SMODS.find_card('j_crv_adæm_') > 0) then
        return true
        elseif (#SMODS.find_card('j_crv_lpm') == 0) or (#SMODS.find_card('j_crv_adæm_') == 0) then
            return false
        end
    end,
    key = 'horn', 
    discovered = true,
    unlocked = true,
    set = 'scrap', 
    atlas = 'scrapss', 
    cost = 0,
    pos = {x = 2, y = 0}, 
    loc_txt = {
        name = 'Horn', 
        text = { 
            'Gives{C:money} 30$'
        },
        in_pool = function(self,wawa,wawa2)
            return false
        end,
    },
    can_use = function(self,card)
                return true
            end,
    use = function()
        return {
            ease_dollars(30),
        }
    end

}

    SMODS.Consumable{
        in_pool = function(self,wawa,wawa2)
            if (#SMODS.find_card('j_crv_lpm') > 0) or (#SMODS.find_card('j_crv_adæm_') > 0) then
            return true
            elseif (#SMODS.find_card('j_crv_lpm') == 0) or (#SMODS.find_card('j_crv_adæm_') == 0) then
                return false
            end
        end,
        key = 'pickles', 
        discovered = true,
        unlocked = true,
        set = 'scrap', 
        atlas = 'scrapss', 
        cost = 0,
        pos = {x = 0, y = 0}, 
        loc_txt = {
            name = 'Pickles', 
            text = { 
                'Gives{C:money} 25$'
            },
            in_pool = function(self,wawa,wawa2)
                return false
            end,
        },
        can_use = function(self,card)
                    return true
                end,
        use = function()
            return {
                ease_dollars(25),
            }
        end
    }
        SMODS.Consumable{
            in_pool = function(self,wawa,wawa2)
                if (#SMODS.find_card('j_crv_lpm') > 0) or (#SMODS.find_card('j_crv_adæm_') > 0) then
                return true
                elseif (#SMODS.find_card('j_crv_lpm') == 0) or (#SMODS.find_card('j_crv_adæm_') == 0) then
                    return false
                end
            end,
            key = 'mp', 
            discovered = true,
            unlocked = true,
            set = 'scrap', 
            atlas = 'scrapss', 
            cost = 0,
            pos = {x = 1, y = 0}, 
            loc_txt = {
                name = 'Metal Piece', 
                text = { 
                    'Gives{C:money} 20$'
                },
                in_pool = function(self,wawa,wawa2)
                    return false
                end,
            },
            can_use = function(self,card)
                        return true
                    end,
            use = function()
                return {
                    ease_dollars(20),
                }
            end
    

}

SMODS.Consumable{
    in_pool = function(self,wawa,wawa2)
        if (#SMODS.find_card('j_crv_lpm') > 0) or (#SMODS.find_card('j_crv_adæm_') > 0) then
        return true
        elseif (#SMODS.find_card('j_crv_lpm') == 0) or (#SMODS.find_card('j_crv_adæm_') == 0) then
            return false
        end
    end,
    key = 'ap',
    discovered = true,
    unlocked = true,
    set = 'scrap', 
    atlas = 'scrapss', 
    cost = 0,
    pos = {x = 3, y = 0}, 
    loc_txt = {
        name = 'Apparatus',
        text = {
            'Gives{C:money} 35$'
        },
        in_pool = function(self,wawa,wawa2)
            return false
        end,
    },
    can_use = function(self,card)
                return true
            end,
    use = function()
        return {
            ease_dollars(35),
        }
    end


}

SMODS.Consumable{
    in_pool = function(self,wawa,wawa2)
        if (#SMODS.find_card('j_crv_lpm') > 0) or (#SMODS.find_card('j_crv_adæm_') > 0) then
        return true
        elseif (#SMODS.find_card('j_crv_lpm') == 0) or (#SMODS.find_card('j_crv_adæm_') == 0) then
            return false
        end
    end,
    key = 'dc', 
    discovered = true,
    unlocked = true,
    set = 'scrap', 
    atlas = 'scrapss', 
    cost = 0,
    pos = {x = 4, y = 0}, 
    loc_txt = {
        name = 'Duck', 
        text = { 
            'Gives{C:money} 15$'
        },
        in_pool = function(self,wawa,wawa2)
            return false
        end,
    },
    can_use = function(self,card)
                return true
            end,
    use = function()
        return {
            ease_dollars(15),
        }
    end


}


local printer_keys = {'j_crv_printer','j_crv_rustyprinter','j_crv_jimboprinter','j_crv_grossprinter','j_crv_obeliskprinter','j_crv_moneyprinter','j_crv_brokenprinter','j_crv_faxprinter','j_crv_spectralprinter',
'j_crv_glassprinter','j_crv_lpm','j_crv_devilishprinter','j_crv_steelprinter','j_crv_tierp','j_crv_luckyprinter','j_crv_celestialprinter','j_crv_fcp','j_crv_pcp','j_crv_hcp','j_crv_ngp','j_crv_urp'}

SMODS.Consumable{
    key = 'ink&intuition', 
    set = 'Tarot',
    loc_txt = { 
        name = 'Ink & Intuition',
        text = {
            '{C:green}#1# in #2#{} chance to',
            'create a {C:attention}Printer',
            '{C:inactive}(Must have room)',
        },
    },
    config = { extra = { odds = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
      end, 
    pos = { x = 0, y = 0 },
    atlas = 'tarots',
    cost = 3,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
        return true
        end
    end,
    use = function(self,card)
        if pseudorandom('ink&intuition') < G.GAME.probabilities.normal / card.ability.extra.odds then   
            local random_key = printer_keys[math.random(#printer_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Tarot,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
            return true end }))
        end
        delay(0.6)
    end
        }

        local machine_keys = {"j_crv_head","j_crv_body","j_crv_back"}


        SMODS.Consumable{
            key = 'dreams&desires', 
            set = 'Tarot',
            loc_txt = { 
                name = 'Dreams & Desires',
                text = {
                    'Creates one of the three {C:attention}Machine Parts,',
                    "{C:inactive}(Must have room)",
                },
            },
            config = { extra = {}},
            loc_vars = function(self, info_queue, card)
                return { vars = {} }
              end, 
            pos = { x = 1, y = 0 },
            atlas = 'tarots',
            cost = 3,
            unlocked = true,
            discovered = true,
            can_use = function(self,card)
                if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                return true
                end
            end,
            use = function(self,card) 
                    local random_key = machine_keys[math.random(#machine_keys)]
                        local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                delay(1.5)
            end
                }

                SMODS.Consumable{
                    key = 'brush', 
                    set = 'Spectral',
                    loc_txt = { 
                        name = 'Brush',
                        text = {
                            "Add a {C:purple}Printer's Seal",
                            "to {C:attention}1{} selected",
                            'card in your hand'

                        },
                    },
                    config = { extra = { cards = 1}},
                    loc_vars = function(self, info_queue, card)
                        return { vars = {card.ability.extra.cards} }
                      end, 
                    pos = { x = 0, y = 0 },
                    atlas = 'spec',
                    cost = 3,
                    unlocked = true,
                    discovered = true,
                    can_use = function(self,card)
                        if G and G.hand then
                            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                                return true
                            end
                        end
                        return false
                    end,
                    use = function(self,card)
                        for i, card in pairs(G.hand.highlighted) do
                        card:set_seal('crv_ps')
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)

                    end
                end
                        }
 

        SMODS.ConsumableType{
            key = 'EnchancedDocuments',
        
            collection_rows = {4,5}, 
            primary_colour = G.C.WHITE, 
            secondary_colour = G.C.BLACK, 
            loc_txt = {
                collection = 'Contracts', 
                name = 'Contract', 
                undiscovered = {
                    name = '???',
                    text = {'???'} 
                }
            },
            shop_rate = 0, 
        }
    
        SMODS.UndiscoveredSprite{
            key = 'EnchancedDocuments', 
            atlas = 'documents_u',
            pos = {x = 0, y = 0}
        }
        
    
    
        SMODS.Consumable{
            key = 'glassdocument', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 'documents', 
            pos = {x = 0, y = 0}, 
            loc_txt = {
                name = 'Glass Contract',
                text = { 
                    'Turns #1# card into {C:attention}Glass',
                    '{C:green} #2# in #3#{} chance for it to be a',
                    '{C:dark_edition} Bulletproof Glass{}'
                }
            },
            config = {
                extra = {
                    cards = 1, odds = 4}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('glassdocument') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_bulletproofglass"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            else 
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_glass"])
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
            end
            
             end
             
            end,
        }

        SMODS.Consumable{
            key = 'steeldocument', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 3, y = 0}, --position in atlas
            loc_txt = {
                name = 'Steel Contract', --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Steel',
                    '{C:green} #2# in #3#{} chance for it to be',
                    '{C:dark_edition} Diamond{}'
                }
            },
            config = {
                extra = {
                    cards = 1, odds = 4}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('steeldocument') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_diamondcard"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            else 
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_steel"])
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
            end
             end
            end,
        }

        local imsofckntired = {'m_crv_aflame','m_crv_mugged'}

        SMODS.Consumable{
            key = 'devilscontract', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 1, y = 0}, --position in atlas
            loc_txt = {
                name = "Devil's Contract", --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Aflame or Mugged{}',
                    '{C:green} #2# in #3#{} chance for it to be a',
                    '{C:dark_edition} Soul Card{}'
                }
            },
            config = {
                extra = { cards = 1, odds = 4 }},
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('devilscontract') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_soulcard"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            else 
                local random_key = imsofckntired[math.random(#imsofckntired)]
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS[random_key])
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
            end
             end
            end,
        }
        
        SMODS.Consumable{
            key = 'megadoc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'megaenh', --atlas
            pos = {x = 1, y = 0}, --position in atlas
            loc_txt = {
                name = 'Mega Contract', --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Mega'
                }
            },
            config = {
                extra = {
                    cards = 1,}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_mega"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            end
        }

        SMODS.Consumable{
            key = 't1doc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 't', --atlas
            pos = {x = 0, y = 1}, --position in atlas
            config = {extra ={ cards = 1}},
            loc_txt = {
                name = 'Tier 1 Contract', --name of card
                text = { 
                    'Turns #1# card into a',
                    '{C:attention}Tier 1 Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_tier1card"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            end
        }
        SMODS.Consumable{
            key = 't2doc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 't', --atlas
            pos = {x = 1, y = 1},
            config = {extra ={ cards = 2}}, --position in atlas
            loc_txt = {
                name = 'Tier 2 Contract', --name of card
                text = { --text of card
                    'Turns up to #1# cards into a',
                    '{C:attention}Tier 2 Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_tier2card"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            end
        }
        SMODS.Consumable{
            key = 't3doc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 't', --atlas
            pos = {x = 2, y = 1},
            config = {extra = { cards = 3}}, --position in atlas
            loc_txt = {
                name = 'Tier 3 Contract', --name of card
                text = { --text of card
                    'Turns up to #1# card into a',
                    '{C:attention}Tier 3 Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_tier3card"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            end
        }

        SMODS.Consumable{
            key = 'boostdoc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 't', --atlas
            pos = {x = 3, y = 1},
            config = {extra = { cards = 1}}, --position in atlas
            loc_txt = {
                name = 'Boosted Contract', --name of card
                text = { --text of card
                    'Turns #1# card into a',
                    '{C:attention}Boosted Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_boostcard"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            end
        }

        SMODS.Consumable{
            key = 'luckydocument', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 2, y = 0}, --position in atlas
            loc_txt = {
                name = 'Lucky Contract', --name of card
                text = { --text of card
                    'Turns #1# card into a{C:attention} Lucky Card',
                    '{C:green} #2# in #3#{} chance for it to be a',
                    '{C:dark_edition} Blessed Card{}'
                }
            },
            config = {
                extra = {
                    cards = 1, odds = 4}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('luckydocument') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_blessedcard"])
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
            else 
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_lucky"])
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
            end
             end
            end,
        }

        SMODS.Consumable{
            key = 'polydoc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 2, y = 1}, --position in atlas
            loc_txt = {
                name = 'Polychrome Contract', --name of card
                text = { --text of card
                    'Turns #1# card into {C:dark_edition}Polychrome',
                }
            },
            config = {
                extra = {
                    cards = 1,}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_edition({polychrome = true}, true)
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
                end
     }
    
     SMODS.Consumable{
        key = 'foildoc', --key
        set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
        discovered = true,
        atlas = 'documents', --atlas
        pos = {x = 0, y = 1}, --position in atlas
        loc_txt = {
            name = 'Foil Contract', --name of card
            text = { --text of card
                'Turns #1# card into {C:dark_edition}Foil',
            }
        },
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                    return true
                end
            end
            return false
        end,
        use = function(self,card,area,copier)
                for i, card in pairs(G.hand.highlighted) do
                    card:set_edition({foil = true}, true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
            end
    }
    
    SMODS.Consumable{
        key = 'holdoc', --key
        set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
        discovered = true,
        atlas = 'documents', --atlas
        pos = {x = 1, y = 1}, --position in atlas
        loc_txt = {
            name = 'Holographic Contract', --name of card
            text = { --text of card
                'Turns #1# card into {C:dark_edition}Holographic',
            }
        },
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                    return true
                end
            end
            return false
        end,
        use = function(self,card,area,copier)
                for i, card in pairs(G.hand.highlighted) do
                    card:set_edition({holo = true}, true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
            end
    }
    
    SMODS.Consumable{
        key = 'negdoc', --key
        set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
        discovered = true,
        atlas = 'documents', --atlas
        pos = {x = 3, y = 1}, --position in atlas
        loc_txt = {
            name = 'Negative Contract', --name of card
            text = { --text of card
                'Turns #1# card into {C:dark_edition}Negative',
            }
        },
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                    return true
                end
            end
            return false
        end,
        use = function(self,card,area,copier)
                for i, card in pairs(G.hand.highlighted) do
                    card:set_edition({negative = true}, true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
            end
    }

    
        
    



---------------JOKER FUNCTIONS-----------------



function joker_add(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)
        -- (Credit to @AstroLighz for the deck codes)
        SMODS.Stickers["eternal"]:apply(j, true)


    end
end

function joker_add_etx(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)

    end
end

function joker_add_per(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)
        SMODS.Stickers["perishable"]:apply(j, true)

    end
end

function vvs()
    local vv = 0
    return vv
            end



-------JOKERS------



SMODS.Joker{
    key = 'printer', 
    loc_txt = { 
        name = 'Blueprinter',
        text = {
          'When Blind is selected,',
          'print a {C:attention}Blueprint{} Joker',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
    cost = 10, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 0, y = 0},
    config = { 
      extra = {

      }
    },

    calculate = function(self,card,context)
        
        if context.setting_blind and not context.blueprint then
            local new_card = create_card('Blueprint', G.jokers, nil,nil,nil,nil,'j_blueprint')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
   }

   SMODS.Joker{
    key = 'rustyprinter', 
    loc_txt = { 
        name = 'Rusty Printer',
        text = {
          'When Blind is selected,',
          'print a {C:attention}Brainstorm{} Joker',
        },

    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
    cost = 10, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 1, y = 0}, 
    config = { 
      extra = {

      }
    },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local new_card = create_card('Brainstorm', G.jokers, nil,nil,nil,nil,'j_brainstorm')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)

            end
        end,

    in_pool = function(self,wawa,wawa2)
        
        return true
    end,
   }

   SMODS.Joker{
    key = 'jimboprinter', 
    loc_txt = { 
        name = 'Jimbo Printer',
        text = {
          'When Blind is selected,',
          'print a {C:dark_edition}Negative {}{C:attention}Joker {}',
        },
   
    },
        atlas = 'Jokers', 
        rarity = 'crv_p',
        cost = 10, 
        unlocked = true,
        discovered = false,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = false,
        pos = {x = 2, y = 0},
        config = { 
          extra = {

      }
    },
    loc_vars = function(self,info_queue,center)
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            local new_card = create_card('Joker', G.jokers, nil,nil,nil,nil,'j_joker')
            new_card:set_edition({negative = true}, true)
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,

    in_pool = function(self,wawa,wawa2)
      
        return true
    end,
   }

   SMODS.Joker{
    key = 'grossprinter', 
    loc_txt = { 
        name = 'Gross Printer',
        text = {
          'When Blind is selected,',
          'print a {C:attention}Gros Michel{}',
          '{C:green}#1# in #2#{} chance to',
          'print {C:attention}Cavendish{} and',
          '{C:green}#1# in #3#{} chance to',
          'print a{C:attention} Holy Banana',
          'if somehow the {C:uncommon}Holy Banana{} gets',
          'Sacrified to the Divine, spawns {C:rare}Pedro{}',
          'when blind is selected',
          "{C:inactive}(Only 1 Pedro can be held at the same time)"

        
        },

    },
    atlas = 'Jokers', 
    rarity = 'crv_p',
    
    cost = 10, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 0, y = 1},
    config = { 
      extra = { odds = 100, odds2 = 1011

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds,card.ability.extra.odds2 },  } 
      end,

    calculate = function(self,card,context)

        if context.setting_blind and pseudorandom('grossprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local new_card = create_card('Cavendish', G.jokers, nil,nil,nil,nil,'j_cavendish')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        elseif context.setting_blind then
            local new_card = create_card('Gros Michel', G.jokers, nil,nil,nil,nil,'j_gros_michel')
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        end
        if context.setting_blind and pseudorandom('grossprinter') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
            local new_card = create_card('Holy Banana', G.jokers, nil,nil,nil,nil,'j_crv_holybanana')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
    end
    if G.GAME.pool_flags.holybanana_extinct == true and context.setting_blind and not (#SMODS.find_card('j_crv_pedro') >= 1) then
            local new_card = create_card('Pedro', G.jokers, nil,nil,nil,nil,'j_crv_pedro')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
    end
end,
    
    in_pool = function(self,wawa,wawa2)
        
        return true
    end,
   }

   SMODS.Joker{
    key = 'obeliskprinter', 
    loc_txt = { 
        name = 'Obelisk Printer',
        text = {
          'When Blind is selected,',
          'print a {C:dark_edition}Negative{} {C:attention}Obelisk{} Joker',
        },
    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
 
    cost = 10, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 1, y = 1}, 
    config = { 
      extra = {

      }
    },
    calculate = function(self, card, context)
        if context.setting_blind then
            local new_card = create_card('Obelisk', G.jokers, nil,nil,nil,nil,'j_obelisk')
            new_card:set_edition({negative = true}, true)
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return true
    end,
   }

   SMODS.Joker{
    key = 'moneyprinter', 
    loc_txt = { 
        name = 'Money Printer',
        text = {
          'When round ends,',
          'Gain {C:money}+$35{}',
        },
    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
 
    cost = 10, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 2, y = 1}, 
    config = { 
      extra = {
      }
    },
      
    in_pool = function(self,wawa,wawa2)
        return true
    end,

    calc_dollar_bonus = function(self,card)
        return 35
    end,
   }

    local card_keys = {
        'j_8_ball', 'j_abstract', 'j_acrobat', 'j_ancient', 'j_arrowhead', 'j_astronomer', 'j_banner', 'j_baron',
        'j_baseball', 'j_blackboard', 'j_bloodstone', 'j_blue_joker', 'j_blueprint', 'j_bootstraps', 'j_brainstorm',
        'j_bull', 'j_burglar', 'j_burnt', 'j_business', 'j_caino', 'j_campfire', 'j_card_sharp', 'j_cartomancer',
        'j_castle', 'j_cavendish', 'j_ceremonial', 'j_certificate', 'j_chaos', 'j_chicot', 'j_clever', 'j_cloud_9',
        'j_constellation', 'j_crafty', 'j_crazy', 'j_credit_card', 'j_delayed_grat', 'j_devious', 'j_diet_cola',
        'j_dna', 'j_drivers_license', 'j_droll', 'j_drunkard', 'j_duo', 'j_dusk', 'j_egg', 'j_erosion', 'j_even_steven',
        'j_faceless', 'j_family', 'j_fibonacci', 'j_flash', 'j_flower_pot', 'j_fortune_teller', 'j_four_fingers',
        'j_gift', 'j_glass', 'j_gluttenous_joker', 'j_golden', 'j_greedy_joker', 'j_green_joker', 'j_gros_michel',
        'j_hack', 'j_half', 'j_hallucination', 'j_hanging_chad', 'j_hiker', 'j_hit_the_road', 'j_hologram', 'j_ice_cream',
        'j_idol', 'j_invisible', 'j_joker', 'j_jolly', 'j_juggler', 'j_loyalty_card', 'j_luchador', 'j_lucky_cat',
        'j_lusty_joker', 'j_mad', 'j_madness', 'j_mail', 'j_marble', 'j_matador', 'j_merry_andy', 'j_midas_mask',
        'j_mime', 'j_misprint', 'j_mr_bones', 'j_mystic_summit', 'j_obelisk', 'j_odd_todd', 'j_onyx_agate', 'j_oops',
        'j_order', 'j_pareidolia', 'j_perkeo', 'j_photograph', 'j_popcorn', 'j_raised_fist', 'j_ramen', 'j_red_card',
        'j_reserved_parking', 'j_ride_the_bus', 'j_riff_raff', 'j_ring_master', 'j_rocket', 'j_rough_gem', 'j_runner',
        'j_satellite', 'j_scary_face', 'j_scholar', 'j_seance', 'j_seeing_double', 'j_selzer', 'j_shoot_the_moon',
        'j_shortcut', 'j_sixth_sense', 'j_sly', 'j_smeared', 'j_smiley', 'j_sock_and_buskin', 'j_space', 'j_splash',
        'j_square', 'j_steel_joker', 'j_stencil', 'j_stone', 'j_stuntman', 'j_supernova', 'j_superposition',
        'j_swashbuckler', 'j_throwback', 'j_ticket', 'j_to_the_moon', 'j_todo_list', 'j_trading', 'j_tribe', 'j_triboulet',
        'j_trio', 'j_troubadour', 'j_trousers', 'j_turtle_bean', 'j_vagabond', 'j_vampire', 'j_walkie_talkie', 'j_wee',
        'j_wily', 'j_wrathful_joker', 'j_yorick', 'j_zany'
    }
    
    SMODS.Joker{
        key = 'brokenprinter', 
        loc_txt = { 
            name = 'Broken Printer',
            text = {
              'When Blind is selected,',
              'print a {C:attention}Random Joker{}',

            },
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 2}, 
        config = { 
          extra = {
          }
        },
        calculate = function(self, card, context)
            if context.setting_blind then
                local random_key = card_keys[math.random(#card_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
             end
            end,

        in_pool = function(self, wawa, wawa2)
           
            return true
        end,
    }

    SMODS.Joker {
        key = 'faxprinter',
        loc_txt = {
          name = 'Fax Printer',
          text = {
            'When blind is selected,',
            "{C:green}#1# in #2#{} chance this",
            "card prints",
            "{C:attention} Paperwork",
          }
        },
        config = { extra = { odds = 4 } },
        discovered = false,
        unlocked = true,
        rarity = 'crv_p',
        atlas = 'Jokers',
        blueprint_compat = true,
        pos = { x = 1, y = 2 },
        cost = 10,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)
          return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
        end,
        calculate = function(self, card, context)
          if context.setting_blind then
            if pseudorandom('faxprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = create_card('Paper Work', G.jokers, nil,nil,nil,nil,'j_crv_pprwork')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end
    end,


        in_pool = function(self, wawa, wawa2)
           
            return true
        end

    }
    
    SMODS.Joker {
        key = 'pprwork',
        loc_txt = {
          name = 'Paperwork',
          text = {
            "Anything between {C:attention}9{} and {C:attention}2",
            "gives {C:chips}+#1#{} Chips and",
            "{C:mult}+#2#{} Mult when scored",
            '{C:inactive}(9 and 2 included){}',
          }
        },
        config = { extra = { chips = 20.4, mult = 9.8 } },
        rarity = 2,
        atlas = 'Jokers',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 2, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 9 then
              return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card.other_card
              }
            end
        end
    end,

              in_pool = function(self, wawa, wawa2)
                return false
            end
      }

      local spectral_keys = {'c_ankh', 'c_aura', 'c_black_hole', 'c_cryptid', 'c_deja_vu', 'c_ectoplasm', 'c_familiar', 'c_grim', 'c_hex', 'c_immolate', 'c_incantation', 'c_medium', 'c_ouija', 'c_sigil', 'c_soul', 'c_talisman', 'c_trance', 'c_wraith'
}

      SMODS.Joker{
        key = 'spectralprinter', 
        loc_txt = { 
            name = 'Spectral Printer',
            text = {
              'When Blind is selected,',
              'print a Random',
              '{C:dark_edition} Negative {C:attention}Spectral{}',
              '{C:attention}Card{}',
            },
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 3}, 
        config = { 
          extra = {
          }
        },
        calculate = function(self, card, context)
            if context.setting_blind then
                local random_key = spectral_keys[math.random(#spectral_keys)]
                local new_card = create_card(random_key, G.consumeables, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
             end
        end,
        in_pool = function(self, wawa, wawa2)
           
            return true
        end,
      }

      local leg_keys = {'j_caino','j_triboulet','j_yorick','j_chicot','j_perkeo'}

      SMODS.Joker{
        key = 'legendaryprinter', 
        loc_txt = { 
            name = 'Legendary Printer',
            text = {
              "{C:green}#1# in #2#{} chance this",
              "card prints a random {C:dark_edition}Perishable",
              "{C:dark_edition}Negative{C:attention} Legendary Joker"
            },
            
        },
        atlas = 'Jokers', 
        rarity = 4, 
        cost = 20, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 3},
        soul_pos = {x = 3, y = 3},
        config = { 
          extra = { odds = 3 }
          },
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self, card, context)
            if context.setting_blind then
              if pseudorandom('legendaryprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local random_key = (pseudorandom_element(leg_keys, pseudoseed("legendaryprinter")))
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                SMODS.Stickers['perishable']:apply(new_card, true)
              end
          end
          in_pool = function(self, wawa, wawa2)
           
            return false
        end
      end
       
    }

    SMODS.Joker{
        key = 'glassprinter', 
        loc_txt = { 
            name = 'Glass Printer',
            text = {
                'When blind is selected,',
                'Prints {C:attention}Glass Contract{} and{}',
                "has a {C:green}#1# in #2#{} chance to",
                "get destroyed",
              }
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 3},
        config = { extra = { odds = 16 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                if pseudorandom('glassprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local new_card = create_card('Glass Document', G.consumeables, nil,nil,nil,nil,'c_crv_glassdocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                          card.T.r = -0.2
                          card:juice_up(0.3, 0.4)
                          card.states.drag.is = true
                          card.children.center.pinch.x = true
                          G.E_MANAGER:add_event(Event({
                            func = function()
                              G.jokers:remove_card(card)
                              card:shatter()
                              card = nil
                              return true;
                            end
                          }))
                          return true
                        end
                      }))
                                else
                                    local new_card = create_card('Glass Document', G.consumeables, nil,nil,nil,nil,'c_crv_glassdocument')
                                    new_card:add_to_deck()
                                    G.consumeables:emplace(new_card)                   
                                end
                            end
                        end,
                
        in_pool = function(self,wawa,wawa2)
            return true
        end
    }

    SMODS.Joker{
        key = 'steelprinter', 
        loc_txt = { 
            name = 'Steel Printer',
            text = {
                'When blind is selected,',
                'Prints {C:attention}Steel Contract.{}',
                '{X:mult,C:white}X#1#{} Mult'
              }
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 0},
        config = { extra = { xmult = 1.5 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                    local new_card = create_card('Steel Document', G.consumeables, nil,nil,nil,nil,'c_crv_steeldocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
            end
            if context.joker_main then
                return  {
                    x_mult = card.ability.extra.xmult
                }
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return true
        end
    }
    
    SMODS.Joker{
        key = 'smile!', 
        loc_txt = { 
            name = 'Camera',
            text = {
              'If you have a {C:attention}Joker{} in hand,',
              '{C:green}#1# in #2#{} chance to create a',
              '{C:attention}Photograph{} when blind is',
              'selected',
            },
            
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 3, y = 0},
        config = { extra = { odds = 3 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
          end,
        calculate = function(self,card,context)
            if (#SMODS.find_card('j_joker') > 0) and context.setting_blind and
              pseudorandom('smile!') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = create_card('Photograph', G.jokers, nil,nil,nil,nil,'j_photograph')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return true
        end
       }

       SMODS.Joker{
        key = 'lpm', 
        loc_txt = { 
            name = 'Lethal Press Machine',
            text = {
                'When in inventory',
                'Has a chance to spawn {C:attention}Scrap',
                'in shop.',
                'Gains {C:mult}+#2# {}Mult for every {C:attention}Scrap used',
                '{C:inactive}(Currently{C:mult} +#1#{C:inactive} Mult)'
              },
            
        },
        atlas = 'Jokers',
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 3, y = 1},
        config = { 
          extra = { mult = 0, mult_gain = 15
          },},
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
          end,
          calculate = function(self, card, context)
            if context.joker_main then
              return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
              }
            end
            if context.using_consumeable and context.consumeable.config.center.key == 'c_crv_mp' and not context.blueprint or  context.using_consumeable and context.consumeable.config.center.key == 'c_crv_pickles'  and not context.blueprint or
             context.using_consumeable and context.consumeable.config.center.key == 'c_crv_horn' and not context.blueprint or context.using_consumeable and context.consumeable.config.center.key == 'c_crv_ap'  and not context.blueprint or
             context.using_consumeable and context.consumeable.config.center.key == 'c_crv_dc'  and not context.blueprint then
            
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                  message = 'The Company Is Hiring!',
                  delay = 1.3
                }
              end  
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end

        
       }

       SMODS.Joker{
        key = 'devilishprinter', 
        loc_txt = { 
            name = 'Devilish Printer',
            text = {
              'When blind is selected,',
              '{C:green}#1# in #2# {}chance to',
              "Print a {C:attention}Devil's Contract"
            },
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 0},
        config = { 
          extra = { odds = 2 }},
        loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self,card,context)
                if context.setting_blind and pseudorandom('devilishprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local new_card = create_card("Devil's Contract", G.consumeables, nil,nil,nil,nil,'c_crv_devilscontract')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                end
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }   

       SMODS.Joker{
        key = 'head', 
        loc_txt = { 
            name = 'Left Side of the Mega Printer',
            text = {
              'If all 3 parts of the mega printer',
              'are present, print an {C:attention}Mega Contract.',
              'Gives {C:mult}+#1#{} Mult.',
            },
            
        },
        atlas = 'megaprinter', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 0},
        config = { 
          extra = { mult = 25
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, } }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'body', 
        loc_txt = { 
            name = 'Middle of the Mega Printer',
            text = {
              'If all 3 parts of the mega printer',
              'are present, print an {C:attention}Mega Contract.',
              'Gives {C:mult}+#1#{} Mult.',
            },
            
        },
        atlas = 'megaprinter', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 0},
        config = { 
          extra = { mult = 30
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, } }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'back', 
        loc_txt = { 
            name = 'Right Side of the Mega Printer',
            text = {
              'If all 3 parts of the mega printer',
              'is present, print an {C:attention}Mega Contract.',
              'Gives {C:mult}+#1#{} Mult.',
            },
            
        },
        atlas = 'megaprinter', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 0},
        config = { 
          extra = { mult = 25
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, } }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
            if (#SMODS.find_card('j_crv_head') > 0) and (#SMODS.find_card('j_crv_body') > 0) and context.setting_blind then
                local new_card = create_card("Mega", G.consumeables, nil, nil, nil, nil, "c_crv_megadoc")
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'tierp', 
        loc_txt = { 
            name = 'Advanced Printer',
            text = {
                'Prints a {C:green}T1 Contract{}',
                'When blind is selected,',
                "Prints a{C:attention} T2 Contract{} after {C:attention}5 Rounds",
                'Prints a{C:attention} T3 Contract{} after {C:attention}15 Rounds',
                'After 15 Rounds have passed, prints a {C:attention}Boosted Contract',
                'after every {C:attention}5 Rounds{} instead of a T3 Contract',
                '{C:inactive}(#1#/15 Rounds have passed)',
                '{C:inactive}(#2#/5 Rounds until the next {C:attention}Boosted Contract)'
              }
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 0},
        config = { extra = { timer = 0, timer2 = 0}, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.timer, card.ability.extra.timer2 } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind and (card.ability.extra.timer == 15) and not (card.ability.extra.timer2 == 5) then
                    local new_card = create_card('Tier 3 Document', G.consumeables, nil,nil,nil,nil,'c_crv_t3doc')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
            elseif context.setting_blind and (card.ability.extra.timer >= 5) and not (card.ability.extra.timer == 15) then 
                    local new_card = create_card('Tier 2 Document', G.consumeables, nil,nil,nil,nil,'c_crv_t2doc')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
    
            else if context.setting_blind and not (card.ability.extra.timer > 4) then
                local new_card = create_card('Tier 1 Document', G.consumeables, nil,nil,nil,nil,'c_crv_t1doc')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
            end
            if context.end_of_round and not context.repetition and not context.individual and not (card.ability.extra.timer == 15) and not context.blueprint then
                    card.ability.extra.timer = card.ability.extra.timer + 1
            end
            if context.end_of_round and not context.repetition and not context.individual and (card.ability.extra.timer == 15) and not (card.ability.extra.timer2 == 5) and not context.blueprint then
                card.ability.extra.timer2 = card.ability.extra.timer2 + 1
            end
            if context.setting_blind and (card.ability.extra.timer2 == 5) then
                    local new_card = create_card('Boosted Document', G.consumeables, nil,nil,nil,nil,'c_crv_boostdoc')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                    card.ability.extra.timer2 = 0 
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return true
        end
    }

    SMODS.Joker{
        key = 'luckyprinter', 
        loc_txt = { 
            name = 'Lucky Printer',
            text = {
                'Prints {C:attention}Lucky Contract{}',
                'When blind is selected,',
                '{C:green}#1# in #2#{} Chance to print',
                '{C:attention}2{} Contracts instead of 1',
              }
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 1},
        config = { extra = { odds = 4 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1),card.ability.extra.odds } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                if pseudorandom('luckyprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local new_card = create_card('Lucky Document', G.consumeables, nil,nil,nil,nil,'c_crv_luckydocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
                    local new_card2 = create_card('Lucky Document', G.consumeables, nil,nil,nil,nil,'c_crv_luckydocument')
                    new_card2:add_to_deck()
                    G.consumeables:emplace(new_card2) 
                else
                    local new_card = create_card('Lucky Document', G.consumeables, nil,nil,nil,nil,'c_crv_luckydocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
                end
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return true
        end
    }
    
    local planet_keys = {'c_ceres', 'c_earth', 'c_eris', 'c_jupiter', 'c_mars', 'c_mercury', 'c_neptune', 'c_planet_x', 'c_pluto', 'c_saturn', 'c_uranus', 'c_venus', 
}

      SMODS.Joker{
        key = 'celestialprinter', 
        loc_txt = { 
            name = 'Celestial Printer',
            text = {
              'When Blind is selected,',
              'print a Random',
              '{C:dark_edition} Negative {C:attention}Planet{}',
              '{C:attention}Card{}',
            },
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 1}, 
        config = { 
          extra = {
          }
        },
        calculate = function(self, card, context)
            if context.setting_blind then
                local random_key = planet_keys[math.random(#planet_keys)]
                local new_card = create_card(random_key, G.consumeables, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
             end
        end,
        in_pool = function(self, wawa, wawa2)
           
            return true
        end,
      }

      SMODS.Joker{
        key = 'pcp', 
        loc_txt = { 
            name = 'Polychrome Printer',
            text = {
              'When Blind is selected,',
              'prints a {C:dark_edition}Polychrome Contract',
              "Gives {X:mult,C:white}X#1#{} Mult.",
              
            },
            
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
          end, 
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 4},
        config = { 
          extra = {
            xmult = 1.5
          }
        },
    
        calculate = function(self,card,context)
            
            if context.setting_blind then
                local new_card = create_card('Polychrome Document', G.consumeables, nil,nil,nil,nil,'c_crv_polydoc')
                new_card:add_to_deck()
                new_card:set_edition({polychrome = true},true)
                G.consumeables:emplace(new_card)
            end
        if context.joker_main then 
            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end,
    draw = function(self, card, layer)
        card.children.center:draw_shader('polychrome',nil, card.ARGS.send_to_shader)
    end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'fcp', 
        loc_txt = { 
            name = 'Foil Printer',
            text = {
              'When Blind is selected,',
              'prints a {C:dark_edition}Foil Contract',
              "Gives {C:chips}+#1#{} Chips.",
            },
            
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips } }
          end, 
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 4},
        config = { 
          extra = {
            chips = 50
          }
        },
    
        calculate = function(self,card,context)
            
            if context.setting_blind then
                local new_card = create_card('Foil Document', G.consumeables, nil,nil,nil,nil,'c_crv_foildoc')
                new_card:add_to_deck()
                new_card:set_edition({foil = true},true)
                G.consumeables:emplace(new_card)
            end
        if context.joker_main then 
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    draw = function(self, card, layer)
        card.children.center:draw_shader('foil',nil, card.ARGS.send_to_shader)
    end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'hcp', 
        loc_txt = { 
            name = 'Holographic Printer',
            text = {
              'When Blind is selected,',
              'prints a {C:dark_edition}Holographic Contract',
              "Gives {C:mult}+#1#{} Mult.",
            },
            
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult } }
          end, 
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 4},
        config = { 
          extra = {
            mult = 10
          }
        },
    
        calculate = function(self,card,context)
            
            if context.setting_blind then
                local new_card = create_card('Holographic Document', G.consumeables, nil,nil,nil,nil,'c_crv_holdoc')
                new_card:add_to_deck()
                new_card:set_edition({holo = true},true)
                G.consumeables:emplace(new_card)
            end
        if context.joker_main then 
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    draw = function(self, card, layer)
        card.children.center:draw_shader('holo',nil, card.ARGS.send_to_shader)
    end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'ncp', 
        loc_txt = { 
            name = 'Negative Printer',
            text = {
              'When Blind is selected,',
              'prints a {C:dark_edition}Negative Contract',
              "{C:attention}+1 Joker Slot.",
            },
            
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { } }
          end, 
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 10, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 3, y = 4},
        config = { 
          extra = { counter = 1
          }
        },
    
        calculate = function(self,card,context)
            
            if context.setting_blind then
                local new_card = create_card('Negative Document', G.consumeables, nil,nil,nil,nil,'c_crv_negdoc')
                new_card:add_to_deck()
                new_card:set_edition({negative = true},true)
                G.consumeables:emplace(new_card)
            end
end,
draw = function(self, card, layer)
    card.children.center:draw_shader('negative',nil, card.ARGS.send_to_shader)
    card.children.center:draw_shader('negative_shine',nil, card.ARGS.send_to_shader)
end,
add_to_deck = function(self,card,from_debuff)
    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
end,
remove_from_deck = function(self,card,from_debuff)
    G.jokers.config.card_limit = G.jokers.config.card_limit - 1
end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }



    SMODS.Joker {
        key = 'urp',
        loc_txt = {
          name = 'Unregistered Printer',
          text = {
            '{C:attention}Prints{} the Joker',
            'to the right.',
          }
        },
        config = { extra = {one = 0} },
        rarity = 'crv_p',
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 3, y = 1 },
        cost = 10,
        loc_vars = function(self, info_queue, card)
          return { vars = {} }
        end,
        calculate = function(self, card, context)
            if context.setting_blind and  #G.jokers.cards > 1 and (card.ability.extra.one == 0) then
                local rr = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then rr = i; break end
                end
                if G.jokers.cards[rr+1] ~= nil then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card2 = copy_card(G.jokers.cards[rr+1], nil, nil, G.jokers.cards[i] == card)
                        card2:add_to_deck()
                        G.jokers:emplace(card2)
                      return true
                    end
                  }))
                end
                if rr and G.jokers.cards[rr+1] then
                end
            end

        end,
            in_pool = function(self,wawa,wawa2)
                return true
        end
    }  

    



    SMODS.Joker{
        key = 'ghostbanana', 
        loc_txt = { 
            name = 'Ghost Banana',
            text = {
              '{C:chips}+#1# Chips',
              'Creates {C:dark_edition}Ghost Slices{} when',
              'blind is selected',
              '{C:inactive}(Must have room)'
            },
            
        },
        atlas = 'gb', 
        rarity = 2, 
        cost = 4, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = true, 
        pos = {x = 0, y = 0},
        config = { 
          extra = { chips = 100
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips } }
          end, 
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            end
            if context.setting_blind and #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                local new_card = create_card('Ghost Slices', G.jokers, nil, nil, nil, nil, 'j_crv_ghostslices')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'ghostslices', 
        loc_txt = { 
            name = 'Ghost Slices',
            text = {
              '{C:chips}+#1# Chips'
            },
            
        },
        atlas = 'gb', 
        rarity = 1, 
        cost = 1, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = true, 
        pos = {x = 1, y = 0},
        config = { 
          extra = { chips = 50
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.chips} }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }


       SMODS.Joker{
        key = 'plantain', 
        loc_txt = { 
            name = 'Plantain',
            text = {
              'This Joker gives {X:mult,C:white}X#2#{} Mult and',
              'has {C:green}#3# in #4#{} chance to go extinct',
              'after 3 rounds have passed',
              '{C:inactive}(#1#/3 Rounds have passed)'
            },
            
        },
        atlas = 'gban', 
        no_pool_flag = 'pex',
        rarity = 2, 
        cost = 6, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = true, 
        pos = {x = 1, y = 0},
        config = { 
          extra = { timer = 0 , xmult = 2, odds = 12},
          
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.timer, card.ability.extra.xmult,(G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self,card,context)
            if context.end_of_round and not context.repetition and not context.individual and not (card.ability.extra.timer == 3) then
                    card.ability.extra.timer = card.ability.extra.timer + 1
            end
            if context.joker_main and card.ability.extra.timer == 3 then
                return { 
                    x_mult = card.ability.extra.xmult
                }
                
            end
            if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
                if card.ability.extra.timer == 3 then
                if pseudorandom('plantin') < G.GAME.probabilities.normal / card.ability.extra.odds and not context.blueprint then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                          play_sound('tarot1')
                          card.T.r = -0.2
                          card:juice_up(0.3, 0.4)
                          card.states.drag.is = true
                          card.children.center.pinch.x = true
                          G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                              G.jokers:remove_card(card)
                              card:remove()
                              card = nil
                              return true;
                            end,
                            
                      }))
                      return true
                    end
                  }))
                  G.GAME.pool_flags.pex = true
                  return {
                    message = 'Extinct!', 
                    delay(0.6)
                  }
                else
                    return {
                        message = 'Safe!', 
                        delay(0.6)
                    }
            end
        end
    end
end,
        in_pool = function(self,wawa,wawa2)
            return true
        end
       }

       SMODS.Joker{
        key = 'reban', 
        loc_txt = { 
            name = 'Red Banana',
            text = {
              '{C:mult}+30{} Mult.',
              '{C:green}#2# in #3#{} Chance to go',
              'extinct'
            },
            
        },
        atlas = 'gban', 
        no_pool_flag = 'rex',
        rarity = 2, 
        cost = 6, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = true, 
        pos = {x = 0, y = 0},
        config = { extra = {  mult = 30, odds = 8 } },
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.mult,(G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
        end,
        calculate = function(self, card, context)
           if context.joker_main then
            return {
              mult = card.ability.extra.mult,
            }
          end
          if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
              if pseudorandom('reban') < G.GAME.probabilities.normal / card.ability.extra.odds and not context.blueprint then
                  G.E_MANAGER:add_event(Event({
                      func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                          trigger = 'after',
                          delay = 0.3,
                          blockable = false,
                          func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true;
                          end,
                          
                    }))
                    return true
                  end
                }))
                G.GAME.pool_flags.rex = true
                return {
                  message = 'Extinct!', 
                  delay(0.6)
                }
              else
                  return {
                      message = 'Safe!', 
                      delay(0.6)
                  }
        end
    end
    end
          }

          SMODS.Joker{
            key = 'tundan', 
            loc_txt = { 
                name = 'Latundan',
                text = {
                  '{C:green}#2# in #3#{} Chance to go',
                  'extinct.',
                  'Gains {C:chips}+#4#{} Chips{} for every round',
                  'without a {C:attention}Gros Michel',
                  '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
                },
                
            },
            atlas = 'gban',
            no_pool_flag = 'lex', 
            rarity = 2, 
            cost = 5, 
            unlocked = true, 
            discovered = false, 
            blueprint_compat = true,
            eternal_compat = true, 
            perishable_compat = true, 
            pos = {x = 2, y = 0},
            config = { extra = {  chips = 0, odds = 8, chip_gain = 15} },
            loc_vars = function(self, info_queue, card)
              return { vars = { card.ability.extra.chips,(G.GAME.probabilities.normal or 1), card.ability.extra.odds,card.ability.extra.chip_gain } }
            end,
            calculate = function(self, card, context)
               if context.joker_main then
                return {
                  chips = card.ability.extra.chips,
                }
            end
                if context.end_of_round and not context.repetition and not context.blueprint and not context.individual and not (#SMODS.find_card('j_gros_michel') >= 1) then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
                    return {
                        message = 'Upgraded!',
                        colour = G.C.CHIPS,
                        card = card
                    }
                end
                if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
                    if pseudorandom('tundan') < G.GAME.probabilities.normal / card.ability.extra.odds and not context.blueprint then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                              play_sound('tarot1')
                              card.T.r = -0.2
                              card:juice_up(0.3, 0.4)
                              card.states.drag.is = true
                              card.children.center.pinch.x = true
                              G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                  G.jokers:remove_card(card)
                                  card:remove()
                                  card = nil
                                  return true;
                                end,
                                
                          }))
                          return true
                        end
                      }))
                      G.GAME.pool_flags.lex = true
                      return {
                        message = 'Extinct!', 
                        delay(0.6)
                      }
                    else
                        return {
                            message = 'Safe!', 
                            delay(0.6)
                        }
              end
          end
            end
            }

            SMODS.Joker{
                key = 'bluj', 
                loc_txt = { 
                    name = 'Blue Java',
                    text = {
                      '{C:mult}+#1#{} Mult',
                      'Loses {C:mult}-#2#{} Mult every',
                      'round'
                    },
                    
                },
                atlas = 'gban', 
                no_pool_flag = 'bex',
                rarity = 2, 
                cost = 5, 
                unlocked = true, 
                discovered = false, 
                blueprint_compat = true,
                eternal_compat = true, 
                perishable_compat = true, 
                pos = {x = 0, y = 1},
                config = { extra = {  mult = 25, mult_r = 1} },
                loc_vars = function(self, info_queue, card)
                  return { vars = { card.ability.extra.mult,card.ability.extra.mult_r } }
                end,
                calculate = function(self, card, context)
                   if context.joker_main then
                    return {
                      mult = card.ability.extra.mult,
                    }
                end
                    if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
                        if not (card.ability.extra.mult == 1) then
                        card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_r
                        return {
                            message = 'Yummy!',
                            colour = G.C.MULT,
                            card = card
                        }
                    else 
                        G.E_MANAGER:add_event(Event({
                            func = function()
                              play_sound('tarot1')
                              card.T.r = -0.2
                              card:juice_up(0.3, 0.4)
                              card.states.drag.is = true
                              card.children.center.pinch.x = true
                              G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                  G.jokers:remove_card(card)
                                  card:remove()
                                  card = nil
                                  return true;
                                end
                              }))
                              return true
                            end
                          }))
                          G.GAME.pool_flags.bex = true
                          return {
                            message = 'Eaten!'
                          }
                        end
                      end
                    end
                  } 

                  SMODS.Joker{
                    key = 'bananavine', 
                    loc_txt = { 
                        name = 'Gros Vine',
                        text = {
                          'Creates a {C:attention}Gros Michel{} every time',
                          'a blind is selected.',
                          'After {C:attention}3 Gros Michel{} spawns, the joker',
                          '{C:mult}Self Destructs'
                        },
                        
                    },
                    atlas = 'gban', 
                    no_pool_flag = 'gex',
                    rarity = 2, 
                    cost = 5, 
                    unlocked = true, 
                    discovered = false, 
                    blueprint_compat = true,
                    eternal_compat = true, 
                    perishable_compat = true, 
                    pos = {x = 1, y = 1},
                    config = { extra = { timer = 0} },
                    loc_vars = function(self, info_queue, card)
                      return { vars = { card.ability.extra.timer } }
                    end,
                    calculate = function(self, card, context)
                       if context.setting_blind and not context.blueprint and not context.repetition and not context.individual then
                        if card.ability.extra.timer < 3 then
                            card.ability.extra.timer = card.ability.extra.timer + 1
                        local new_card = create_card('Gros Michel', G.jokers, nil,nil,nil,nil,'j_gros_michel')
                             new_card:add_to_deck()
                            G.jokers:emplace(new_card)
                    end
                     if context.setting_blind and (card.ability.extra.timer == 3) then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                  play_sound('tarot1')
                                  card.T.r = -0.2
                                  card:juice_up(0.3, 0.4)
                                  card.states.drag.is = true
                                  card.children.center.pinch.x = true
                                  G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                      G.jokers:remove_card(card)
                                      card:remove()
                                      card = nil
                                      return true;
                                    end
                                  }))
                                  return true
                                end
                              }))
                              G.GAME.pool_flags.gex = true
                              return {
                                message = 'Out of Bananas!'
                              }
                            end
                          end
                        end
                      } 

                      SMODS.Joker{
                        key = 'plainb', 
                        loc_txt = { 
                            name = 'Plain Banana',
                            text = {
                              'This joker gains {C:money}+$15{} sell value and',
                              'has a {C:green}#2# in #3#{} chance to go extinct',
                              'everytime a blind is selected',

                            },
                            
                        },
                        atlas = 'gban', 
                        no_pool_flag = 'pex2',
                        rarity = 3, 
                        cost = 6, 
                        unlocked = true, 
                        discovered = false, 
                        blueprint_compat = true,
                        eternal_compat = true, 
                        perishable_compat = true, 
                        pos = {x = 2, y = 1},
                        config = { extra = { extra_value = 3, odds = 2} },
                        loc_vars = function(self, info_queue, card)
                          return { vars = { card.ability.extra.extra_value,(G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
                        end,
                        calculate = function(self, card, context)
                         if context.setting_blind then 
                            if pseudorandom('plainb') < G.GAME.probabilities.normal / card.ability.extra.odds and not context.blueprint then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                      play_sound('tarot1')
                                      card.T.r = -0.2
                                      card:juice_up(0.3, 0.4)
                                      card.states.drag.is = true
                                      card.children.center.pinch.x = true
                                      G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.3,
                                        blockable = false,
                                        func = function()
                                          G.jokers:remove_card(card)
                                          card:remove()
                                          card = nil
                                          return true;
                                        end,
                                        
                                  }))
                                  return true
                                end
                              }))
                              G.GAME.pool_flags.pex2 = true
                              return {
                                message = 'Extinct!', 
                                delay(0.6)
                              }
                            else
                                card.ability.extra_value = card.ability.extra_value + 15
                                card:set_cost()
                                return { 
                                    message = 'Value Up!',
                                    delay(0.6)
                                }
                            end
                        end
                        end
                          } 

                          SMODS.Joker{
                            key = 'tickingb', 
                            loc_txt = { 
                                name = 'Ticking Banana',
                                text = {
                                  'After 3 rounds have passed,',
                                  'gives {X:mult,C:white}X#1#{} Mult and',
                                  '{C:mult}self-destructs',
                                  '{C:inactive}(#2#/3 Rounds have passed)'
                                },
                                
                            },
                            atlas = 'gban',
                            no_pool_flag = 'tex', 
                            rarity = 2, 
                            cost = 6, 
                            unlocked = true, 
                            discovered = false, 
                            blueprint_compat = true,
                            eternal_compat = true, 
                            perishable_compat = true, 
                            pos = {x = 1, y = 2},
                            config = { extra = { xmult = 15, timer = 0} },
                            loc_vars = function(self, info_queue, card)
                              return { vars = { card.ability.extra.xmult,card.ability.extra.timer } }
                            end,
                            calculate = function(self, card, context)
                                if context.end_of_round and not context.repetition and not context.individual and not (card.ability.extra.timer == 3) then
                                    card.ability.extra.timer = card.ability.extra.timer + 1
                                end
                             if context.joker_main then
                                if (card.ability.extra.timer == 3) then
                                    return {
                                        x_mult = card.ability.extra.xmult,
                                    },
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                          play_sound('tarot1')
                                          card.T.r = -0.2
                                          card:juice_up(0.3, 0.4)
                                          card.states.drag.is = true
                                          card.children.center.pinch.x = true
                                          G.E_MANAGER:add_event(Event({
                                            trigger = 'after',
                                            delay = 1.5,
                                            blockable = false,
                                            func = function()
                                              G.jokers:remove_card(card)
                                              card:remove()
                                              card = nil
                                              return true;
                                            end
                                          }))
                                          G.GAME.pool_flags.tex = true
                                          return true
                                        end
                                      }))

                                    end
                                end
                            end
                            
                              } 
        local rkeys = { '1','2','3','4','5','6','7','8','9','10'}
        SMODS.Joker {
        key = 'uneasyb',
        loc_txt = {
          name = 'Uneasy Banana',
          text = {
            "{X:mult,C:white}X#1#{} Mult",
            '{C:green}1 in 10{} Chance for this to',
            'make you {C:mult}Lose the run',
            'when blind is selected',
            '{C:inactive}(Dice wont affect the chances)',
        },},
        config = { extra = { xmult = 15, } },
        rarity = 2,
        atlas = 'gban',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 0, y = 2},
        cost = 4,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.xmult,} }
        end,
        calculate = function(self, card, context)
        if context.joker_main then
              return {
                x_mult = card.ability.extra.xmult,
              }
            end
            if context.setting_blind then 
                local random_key = rkeys[math.random(#rkeys)]
            if (random_key == '5') and not context.repetition and not context.individual then
                G.STATE = G.STATES.GAME_OVER
                G.STATE_COMPLETE = false
            end

        end
    end,

              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

    
      function bfps()
        local bfps2 = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_bulletproofglass') then
                    bfps2 = bfps2 + 1
                end
            end
            return bfps2
        end
        return 0
    end

      
       SMODS.Joker {
        key = 'bpj',
        loc_txt = {
          name = 'Bulletproof Joker',
          text = {
            "Gives {X:mult,C:white}X#2#{} Mult",
            "for each {C:attention}Bulletproof Glass",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
          }
        },
        config = { extra = {  x_gain = 0.4, bfps(),} },
        
        rarity = 2,
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 0, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.x_gain*bfps()+1, card.ability.extra.x_gain, bfps() } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if bfps() > 0 then
                    return {
                        x_mult = bfps()* card.ability.extra.x_gain + 1
                    }
                end
            end
        end,
        in_pool = function(self, wawa, wawa2)
            return true
        end
      }

      function dcs()
        local dcss = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_diamondcard') then
                    dcss = dcss + 1
                end
            end
            return dcss
        end
        return 0
    end
    

      SMODS.Joker {
        key = 'dcj',
        loc_txt = {
          name = 'Diamond Joker',
          text = {
            "Gives {X:mult,C:white}X#2#{} Mult",
            "for each {C:attention}Diamond Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
          }
        },
        config = { extra = {  x_gain = 0.3, dcs()} },
        rarity = 2,
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 2, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.x_gain*dcs()+1, card.ability.extra.x_gain, dcs() } }
        end,
        calculate = function(self, card, context)

            if context.joker_main then
                if dcs() > 0 then
                    return {
                        x_mult = dcs()*card.ability.extra.x_gain+1
                    }
                end
            end     
            end,
              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function mgc()
        local mgcc = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_mugged') then
                    mgcc = mgcc + 1
                end
            end
            return mgcc
        end
        return 0
    end

      SMODS.Joker {
        key = 'mgj',
        loc_txt = {
          name = 'Mugged Joker',
          text = {
            "Gives {X:mult,C:white}X#2#{} Mult",
            "for each {C:attention}Mugged Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
          }
        },
        config = { extra = {  x_gain = 0.2, mgc()} },
        rarity = 2,
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 1, y = 3 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.x_gain*mgc()+1, card.ability.extra.x_gain, mgc() } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if mgc() > 0 then
                    return {
                        x_mult = mgc() * card.ability.extra.x_gain+1
                    }
                end
            end
        end,


              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function flm()
        local flmm = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_aflame') then
                    flmm = flmm + 1
                end
            end
            return flmm
        end
        return 0
    end

      SMODS.Joker {
        key = 'amj',
        loc_txt = {
          name = 'Aflame Joker',
          text = {
            "Gives {X:mult,C:white}X#2#{} Mult",
            "for each {C:attention}Aflame Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
          }
        },
        config = { extra = {  x_gain = 0.2, flm()} },
        rarity = 2,
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 1, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.x_gain*flm()+1, card.ability.extra.x_gain, flm() } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if flm() > 0 then
                    return {
                        x_mult = flm() * card.ability.extra.x_gain+1
                    }
                end
            end
                
            end,


              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function mg()
        local mgg = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_mega') then
                    mgg = mgg + 1
                end
            end
            return mgg
        end
        return 0
    end
      


      SMODS.Joker {
        key = 'mj',
        loc_txt = {
          name = 'Mega Joker',
          text = {
            "Gives {X:mult,C:white}X#2#{} Mult",
            "for each {C:attention}Mega Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
          }
        },
        config = { extra = {  x_gain = 0.4, mg()} },
        rarity = 2,
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 2, y = 1 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.x_gain*mg()+1, card.ability.extra.x_gain, mg() } }
        end,
        calculate = function(self, card, context)

            if context.joker_main then
                if mg() > 0 then
                    return {
                        x_mult = mg() * card.ability.extra.x_gain+1
                    }
                end
            end
                
            end,


              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function bls()
        local blss = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_blessedcard') then
                    blss = blss + 1
                end
            end
            return blss
        end
        return 0
    end

      SMODS.Joker {
        key = 'bj',
        loc_txt = {
          name = 'Blessed Joker',
          text = {
            "Gives {C:chips}+#5#{} Chips, {C:mult}+#4#{} Mult and {X:mult,C:white}X#2#{} Mult",
            "for each {C:attention}Blessed Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {C:chips}+#6#{} {C:inactive}Chips{}, {C:mult}+#7#{} {C:inactive}Mult and {X:mult,C:white}X#1#{} {C:inactive}Mult)"
          }
        },
        config = { extra = {  x_gain = 0.4, bls(), mult = 5, chips = 10,} },
        rarity = 2,
        atlas = 'Jokers2',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 0, y = 3 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.x_gain*bls()+1, card.ability.extra.x_gain, bls(), card.ability.extra.mult,card.ability.extra.chips,
          card.ability.extra.chips*bls(),card.ability.extra.mult*bls()} }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if bls() > 0 then
                    return {
                        chips = bls() * card.ability.extra.chips,
                        mult = bls() * card.ability.extra.mult,
                        x_mult = bls() * card.ability.extra.x_gain+1
                    }
                end
            end

            end,

              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function t1()
        local t11 = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_tier1card') then
                    t11 = t11 + 1
                end
            end
            return t11
        end
        return 0
    end

      SMODS.Joker {
        key = 't1j',
        loc_txt = {
          name = 'Tier 1 Joker',
          text = {
            "Gives {C:chips}+#2#{} Chips",
            "for each {C:attention}Tier 1 Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive})"
          }
        },
        config = { extra = { chips = 15, t1()} },
        rarity = 2,
        atlas = 't',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 0, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { t1(),card.ability.extra.chips,
          card.ability.extra.chips*t1()} }
        end,
        calculate = function(self, card, context)

            if context.joker_main then
                if t1() > 0 then
                    return {
                        chips = t1() * card.ability.extra.chips,
                    }
                end
            end       
            end,

              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function t2()
        local t22 = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_tier2card') then
                    t22 = t22 + 1
                end
            end
            return t22
        end
        return 0
    end

      SMODS.Joker {
        key = 't2j',
        loc_txt = {
          name = 'Tier 2 Joker',
          text = {
            "Gives {C:chips}+#2#{} Chips and {C:mult}+#3#{} Mult",
            "for each {C:attention}Tier 2 Card",
            "in your {C:attention}full deck{}",
            "{C:inactive}(Currently {C:chips}+#4#{C:inactive} and {C:mult}+#5#{C:inactive} Mult)"
          }
        },
        config = { extra = { chips = 30, mult = 5, t2()} },
        rarity = 2,
        atlas = 't',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 1, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { t2(),card.ability.extra.chips,card.ability.extra.mult,
          card.ability.extra.chips*t2(),card.ability.extra.mult*t2()} }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if t2() > 0 then
                    return {
                        chips = t2() * card.ability.extra.chips,
                        mult = t2() * card.ability.extra.mult,
                    }
                end
            end
            end,

              in_pool = function(self, wawa, wawa2)
                return true
            end
      }

      function t3()
        local t33 = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_tier3card') then
                    t33 = t33 + 1
                end
            end
            return t33
        end
        return 0
    end


        SMODS.Joker {
            key = 't3j',
            loc_txt = {
            name = 'Tier 3 Joker',
            text = {
                "Gives {C:chips}+#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
                "for each {C:attention}Tier 2 Card",
                "in your {C:attention}full deck{}",
                "{C:inactive}(Currently {C:chips}+#4#{C:inactive} and {X:mult,C:white}X#5#{C:inactive} Mult)"
            }
            },
            config = { extra = { chips = 50, xmult = 0.2, t3()} },
            rarity = 2,
            atlas = 't',
            blueprint_compat = true,
            discovered = false,
            pos = { x = 2, y = 2 },
            cost = 6,
            loc_vars = function(self, info_queue, card)
            return { vars = { t3(),card.ability.extra.chips,card.ability.extra.xmult,
            card.ability.extra.chips*t3(),card.ability.extra.xmult*t3()+1} }
            end,
            calculate = function(self, card, context)

                if context.joker_main then
                    if t3() > 0 then
                        return {
                            chips = t3() * card.ability.extra.chips,
                            x_mult = t3() * card.ability.extra.xmult+1
                        }
                    end
                end

                end,
                in_pool = function(self, wawa, wawa2)
                    return true
                end,
        }

           
      function hc()
        local hcc = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_crv_target') then
                    hcc = hcc + 1
                end
            end
            return hcc
        end
        return 0
    end


        SMODS.Joker {
            key = 'bh',
            loc_txt = {
              name = 'Bounty Hunter',
              text = {
                "When Blind is selected, a random playing card becomes a {C:red}Target {}if there is none",
                "Scoring a {C:red}Target {}eliminates it",
                "{C:money}+$5{} if Target is eliminated before the Blind is defeated, otherwise, -1 HP",
                "At 4 eliminations, creates a {C:dark_edition}Negative {C:attention}Legendary Joker",
                "At 0 HP, {X:mult,C:white}permanent{} -1 hand size",
                "{C:inactive}({C:green}#1# HP {C:inactive}remaining, {C:red}#3#/4 targets {C:inactive}eliminated)"
              }
            },
            config = { extra = { hp = 3, havecard = 0,needs = 0, money = 5, hand = -1, } },
            rarity = 3,
            atlas = 'Jokers2',
            blueprint_compat = false,
            discovered = false,
            pos = { x = 3, y = 0 },
            cost = 10,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.hp,card.ability.extra.havecard,card.ability.extra.needs,hc()} }
            end,
            add_to_deck = function(self, card, context)
                card.ability.extra.hp = 3
                card.ability.extra.needs = 0
                card.ability.extra.money = 5
                card.ability.extra.hand = -1
            end,
            calculate = function(self, card, context)
                 if context.setting_blind and not context.blueprint and not context.repetition and hc() == 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                     local card2 = pseudorandom_element(G.playing_cards, pseudoseed('bh'))
                     card2:set_ability(G.P_CENTERS["m_crv_target"])
                     return true
                    end
                  }))
                  return {
                    message = 'Target Set!'
                  }
                end
                if context.destroying_card and not context.blueprint then
                        for k, v in ipairs(context.scoring_hand) do
                    if v.config.center == G.P_CENTERS.m_crv_target and not (card.ability.extra.needs == 4) and not context.blueprint then
                        card.ability.extra.needs = card.ability.extra.needs + 1
                            return {
                                dollars = card.ability.extra.money,
                                message = 'Target Eliminated!',
                            }
                        end
                    end
                end
            if (card.ability.extra.needs == 4) and not context.blueprint and not context.repetition and not context.individual then
                G.E_MANAGER:add_event(Event({
                    func = function()
                      play_sound('tarot1')
                      card.T.r = -0.2
                      card:juice_up(0.3, 0.4)
                      card.states.drag.is = true
                      card.children.center.pinch.x = true
                      G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        func = function()
                          G.jokers:remove_card(card)
                          card:remove()
                          card = nil
                          return true;
                          
                        end
                        
                      }))
                      return true
                      
                    end              
                }))
                if context.after and not context.repetitive and not context.individual and not context.blueprint then
                local random_key = leg_keys[math.random(#leg_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                end
            end
                    if context.end_of_round and not context.repetition and not context.individual then 
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center == G.P_CENTERS.m_crv_target then
                                card.ability.extra.hp = card.ability.extra.hp - 1
                                return {
                                    message = 'Mission Failed!'
                                }
                    end
                end 
            end
        if (card.ability.extra.hp == 0) and not context.blueprint and not context.repetition and not context.individual then
            G.E_MANAGER:add_event(Event({
                func = function()
                  play_sound('tarot1')
                  card.T.r = -0.2
                  card:juice_up(0.3, 0.4)
                  card.states.drag.is = true
                  card.children.center.pinch.x = true
                  G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                      G.jokers:remove_card(card)
                      card:remove()
                      card = nil
                      return true;
                    end
                  }))
                  return true
                  
                end              
            }))
            G.hand:change_size(card.ability.extra.hand)
            return {
                message = 'Returning to post!'
            }
        end
    end
          }

          SMODS.Joker{
            key = 'flytrap', 
            loc_txt = { 
                name = 'Fly Trap',
                text = {
                  'Each time a {C:clubs}Club{} card is,',
                  'scored, gain {C:chips}+#1#{} Chips.',
                  '{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips)'
                },
                
            },
            atlas = 'Jokers2', 
            rarity = 2, 
            cost = 5, 
            unlocked = true, 
            discovered = false, 
            blueprint_compat = false,
            eternal_compat = true, 
            perishable_compat = false, 
            pos = {x = 3, y = 2},
            config = { 
              extra = { chipg = 10, chip = 0
        
              }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.chipg,card.ability.extra.chip } }
              end, 
        
            calculate = function(self,card,context)
                if context.individual and context.cardarea == G.play and context.other_card:is_suit('Clubs', true) then
                        card.ability.extra.chip = card.ability.extra.chip + card.ability.extra.chipg
                end
    
                    if context.joker_main then 
                        return {
                            chips = card.ability.extra.chip
                        }
                    end
                end,
                      in_pool = function(self, wawa, wawa2)
                        return true
                    end
              }
    
     SMODS.Joker{
      key = 'news', 
           loc_txt = { 
           name = 'Daily News Joker',
            text = {
               'Has a {C:green}#1# in #2#{} Chance to',
               'Create a {C:red}Coupon Tag{} everytime',
               'a round ends'
               },
                    
           },
           atlas = 'Jokers2', 
          rarity = 1, 
          cost = 5, 
          unlocked = true, 
          discovered = false, 
          blueprint_compat = false,
           eternal_compat = true, 
           perishable_compat = false, 
           pos = {x = 2, y = 3},
           config = { 
             extra = { odds = 4
    
             }
           },
           loc_vars = function(self, info_queue, card)
               return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
             end, 
    
           calculate = function(self,card,context)
               if context.end_of_round and not context.repetition and not context.individual and pseudorandom('couponist') < G.GAME.probabilities.normal / card.ability.extra.odds then 
                   G.E_MANAGER:add_event(Event({
                       func = (function()
                           add_tag(Tag('tag_coupon'))
                           play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                           play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                           return true
                       end)
                   }))
               end
           end,
                     in_pool = function(self, wawa, wawa2)
                       return true
                   end
             }

             SMODS.Joker {
                key = 'mtm',
                loc_txt = {
                  name = 'Mathematician',
                  text = {
                    "If played hand contains a {C:attention}3{},",
                    "This joker gives {X:mult,C:white}X#1#{} Mult."
                  }
                },
                config = { extra = {xmult = 3.14, tf = 'N/A'} },
                rarity = 3,
                atlas = 'Jokers2',
                blueprint_compat = true,
                discovered = false,
                pos = { x = 4, y = 1 },
                cost = 6,
                loc_vars = function(self, info_queue, card)
                  return { vars = {card.ability.extra.xmult,card.ability.extra.tf} }
                end,
                calculate = function(self, card, context)
                if context.individual and context.cardarea == G.play then
                    if context.other_card:get_id() == 3 then
                     card.ability.extra.tf = 'true'
                    end
                end
                if context.joker_main and (card.ability.extra.tf == 'true') then
                    card.ability.extra.tf = 'false'
                    return {
                        x_mult = card.ability.extra.xmult
                    }
                end
            end,
        
                      in_pool = function(self, wawa, wawa2)
                        return true
                    end
              }


              SMODS.Joker{
      key = 'news', 
           loc_txt = { 
           name = 'Daily News Joker',
            text = {
               'Has a {C:green}#1# in #2#{} Chance to',
               'Create a {C:red}Coupon Tag{} everytime',
               'a round ends'
               },
                    
           },
           atlas = 'Jokers2', 
          rarity = 1, 
          cost = 5, 
          unlocked = true, 
          discovered = false, 
          blueprint_compat = false,
           eternal_compat = true, 
           perishable_compat = false, 
           pos = {x = 2, y = 3},
           config = { 
             extra = { odds = 4
    
             }
           },
           loc_vars = function(self, info_queue, card)
               return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
             end, 
    
           calculate = function(self,card,context)
               if context.end_of_round and not context.repetition and not context.individual and pseudorandom('couponist') < G.GAME.probabilities.normal / card.ability.extra.odds then 
                   G.E_MANAGER:add_event(Event({
                       func = (function()
                           add_tag(Tag('tag_coupon'))
                           play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                           play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                           return true
                       end)
                   }))
               end
           end,
                     in_pool = function(self, wawa, wawa2)
                       return true
                   end
                }

                SMODS.Joker{
                    key = 'vrev',
                    loc_txt = {
                        name = 'Russian Roulette',
                        text = { "When {C:attention}Blind{} is selected,",
                        "permanently add {C:attention}x1.5",
                        "the sell value of the leftmost joker to this {X:mult,C:white}XMult{}.",
                        "However, has a {C:green}#1# in #2#{} chance of destroying the leftmost joker.",
                        "Chances are reduced if the leftmost joker is not destroyed.",
                        "Will {C:red}self-destruct{} if theres nothing on the left side or the leftmost joker has eternal.",
                        "Chances will {C:attention}reset{} if it hits {C:attention}1{} or the leftmost joker is {C:red}destroyed",
                        "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                                },
                    },
                    atlas = 'Jokers2',
                    pos = { x = 4, y = 2 },
                    rarity = 3,
                    cost = 5, 
                    unlocked = true,
                    discovered = false,
                    blueprint_compat = true,
                    eternal_compat = true,
                    config  = { extra = {odds = 6,mult = 1,} },
                    loc_vars = function(self, info_queue, card)
                        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds,card.ability.extra.mult} }
                      end, 
                    calculate = function(self,card,context)
                        if (card.ability.extra.odds == 1) then
                            card.ability.extra.odds = 6
                        end
                        if context.setting_blind and not context.blueprint then
                            if G.jokers.cards[1] == card or G.jokers.cards[1].ability.eternal then
                                          G.E_MANAGER:add_event(Event({
                                            trigger = 'after',
                                            delay = 0.3,
                                            blockable = false,
                                            func = function()
                                              G.jokers:remove_card(card)
                                              card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                                              card = nil
                                              return true;
                                            end
                                          }))
                                        end
        
                            if not card.getting_sliced and not G.jokers.cards[1].ability.eternal and not G.jokers.cards[1].getting_sliced then
                                if G.jokers.cards[1] ~= card then 
                                if pseudorandom('vrev') < G.GAME.probabilities.normal / card.ability.extra.odds then
                                    local sliced_card = G.jokers.cards[1]
                                    sliced_card.getting_sliced = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                                    G.E_MANAGER:add_event(Event({func = function()
                                        G.GAME.joker_buffer = 0
                                        card.ability.extra.mult = card.ability.extra.mult + sliced_card.sell_cost*1.5
                                        card.ability.extra.odds = 6
                                        card:juice_up(0.8, 0.8)
                                        sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                                    return true end }))
                                    return {
                                        message = 'Hit!',
                                        delay(0.6)
                                    }
                                else
                                    local sliced_card = G.jokers.cards[1]
                                    card.ability.extra.mult = card.ability.extra.mult + sliced_card.sell_cost*1.5
                                    card.ability.extra.odds = card.ability.extra.odds - 1
                                    return {
                                        message = "Miss!"
                                    }
                                end
                            end
                        end
                    end
                    if context.joker_main then
                        return {
                            x_mult = card.ability.extra.mult
                        }
                    end
                end,
            }



SMODS.Joker{
    key = 'ut', 
         loc_txt = { 
         name = 'Red Utopia',
          text = {
             "{X:red,C:white} X#1# {} Mult if all",
             "cards held in hand",
             "are between {C:attention}2{} and {C:attention}6{}",
             "{C:inactive}(2 and 6 included)"
             },
                  
         },
         atlas = 'Jokers2', 
        rarity = 2, 
        cost = 5, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
         eternal_compat = true, 
         perishable_compat = false, 
         pos = {x = 4, y = 0},
         config = { 
           extra = { xmult = 3
  
           }
         },
         loc_vars = function(self, info_queue, card)
             return { vars = { card.ability.extra.xmult} }
           end, 
  
         calculate = function(self,card,context)
            if context.joker_main then
            local numbers, all_cards = 0, 0
            for k, v in ipairs(G.hand.cards) do
                all_cards = all_cards + 1
                if v:get_id() >= 2 and v:get_id() <= 6 then
                    numbers = numbers + 1
                end
            end
            if numbers == all_cards then 
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
    end,
        in_pool = function(self,wawa,wawa2)
            return true
         end
           }


local suits = {1,2,3,4}
SMODS.Joker{
    key = 'smbj', 
         loc_txt = { 
         name = 'Whiteboard',
          text = {
            "{X:red,C:white} X#2# {} Mult if all",
             "cards held in hand are",
            "{C:attention}#3#{}",
            "{s:0.8}suit changes at end of round",
             },
                  
         },
         atlas = 'Jokers2', 
        rarity = 2, 
        cost = 5, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
         eternal_compat = true, 
         perishable_compat = false, 
         pos = {x = 5, y = 0},
         config = { 
           extra = { xmult = 3,randomsuit = 2,setsuit = "Spades"
  
           }
         },
         loc_vars = function(self, info_queue, card)
             return { vars = { card.ability.extra.randomsuit,card.ability.extra.xmult,card.ability.extra.setsuit} }
           end, 
    
           calculate = function(self,card,context)
            if context.end_of_round and not context.blueprint then
                card.ability.extra.randomsuit = (pseudorandom_element(suits, pseudoseed("ptm")))
                if card.ability.extra.randomsuit == 1 then card.ability.extra.setsuit = 'Clubs'
                elseif card.ability.extra.randomsuit == 2 then card.ability.extra.setsuit = 'Spades'
                elseif card.ability.extra.randomsuit == 3 then card.ability.extra.setsuit = 'Diamonds'
                elseif card.ability.extra.randomsuit == 4 then  card.ability.extra.setsuit = 'Hearts'
                end
            end
            --all cards calc
            if context.joker_main and not context.blueprint and not context.repetition then 
            local all_cards = 0
           for k, v in ipairs(G.hand.cards) do
               all_cards = all_cards + 1
               card.ability.extra.allcards = all_cards
           end
        end

            --checks for clubs
            if context.joker_main and card.ability.extra.randomsuit == 1 then
                print('a')
           local blackc_suits= 0
           for k, v in ipairs(G.hand.cards) do
               if v:is_suit('Clubs', nil, true) then
                   blackc_suits = blackc_suits + 1
               end
           end
           if blackc_suits == card.ability.extra.allcards then 
               return {
                   x_mult = card.ability.extra.xmult
               }
           end
        --checks for spades
        elseif context.joker_main and card.ability.extra.randomsuit == 2 then 
            print('a')

           local blacks_suits = 0
           for k, v in ipairs(G.hand.cards) do
               if v:is_suit('Spades', nil, true) then
                blacks_suits = blacks_suits + 1
               end
           end
           if blacks_suits == card.ability.extra.allcards then 
            return {
                x_mult = card.ability.extra.xmult
            }
           end
           --checks for diamonds
        elseif context.joker_main and card.ability.extra.randomsuit == 3 then 
            print('a')
           local redd_suits= 0
           for k, v in ipairs(G.hand.cards) do
               if v:is_suit('Diamonds', nil, true) then
                redd_suits = redd_suits + 1
               end
           end
           if redd_suits == card.ability.extra.allcards then 
            return {
                x_mult = card.ability.extra.xmult
            }
           end
           --check for hearts
        elseif context.joker_main and card.ability.extra.randomsuit == 4 then 
            print('a')
           local redh_suits= 0
           for k, v in ipairs(G.hand.cards) do
               if v:is_suit('Hearts', nil, true) then
                redh_suits = redh_suits + 1
               end
           end
           if redh_suits == card.ability.extra.allcards then 
            return {
                x_mult = card.ability.extra.xmult
            }
           end
       end
    end
           }



SMODS.Joker{
    key = 'checkpoint', 
    loc_txt = { 
        name = 'Checkpoint',
        text = {
          "When sold, gives back {C:attention}All {C:blue}Hands",
          "and {C:red}Discards{} used but {C:attention}Halves {}your total score",
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 2, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 5, y = 1},
    config = { 
      extra = {

      }
    },

    calculate = function(self,card,context)
        
      if context.selling_self then
        G.GAME.chips = G.GAME.chips/2
        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + G.GAME.current_round.hands_played 
        G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + G.GAME.current_round.discards_used
      end
        end,
    in_pool = function(self,wawa,wawa2)
        return true
    end,
   }

   
   SMODS.Joker{
    key = 'goldenshark', 
    loc_txt = { 
        name = 'Golden Shark',
        text = {
          'After {C:attention}3 rounds{} have passed, trigger a {C:gold}"Gold Rush",',
          'turning {C:attention}every scored card{} without an',
          "enhancement to {C:gold}Gold{}",
          '{C:inactive}(#2#)'
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 2, 
    cost = 6, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 5, y = 2},
    config = { 
      extra = { timer = 0 ,status = 'Not Ready'},
      
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.timer,card.ability.extra.status} }
      end, 
    calculate = function(self,card,context)
        if context.end_of_round and not context.repetition and not context.individual and not (card.ability.extra.timer == 3) then
                card.ability.extra.timer = card.ability.extra.timer + 1
        end
        
            if card.ability.extra.timer == 3 then
                card.ability.extra.status = 'Ready'
                    if context.cardarea == G.play then
                        for k, v in ipairs(context.scoring_hand) do 
                            if context.other_card.ability.effect == "Base" then
                                context.other_card:set_ability(G.P_CENTERS.m_gold)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        return true
                                    end
                                })) 
                            end
                end
        end
    end
    if card.ability.extra.timer == 3 and context.final_scoring_step then
        card.ability.extra.timer = 0
        card.ability.extra.status = 'Not Ready'
    end
end,
                     in_pool = function(self, wawa, wawa2)
                       return true
                   end
             }



SMODS.Joker{
    key = 'sfj', 
    loc_txt = { 
        name = 'Save File',
        text = {
          'Saves the {C:attention}half{} of your first',
          'score and returns it as {C:chips}+Chips.',
          "{C:red}resets{} at the end of a round",
          "{C:inactive}({C:chips}#1# {C:inactive}Stored)",
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 2, 
    cost = 6, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 5,y = 3},
    config = { 
      extra = { one = 0,chips = 0,ok = 0},
      
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.one,card.ability.extra.chips,card.ability.extra.ok,} }
      end, 


    calculate = function(self,card,context)

     if context.joker_main and next(SMODS.find_mod("Talisman")) and card.ability.extra.one == 0 and card.ability.extra.one == 0 and not context.blueprint and not context.repetition then
        card.ability.extra.ok = card.ability.extra.ok +1
        local chips = hand_chips * mult
        card.ability.extra.chips = chips
        card.ability.extra.one = to_number(card.ability.extra.chips/2)
        return{
            message = 'Stored!'
        }
     elseif context.joker_main and card.ability.extra.one == 0 and card.ability.extra.one == 0 and card.ability.extra.one == 0 and not context.blueprint and not context.repetition then
        card.ability.extra.ok = card.ability.extra.ok + 1
        local chips = hand_chips * mult
        card.ability.extra.chips = chips
        card.ability.extra.one = card.ability.extra.chips/2
        return{
            message = 'Stored!'
        }
    end
    if context.joker_main and next(SMODS.find_mod("Talisman")) and card.ability.extra.ok > 0 then
        if (#SMODS.find_card('j_crv_upgr') == 0) then
        return {
            chips = to_number(card.ability.extra.one)
        }
    elseif (#SMODS.find_card('j_crv_upgr') > 0 ) then
        return {
            mult = card.ability.extra.one
        }
    end
    elseif context.joker_main and card.ability.extra.ok > 0 then
        if (#SMODS.find_card('j_crv_upgr') == 0) then
        return {
            chips = card.ability.extra.one
        }
    elseif (#SMODS.find_card('j_crv_upgr') > 0 ) then
        return {
            mult = card.ability.extra.one
        }
    end
    end
    if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
        card.ability.extra.ok = 0
        card.ability.extra.one = 0
        return{
            message = 'Cleaning file...',
        }
    end
end,
                     in_pool = function(self, wawa, wawa2)
                       return true
                   end
             }



SMODS.Joker{
    key = 'upgr', 
    loc_txt = { 
        name = 'Upgrade',
        text = {
          "Does nothing on its own. However",
          "If {C:attention}Save File{} is present,",
          "upgrade it to give {C:mult}Mult{} instead of",
          "{C:chips}Chips"
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 3, 
    cost = 6, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true, 
    pos = {x = 6,y = 4},
    config = { 
      extra = {},
      
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
      end, 
                     in_pool = function(self, wawa, wawa2)
                       return true
                   end
             }

            
local chances = {1,2,3,4,5,6,7,8}


SMODS.Joker{
    key = 'btls', 
    loc_txt = { 
        name = 'Cubes United',
        text = {
          "Has a {C:green}1 in 8{} chance to ",
          "cause played cards to {C:purple}overscore",
          '{C:inactive}(Chances are not affected by',
          '{C:inactive}"Oops! All 6s" or anything similar)'
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 2, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 0},
    config = { 
      extra = { 

      }
    },

    calculate = function(self,card,context)

        if context.joker_main and next(SMODS.find_mod("Talisman")) and not context.blueprint and not context.repetition then
            local cc = (pseudorandom_element(chances, pseudoseed("btls")))
            if cc == 1 then
            return {
                chip_mod = to_number(G.GAME.blind.chips*4),
                message = 'Overscore!',
                colour = G.C.MULT
                
            }
        end
        elseif context.joker_main and not context.blueprint and not context.repetition then
            local cc = (pseudorandom_element(chances, pseudoseed("btls")))
            if cc == 1 then
            return {
                chip_mod = G.GAME.blind.chips*4,
                message = 'Overscore!',
                colour = G.C.MULT
            }
        end
    end
end,
                         in_pool = function(self, wawa, wawa2)
                           return true
                       end
                 }



SMODS.Joker{
    key = 'psy', 
    loc_txt = { 
        name = 'Pinpoint System',
        text = {
          "{X:mult,C:white}X#1#{} Mult",
          "if you have exactly {C:blue}2 hands{} and {C:red}discards{} remaining",
          "and played hand {C:attention}only{} contains {C:attention}two cards"
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 3, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 1},
    config = { 
      extra = { xmult = 22

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,

    calculate = function(self,card,context)
    if context.cardarea == G.jokers and context.joker_main and G.GAME.current_round.hands_left == 2 and  G.GAME.current_round.discards_left == 2 then
        if #context.full_hand == 2 then
            return {
                x_mult = card.ability.extra.xmult
            }
    
            end
        end
    end
        
                 }


SMODS.Joker{
    key = 'psy', 
    loc_txt = { 
        name = 'Pinpoint System',
        text = {
          "{X:mult,C:white}X#1#{} Mult",
          "if you have exactly {C:blue}2 hands{} and {C:red}discards{} remaining,",
          "and played hand {C:attention}only{} contains {C:attention}two cards"
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 3, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 1},
    config = { 
      extra = { xmult = 22

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,

    calculate = function(self,card,context)
    if context.cardarea == G.jokers and context.joker_main and G.GAME.current_round.hands_left == 2 and  G.GAME.current_round.discards_left == 2 then
        if #context.full_hand == 2 then
            return {
                x_mult = card.ability.extra.xmult
            }
    
            end
        end
    end
        
                 } 



SMODS.Joker{
    key = 'psy', 
    loc_txt = { 
        name = 'Pinpoint System',
        text = {
          "{X:mult,C:white}X#1#{} Mult",
          "if you have exactly {C:blue}2 hands{} and {C:red}discards{} remaining,",
          "and played hand {C:attention}only{} contains {C:attention}two cards"
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 3, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 1},
    config = { 
      extra = { xmult = 22

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,

    calculate = function(self,card,context)
    if context.cardarea == G.jokers and context.joker_main and G.GAME.current_round.hands_left == 2 and  G.GAME.current_round.discards_left == 2 then
        if #context.full_hand == 2 then
            return {
                x_mult = card.ability.extra.xmult
            }
    
            end
        end
    end
        
                 }




SMODS.Joker{
    key = 'mj4', 
    loc_txt = { 
        name = 'Majestic 4',
        text = {
          "{X:mult,C:white}X#1#{} Mult if played",
          "hand contains a {C:attention}Four of a Kind.",
          
        },
        
    },
    atlas = 'Jokers2', 
    rarity = 3, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 2},
    config = { 
      extra = { xmult = 4.4

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,

    calculate = function(self,card,context)
       if context.joker_main and next(context.poker_hands['Four of a Kind']) then
            return {
                x_mult = card.ability.extra.xmult
            }
    
            end
        end
        
                 }


SMODS.Joker{
    key = 'tp3', 
    loc_txt = { 
        name = 'The Perfect 3',
        text = {
            "{X:mult,C:white}X#1#{} Mult if played",
            "hand contains a {C:attention}Three of a Kind.",
          },
        
    },
    atlas = 'Jokers2', 
    rarity = 3, 
    cost = 5, 
    unlocked = true, 
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 6, y = 3},
    config = { 
      extra = { xmult = 3.3

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,

    calculate = function(self,card,context)
       if context.joker_main and next(context.poker_hands['Three of a Kind']) then
            return {
                x_mult = card.ability.extra.xmult
            }
    
            end
        end
        
                 }

                 SMODS.Joker{
                    key = 'ml', 
                    loc_txt = { 
                        name = 'Jimlord',
                        text = {
                            "{X:mult,C:white}X#1#{} Mult",
                            "Temporarily {C:red}Debuff{} a"  ,
                            "random joker when blind is selected.",
                            "{C:inactive}(Can debuff itself)"
                
                            
                        },
                        
                    },
                    atlas = 'Jokers2', 
                    rarity = 3, 
                    cost = 10, 
                    unlocked = true, 
                    discovered = false, 
                    blueprint_compat = false,
                    eternal_compat = true, 
                    perishable_compat = false, 
                    pos = {x = 1, y = 5,},
                    config = { 
                      extra = { xmult = 5,dcard = 'N/A'
                
                      }
                    },
                    loc_vars = function(self, info_queue, card)
                        return { vars = {card.ability.extra.xmult,card.ability.extra.dcard} }
                      end,
                
                    calculate = function(self,card,context)
                        if context.setting_blind and not context.repetition and not context.blueprint then
                            local jokers = {}
                            for i=1, #G.jokers.cards do 
                                if G.jokers.cards[i] ~= self then
                                    jokers[#jokers+1] = G.jokers.cards[i]
                                end
                            end
                            if #jokers > 1 then
                                if not context.blueprint then
                                    local chosen_joker = pseudorandom_element(jokers, pseudoseed('ml'))
                                    chosen_joker:set_debuff(true)
                                    if context.end_of_round and context.main_eval then
                                        chosen_joker:set_debuff(false)
                                    end
                                end
                        end
                    end
                        if context.joker_main then
                            return {
                                x_mult = card.ability.extra.xmult
                            }
                        end
                    end,
                    in_pool = function(self,wawa,wawa2)
                        return true
                    end,
                   }
                
                
                
                SMODS.Joker{
                    key = 'vji', 
                    loc_txt = { 
                        name = 'Vessel Jimbo',
                        text = {
                            "Gain {X:mult,C:white}X#2#{} Mult",
                            "for every card {C:red}discarded.",
                            "{C:attention}Capped{} at {C:attention}10{C:inactive} (#3#) {C:attention}times{} per round",
                            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                            
                
                            
                        },
                        
                    },
                    atlas = 'Jokers2', 
                    rarity = 2, 
                    cost = 10, 
                    unlocked = true, 
                    discovered = false, 
                    blueprint_compat = false,
                    eternal_compat = true, 
                    perishable_compat = false, 
                    pos = {x = 2, y = 5,},
                    config = { 
                      extra = { xmult = 1,mgain = 0.1,limit = 0
                
                      }
                    },
                    loc_vars = function(self, info_queue, card)
                        return { vars = {card.ability.extra.xmult,card.ability.extra.mgain,card.ability.extra.limit} }
                      end,
                
                    calculate = function(self,card,context)
                        if context.discard and not context.blueprint and not (card.ability.extra.limit >= 10) then
                            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mgain
                            card.ability.extra.limit = card.ability.extra.limit + 1
                            return {
                                message = 'Upgraded!',
                                colour = G.C.MULT
                            }
                        end
                        if context.joker_main then
                            return {
                                x_mult = card.ability.extra.xmult
                            }
                        end
                        if context.end_of_round and context.main_eval then
                            card.ability.extra.limit = 0
                        end
                    end,
                    in_pool = function(self,wawa,wawa2)
                        return true
                    end,
                   }






      
    
            
    ----------------DECKS----------------

    SMODS.Back{
        name = 'Machinery',
        key = 'mach',
        atlas = 'Decks',
        pos = {x = 0, y = 0},
        loc_txt = {
            name = 'Machinery',
            text = {
                'Start with an',
                'Eternal {C:attention}Blueprinter{}'
            },
        },
        
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_printer')
    
    
                    return true
                end
            }))
        end
    }

    
    SMODS.Back{
        name = 'Old Scroll',
        key = 'os',
        atlas = 'Decks',
        pos = {x = 1, y = 0},
        loc_txt = {
            name = 'Old Scroll',
            text = {
                'Start with an',
                'Eternal{C:attention} Rusty Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_rustyprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    
    SMODS.Back{
        name = 'Gold Mayhem',
        key = 'gm',
        atlas = 'Decks',
        pos = {x = 2, y = 1},
        loc_txt = {
            name = 'Gold Mayhem',
            text = {
                'Start with an',
                'Eternal {C:money}Money Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_moneyprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    
        SMODS.Back{
        name = 'Ripped Deck',
        key = 'rpd',
        atlas = 'Decks',
        pos = {x = 0, y = 2},
        loc_txt = {
            name = 'Ripped Deck',
            text = {
                'Start with an',
                'Eternal {C:attention}Broken Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_brokenprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = "Jimbo's World",
        key = 'jw',
        atlas = 'Decks',
        pos = {x = 2, y = 0},
        loc_txt = {
            name = 'Jimbo World',
            text = {
                'Start with an',
                'Eternal {C:attention}Jimbo Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_jimboprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Gross Deck',
        key = 'gd',
        atlas = 'Decks',
        pos = {x = 0, y = 1},
        loc_txt = {
            name = 'Gross Deck',
            text = {
                'Start with an',
                'Eternal {C:attention}Gross Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_grossprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'The Suspicious Desert',
        key = 'tsd',
        atlas = 'Decks',
        pos = {x = 1, y = 1},
        loc_txt = {
            name = 'The Suspicious Desert',
            text = {
                'Start with an',
                'Eternal {C:attention}Obelisk Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
                func = function ()
                    joker_add('j_crv_obeliskprinter')
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Speaking Fax',
        key = 'spx',
        atlas = 'Decks',
        pos = {x = 1, y = 2},
        loc_txt = {
            name = 'Speaking Fax',
            text = {
                'Start with an',
                'Eternal {C:attention}Fax Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
                func = function ()
                    joker_add('j_crv_faxprinter')
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Phantom Forge',
        key = 'phf',
        atlas = 'Decks',
        pos = {x = 2, y = 2},
        loc_txt = {
            name = 'Phantom Forge',
            text = {
                'Start with an',
                'Eternal {C:attention}Spectral Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
                func = function ()
                    joker_add('j_crv_spectralprinter')
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Hollow Gems',
        key = 'hg',
        atlas = 'Decks',
        pos = {x = 0, y = 3},
        loc_txt = {
            name = 'Hollow Gems',
            text = {
                'Start with an',
                'Eternal{C:attention} Legendary Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_legendaryprinter')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Glassbound',
        key = 'gb',
        atlas = 'Decks',
        pos = {x = 1, y = 3},
        loc_txt = {
            name = 'Glassbound',
            text = {
                'Start with an',
                'Eternal{C:attention} Glass Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_glassprinter')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Art Gallery',
        key = 'atg',
        atlas = 'Decks',
        pos = {x = 2, y = 3},
        loc_txt = {
            name = 'Art Gallery',
            text = {
                'Start with an',
                'Eternal{C:attention} Camera{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_smile!')
                    joker_add('j_joker')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'The Company Is Hiring!',
        key = 'tcih',
        atlas = 'Decks',
        pos = {x = 0, y = 4},
        loc_txt = {
            name = 'The Company Is Hiring!',
            text = {
                'Start with an',
                'Eternal{C:attention} Lethal Press Machine{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_lpm')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Devil's Casino",
        key = 'dc',
        atlas = 'Decks2',
        pos = {x = 0, y = 0},
        loc_txt = {
            name = "Devil's Casino",
            text = {
                'Start with an',
                'Eternal{C:attention} Devilish Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_devilishprinter')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "MDeck HQ",
        key = 'rf',
        atlas = 'Decks2',
        pos = {x = 1, y = 0},
        loc_txt = {
            name = "MDeck HQ",
            text = {
                'Start with an',
                'Eternal{C:attention} Completed Mega Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_head')
                    joker_add('j_crv_body')
                    joker_add('j_crv_back')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Steelbound",
        key = 'sb',
        atlas = 'Decks2',
        pos = {x = 2, y = 0},
        loc_txt = {
            name = "Steelbound",
            text = {
                'Start with an',
                'Eternal{C:attention} Steel Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_steelprinter')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Upgrade!",
        key = 'up',
        atlas = 'Decks2',
        pos = {x = 3, y = 0},
        loc_txt = {
            name = "Upgrade!",
            text = {
                'Start with an',
                'Eternal{C:attention} Advanced Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_tierp')

    
    
                    return true
                end
            }))
        end
    }
    SMODS.Back{
        name = "Lucky Pot",
        key = 'lp',
        atlas = 'Decks2',
        pos = {x = 0, y = 1},
        loc_txt = {
            name = "Lucky Pot",
            text = {
                'Start with an',
                'Eternal{C:attention} Lucky Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_luckyprinter')

    
    
                    return true
                end
            }))
        end
    }

    
    SMODS.Back{
        name = "Celestial Forge",
        key = 'cf',
        atlas = 'Decks2',
        pos = {x = 1, y = 1},
        loc_txt = {
            name = "Celestial Forge",
            text = {
                'Start with an',
                'Eternal{C:attention} Celestial Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_celestialprinter')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Polychrome Deck",
        key = 'pd',
        atlas = 'Decks2',
        pos = {x = 2, y = 2},
        loc_txt = {
            name = "Polychrome Deck",
            text = {
                'Start with an',
                'Eternal{C:attention} Polychrome Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_pcp')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Foil Deck",
        key = 'fd',
        atlas = 'Decks2',
        pos = {x = 0, y = 2},
        loc_txt = {
            name = "Foil Deck",
            text = {
                'Start with an',
                'Eternal{C:attention} Foil Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_fcp')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Holographic Deck",
        key = 'hd',
        atlas = 'Decks2',
        pos = {x = 1, y = 2},
        loc_txt = {
            name = "Holographic Deck",
            text = {
                'Start with an',
                'Eternal{C:attention} Holographic Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_hcp')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Negative Deck",
        key = 'nd',
        atlas = 'Decks2',
        pos = {x = 3, y = 2},
        loc_txt = {
            name = "Negative Deck",
            text = {
                'Start with an',
                'Eternal{C:attention} Negative Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_ncp')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        key = 'und',
        atlas = 'Decks2',
        pos = {x = 3, y = 1},
        loc_txt = {
            name = "Unregistered Deck",
            text = {
                'Start with an',
                'Eternal{C:attention} Unregistered Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_urp')

    
    
                    return true
                end
            }))
        end
    }

    ---------------SEALS-----------------
    SMODS.Seal{
        key = 'ps',
        loc_txt = {
            name = "Printer's Seal",
            text = {"When scored, adds a copy",
                    "of the card to hand",
                    "{C:inactive}(Removes the seal from",
                    '{C:inactive}the copied card)'
                
                },
                label = "Printer's Seal"
        },
        atlas = "enh",
        pos = {x = 2, y = 1},
        discovered = true,
        badge_colour = HEX('A020F0'),
        rarity = 3,
        sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },

        calculate = function(self,card,context)
            if context.main_scoring and context.cardarea == G.play then
                local card = copy_card(card, nil, nil, G.playing_card)
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card)
                card:set_seal()
                card:add_to_deck()
                G.hand:emplace(card)
                card.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_materialize()
                        return true
                    end
                })) 
                return {
                    message = "Printed!"
                }
                
            end
    end
}

----------------TAGS----------------
SMODS.Tag{
    key = 'pst',
    loc_txt = {
        name = 'Cartridge Tag',
        text = { "Next shop has a free", 
                 "{C:red}Printer Joker"}
    },
    atlas = 'tags',
    pos = { x = 0, y = 0},
    apply = function(self, tag, context)
        if context.type == "store_joker_create" then
            local prs_in_posession = { 0 }
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.rarity == "crv_p" and not prs_in_posession[v.config.center.key] then
                    prs_in_posession[1] = prs_in_posession[1] + 1
                    prs_in_posession[v.config.center.key] = true
                end
            end
            local card
            if #G.P_JOKER_RARITY_POOLS.crv_p > prs_in_posession[1] then
                card = create_card("Joker", context.area, nil, 'crv_p', nil, nil, nil, "crv_pst")
                create_shop_card_ui(card, "Joker", context.area)
                card.states.visible = false
                tag:yep("+", G.C.RARITY.crv_p, function()
                    card:start_materialize()
                    card.ability.couponed = true
                    card:set_cost()
                    return true
                end)
            else
                tag:nope()
            end
            tag.triggered = true
            return card
        end
    end,

}




    ---WIP---

    








           
           

    

    




    


    

    

   ---VAULT STUFF---

 
   SMODS.Consumable{
    key = 'VaultKey', 
    set = 'Spectral', 
    discovered = true,
    atlas = 'spec',
    soul_set = 'Spectral',
    soul_rate = 0.03,
    can_repeat_soul = false,
    pos = {x = 1 , y = 0}, 
    soul_pos = {x = 2 , y = 0}, 
    loc_txt = {
        name = 'Vault Key', 
        text = { 
            'Allows for {C:purple}Vaulted Jokers{} to',
            'appear in the shop',
        }
    },
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
      end,
    can_use = function(self,card)
                return true
    end,
    use = function(self,card,area,copier)
        if not (G.GAME.consumable_uses >= 1) then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            attention_text({
                text = 'Opened Vault!', 
                scale = 1.3, 
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.DARK_EDITION,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
        return true end }))

        G.GAME.consumable_uses = G.GAME.consumable_uses + 1
                else 
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        attention_text({
                            text = 'Already Open!',
                            scale = 1.3, 
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.DARK_EDITION,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                            offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                            silent = true
                            })
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                            play_sound('tarot2', 0.76, 0.4);return true end}))
                            play_sound('tarot2', 1, 0.4)
                            card:juice_up(0.3, 0.5)
                    return true end }))
    end
    delay(0.6)
end,
    in_pool = function(self,wawa,wawa2)
        if G.GAME.consumable_uses < 1 then
        return true
        elseif G.GAME.consumable_uses >= 1 then
            return false
        end
    end,
    
}

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.consumable_uses = 0
    return ret
end

SMODS.Joker{
    key = 'vjim', 
         loc_txt = { 
         name = 'Vaulted Jimbo',
          text = {
             '{X:mult,C:white}X#1#{} Mult but has a',
             '{C:green}#3# in #2#{} Chance to',
             '{X:mult,C:white}X(-#1#){}',
             '{C:red}Less discards, {C:attention}better chances'
             },
                  
         },
         atlas = 'Jokers2', 
        rarity = 'crv_va', 
        cost = 5, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
         eternal_compat = true, 
         perishable_compat = false, 
         pos = {x = 3, y = 3},
         config = { 
           extra = { odds = 4, xmult = 6, discards = 'N/A'
  
           }
         },
         loc_vars = function(self, info_queue, card)
             return { vars = { card.ability.extra.xmult, card.ability.extra.odds,card.ability.extra.discards } }
           end, 
  
         calculate = function(self,card,context)
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
         in_pool = function(self,wawa,wawa2)
            if G.GAME.consumable_uses < 1 then
            return false
            elseif G.GAME.consumable_uses >= 1 then
                return true
            end
        end,
           }


            local multi = {-100, -99, -98, -97, -96, -95, -94, -93, -92, -91, -90, -89, -88, 
            -87, -86, -85, -84, -83, -82, -81, -80, -79, -78, -77, -76, -75, -74, -73, -72, 
            -71, -70, -69, -68, -67, -66, -65, -64, -63, -62, -61, -60, -59, -58, -57, -56, 
            -55, -54, -53, -52, -51, -50, -49, -48, -47, -46, -45, -44, -43, -42, -41, -40, 
            -39, -38, -37, -36, -35, -34, -33, -32, -31, -30, -29, -28, -27, -26, -25, -24, 
            -23, -22, -21, -20, -19, -18, -17, -16, -15, -14, -13, -12, -11, -10, -9, -8, -7,
            -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
            17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 
            37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 
            57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 
            77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 
            97, 98, 99, 100}

           SMODS.Joker{
            key = 'vsix', 
                 loc_txt = { 
                 name = 'Oops! Vaulted!',
                  text = {
                     'Multiplies all {C:attention}listed',
                     '{C:green}probabilities{} by a random number',
                     'between {C:green}-100 and 100',
                     '{C:inactive}(Multiply by {C:green}#1#{C:inactive})',
                     },
                          
                 },
                 atlas = 'Jokers2', 
                rarity = 'crv_va', 
                cost = 5, 
                unlocked = true, 
                discovered = false, 
                blueprint_compat = false,
                 eternal_compat = true, 
                 perishable_compat = false, 
                 pos = {x = 4, y = 3},
                 config = { 
                   extra = { multip2 = 'N/A'
          
                   }
                 },
                 loc_vars = function(self, info_queue, card)
                     return { vars = {card.ability.extra.multip2 } }
                   end, 
          
                   add_to_deck = function(self,card,from_debuff)
                    local random2_key = (pseudorandom_element(multi, pseudoseed("vsix")))
                    card.ability.extra.multip2 = random2_key
                    for k, v in pairs(G.GAME.probabilities) do 
                        G.GAME.probabilities[k] = v*card.ability.extra.multip2
                    end
                    end,
                    remove_from_deck = function(self,card,from_debuff)
                        for k, v in pairs(G.GAME.probabilities) do 
                        G.GAME.probabilities[k] = v/card.ability.extra.multip2
                    end
                end,
                    in_pool = function(self,wawa,wawa2)
                        if G.GAME.consumable_uses < 1 then
                        return false
                        elseif G.GAME.consumable_uses >= 1 then
                            return true
                        end
                end
                   }

local vdnaenh = {
 G.P_CENTERS.m_bonus,
G.P_CENTERS.m_mult,
G.P_CENTERS.m_wild,
G.P_CENTERS.m_glass,
G.P_CENTERS.m_steel,
G.P_CENTERS.m_stone,
G.P_CENTERS.m_gold,
G.P_CENTERS.m_lucky
                }
                
SMODS.Joker{
    key = 'vdna',
    loc_txt = {
        name = 'Genetic Mutation',
        text = {"If {C:attention}first hand{} of round",
                "has only {C:attention}1{} card, add a",
                "permanent {C:purple}enhanced{} copy to deck",
                "and draw it to {C:attention}hand",
                '{C:inactive}(Only vanilla enhancements)'
                },
    },
    atlas = 'Jokers2',
    pos = { x = 4, y = 4 },
    rarity = 'crv_va',
    cost = 5, 
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    config  = { extra = {} },
    calculate = function(self,card,context)

        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 end
            juice_card_until(card, eval, true)
        end

        if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_played == 0 then
            if #context.full_hand == 1 then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            _card:add_to_deck()
            if context.full_hand[1].ability.effect == "Base" then
            _card:set_ability(pseudorandom_element(vdnaenh, pseudoseed("vdna")))
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
in_pool = function(self,wawa,wawa2)
    if G.GAME.consumable_uses < 1 then
    return false
    elseif G.GAME.consumable_uses >= 1 then
        return true
    end
end
            }


            SMODS.Joker{
                key = 'vface', 
                loc_txt = { 
                    name = 'Vaulted Face',
                    text = {
                        "Played {C:attention}face{} cards",
                        "give {C:mult}+#1#{} Mult and",
                        "Played {C:attention}number{} cards",
                        "give {C:mult}#2#{} Mult",
                        "when scored.",
                        "If 15 {C:inactive}(#4#){} face cards are played",
                        "consecutively, {X:mult,C:white}X(#3#){} Mult.",
        
                        
                    },
                    
                },
                atlas = 'Jokers2', 
                rarity = 'crv_va', 
                cost = 10, 
                unlocked = true, 
                discovered = false, 
                blueprint_compat = false,
                eternal_compat = true, 
                perishable_compat = false, 
                pos = {x = 0, y = 5},
                config = { 
                  extra = { pmult = 20, mmult = -15,mxmult = -2,timer = 0
            
                  }
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.pmult,card.ability.extra.mmult,card.ability.extra.mxmult,card.ability.extra.timer} }
                  end,
            
                calculate = function(self,card,context)
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
                                mult = card.ability.extra.pmult,
                            }
                        end
                    end
                    
                        if context.individual and context.cardarea == G.play and (card.ability.extra.timer < 15)  then
                            if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 10 then
                            card.ability.extra.timer = 0
                            return {
                                mult = card.ability.extra.mmult,
                            }
                        end
                    end
                end,
                in_pool = function(self,wawa,wawa2)
                    return true
                end,
               }

          

           SMODS.Joker {
            key = 'hteg',
            loc_txt = {
              name = 'Jhorah, Egg Form',
              text = {
                "The Egg Form of {C:dark_edition}Jhorah, Chained Beast{}",
                "does nothing.. yet.",
                "Grows after every {C:attention}3{} rounds",
                "{C:inactive}(#1#/3 Rounds)"
        
              }
            },
            config = { extra = {
            stages = 0} },
    
            rarity = 'crv_va',
            atlas = 'mm',
            blueprint_compat = true,
            discovered = false,
            pos = {x = 0, y = 0},
            cost = 7,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.stages} }
            end,
            calculate = function(self, card, context)
                if context.end_of_round and not context.repetition and not context.blueprint and not context.individual and not (#SMODS.find_card('j_crv_jhv') >= 1 ) then
                    card.ability.extra.stages = card.ability.extra.stages + 1
                end
                if context.setting_blind and card.ability.extra.stages >= 3 and not context.blueprint and not context.repetition then
                        G.E_MANAGER:add_event(Event({
                          trigger = 'after',
                          delay = 0.3,
                          blockable = false,
                          func = function()
                            G.jokers:remove_card(card)
                            card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                            card = nil
                            return true;
                          end
                        }))
                        local new_card = create_card('Jhorah,Hatchling', G.jokers, nil, nil, nil, nil, 'j_crv_jhv')
                         new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                      end
    
                if context.joker_main and not context.blueprint then
            return {
             message = '!'
                }   
                end
            end,
      
                  in_pool = function(self, wawa, wawa2)
                    return false
                end
          }
    
          SMODS.Joker {
            key = 'jhv',
            loc_txt = {
              name = 'Jhorah, Hatchling Form',
              text = {
                "The Hatchling Form of {C:dark_edition}Jhorah, Chained Beast{}",
                "{C:chips}+#2#{} Chips",
                "Grows after every {C:attention}3{} rounds",
                "{C:inactive}(#1#/3 Rounds)",
        
              }
            },
            config = { extra = {
            stages = 0,stg1b = 30} },
    
            rarity = 'crv_va',
            atlas = 'mm',
            no_collection = true,
            blueprint_compat = true,
            discovered = false,
            pos = {x = 1, y = 0},
            cost = 7,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.stages,card.ability.extra.stg1b} }
            end,
            calculate = function(self, card, context)
                if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
                    card.ability.extra.stages = card.ability.extra.stages + 1
                end
                if context.setting_blind and card.ability.extra.stages >= 3 and not context.repetition and not context.blueprint and not context.individual and not (#SMODS.find_card('j_crv_jbe') >= 1 ) then
                        G.E_MANAGER:add_event(Event({
                          trigger = 'after',
                          delay = 0.3,
                          blockable = false,
                          func = function()
                            G.jokers:remove_card(card)
                            card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                            card = nil
                            return true;
                          end
                        }))
                        local new_card = create_card('Jhorah,Beasty', G.jokers, nil, nil, nil, nil, 'j_crv_jbe')
                         new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                      end
    
                if context.joker_main then
            return {
             chips = card.ability.extra.stg1b
                }   
                end
            end,
      
                  in_pool = function(self, wawa, wawa2)
                    return false
                end
          }
    
          SMODS.Joker {
            key = 'jbe',
            loc_txt = {
              name = 'Jhorah, Beasty Form',
              text = {
                "The Beasty Form of {C:dark_edition}Jhorah, Chained Beast{}",
                "{C:chips}+#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
                "Grows after every {C:attention}3{} rounds",
                "{C:inactive}(#1#/3 Rounds)",
        
              }
            },
            config = { extra = {
            stages = 0,stg2b = 60,stg2b2 = 1.5, } },
    
            rarity = 'crv_va',
            atlas = 'mm',
            blueprint_compat = true,
            discovered = false,
            no_collection = true,
            pos = {x = 2, y = 0},
            cost = 7,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.stages,card.ability.extra.stg2b,card.ability.extra.stg2b2} }
            end,
            calculate = function(self, card, context)
                if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
                    card.ability.extra.stages = card.ability.extra.stages + 1
                end
                if context.setting_blind and card.ability.extra.stages >= 3 and not context.repetition and not context.blueprint and not context.individual and not (#SMODS.find_card('j_crv_jma') >= 1 ) then
                        G.E_MANAGER:add_event(Event({
                          trigger = 'after',
                          delay = 0.3,
                          blockable = false,
                          func = function()
                            G.jokers:remove_card(card)
                            card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                            card = nil
                            return true;
                          end
                        }))
                        local new_card = create_card('Jhorah,Matured', G.jokers, nil, nil, nil, nil, 'j_crv_jma')
                         new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                      end
    
                if context.joker_main then
            return {
             chips = card.ability.extra.stg2b,
             x_mult = card.ability.extra.stg2b2
                }   
                end
            end,
      
                  in_pool = function(self, wawa, wawa2)
                    return false
                end
          }
          SMODS.Joker {
            key = 'jma',
            loc_txt = {
              name = 'Jhorah, Matured Form',
              text = {
                "The Matured Form of {C:dark_edition}Jhorah, Chained Beast{}",
                "{C:chips}+#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
                "Grows after every {C:attention}3{} rounds",
                "{C:inactive}(#1#/3 Rounds)",
        
              }
            },
            config = { extra = {
            stages = 0,stg3b = 90,stg3b2 = 2, } },
    
            rarity = 'crv_va',
            atlas = 'mm',
            blueprint_compat = true,
            discovered = false,
            no_collection = true,
            pos = {x = 3, y = 0},
            cost = 7,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.stages,card.ability.extra.stg3b,card.ability.extra.stg3b2} }
            end,
            calculate = function(self, card, context)
                if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
                    card.ability.extra.stages = card.ability.extra.stages + 1
                end
                if context.setting_blind and card.ability.extra.stages >= 3 and not context.repetition and not context.blueprint and not context.individual and not (#SMODS.find_card('j_crv_jad') >= 1 ) then
                        G.E_MANAGER:add_event(Event({
                          trigger = 'after',
                          delay = 0.3,
                          blockable = false,
                          func = function()
                            G.jokers:remove_card(card)
                            card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                            card = nil
                            return true;
                          end
                        }))
                        local new_card = create_card('Jhorah,Adult', G.jokers, nil, nil, nil, nil, 'j_crv_jad')
                         new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                      end
    
                if context.joker_main then
            return {
             chips = card.ability.extra.stg3b,
             x_mult = card.ability.extra.stg3b2
                }   
                end
            end,
      
                  in_pool = function(self, wawa, wawa2)
                    return false
                end
          }
    
          SMODS.Joker {
            key = 'jad',
            loc_txt = {
              name = 'Jhorah, Adult Form',
              text = {
                "The Adult Form of {C:dark_edition}Jhorah, Chained Beast{}",
                "{X:chips,C:white}X#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
                "Grows after every {C:attention}3{} rounds",
                "{C:inactive}(#1#/3 Rounds)",
        
              }
            },
            config = { extra = {
            stages = 0,stg4b = 2, stg4b2 = 2.5, } },
    
            rarity = 'crv_va',
            atlas = 'mm',
            blueprint_compat = true,
            discovered = false,
            no_collection = true,
            pos = {x = 4, y = 0},
            cost = 7,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.stages,card.ability.extra.stg4b,card.ability.extra.stg4b2} }
            end,
            calculate = function(self, card, context)
                if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
                    card.ability.extra.stages = card.ability.extra.stages + 1
                end
                if context.setting_blind and card.ability.extra.stages >= 3 and not context.repetition and not context.blueprint and not context.individual and not (#SMODS.find_card('j_crv_jcbt') >= 1 ) then
                        G.E_MANAGER:add_event(Event({
                          trigger = 'after',
                          delay = 0.3,
                          blockable = false,
                          func = function()
                            G.jokers:remove_card(card)
                            card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                            card = nil
                            return true;
                          end
                        }))
                        local new_card = create_card('Jhorah,Chained Beast', G.jokers, nil, nil, nil, nil, 'j_crv_jcbt')
                         new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                      end
    
                if context.joker_main then
            return {
             xchips = card.ability.extra.stg4b,
             x_mult = card.ability.extra.stg4b2
                }   
                end
            end,
      
                  in_pool = function(self, wawa, wawa2)
                    return false
                end
          }
    
          SMODS.Joker {
            key = 'jcbt',
            loc_txt = {
              name = '{C:dark_edition}Jhorah, Chained Beast',
              text = {
                "The Final Form {C:dark_edition}Jhorah, Chained Beast{}",
                "{X:chips,C:white}X#2#{} Chips and {X:mult,C:white}X#3#{} Mult",
                "{C:green}#4# in #5#{}chance to add a {C:attention}Random",
                "{C:attention} Enhancement{} to scored cards",
                "if they don't have one"
        
              }
            },
            config = { extra = {
        stg5b = 4, stg5b2 = 3,odds = 4 } },
    
            rarity = 'crv_va',
            atlas = 'mm',
            blueprint_compat = true,
            discovered = false,
            no_collection = true,
            pos = {x = 5, y = 0},
            cost = 7,
            loc_vars = function(self, info_queue, card)
              return { vars = {card.ability.extra.stages,card.ability.extra.stg5b,card.ability.extra.stg5b2,(G.GAME.probabilities.normal or 1),card.ability.extra.odds} }
            end,
            calculate = function(self, card, context)
    
                if pseudorandom('jcbt') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    if context.individual then
                        if context.cardarea == G.play then
                                   for k, v in ipairs(context.scoring_hand) do 
                                       if context.other_card.ability.effect == "Base" then
                                           context.other_card:set_ability(pseudorandom_element(ss, pseudoseed("spuzzypp")))
                                           G.E_MANAGER:add_event(Event({
                                               func = function()
                                                   return true
                                               end
                                           })) 
                                        end
                           end
                       end
                   end
               end
               if context.joker_main then
            return {
             xchips = card.ability.extra.stg5b,
             x_mult = card.ability.extra.stg5b2
                }   
                end
            end,
      
                  in_pool = function(self, wawa, wawa2)
                    return false
                end
          }
          
          

          



    
      
    



    --- chaos releated ---

    SMODS.Atlas{
        key = 'chaosa', 
        path = 'chaos.png', 
        px = 71, 
        py = 95 
    }

    SMODS.Atlas{
        key = 'printersoul', 
        path = 'Printer_Soul.png', 
        px = 71, 
        py = 105 
    }

    SMODS.Rarity{
        key = "chaos",
       badge_colour = G.C.DARK_EDITION,
       loc_txt = {
            name = 'Chaos',
        },
        pools = {}, 
    }

    local chaos_keys = {'j_crv_chaoticprintermachine','j_crv_thefaxprinter','j_crv_dirtinator9999','j_crv_holyprinter','j_crv_hfj'}

SMODS.Consumable{
    key = "chaoticsol", 
    set = 'Spectral',
    hidden = true,
    soul_set = 'Spectral',
        soul_rate = 0.003,
        can_repeat_soul = false,
    loc_txt = { 
        name = "Chaotic Soul",
        text = {
            'Creates a random',
            '{C:dark_edition}Chaos Joker',
        },
    },
    config = { extra = {  }},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
      end, 
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0},
    atlas = 'printersoul',
    cost = 3,
    unlocked = true,
    discovered = false,
    can_use = function(self,card)
        return true
        end,
    use = function(self,card)
            local random_key = chaos_keys[math.random(#chaos_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                delay(1.5)
    end
        }
   
    
            
    SMODS.Joker{
        key = 'chaoticprintermachine', 
        loc_txt = { 
            name = '{C:dark_edition}Chaotic Printer',
            text = {
              'When Blind is selected,',
              '{C:green}#1# in #2#{} chance to',
              'create all of the {C:attention}Printers',
              '{C:inactive}(Trust me, limiting this by luck',
              '{C:inactive}is needed.)'
            },
            
        },
        atlas = 'chaosa', 
        rarity = 'crv_chaos', 
        cost = 30, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 1},
        config = { 
          extra = { odds = 3
    
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self,card,context)
            
            if context.setting_blind and not context.blueprint and pseudorandom('chaoticprintermachine') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = create_card('Blueprinter', G.jokers, nil,nil,nil,nil,'j_crv_printer')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Rusty Printer', G.jokers, nil,nil,nil,nil,'j_crv_rustyprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Jimbo Printer', G.jokers, nil,nil,nil,nil,'j_crv_jimboprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Obelisk Printer', G.jokers, nil,nil,nil,nil,'j_crv_obeliskprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Money Printer', G.jokers, nil,nil,nil,nil,'j_crv_moneyprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Broken Printer', G.jokers, nil,nil,nil,nil,'j_crv_brokenprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Fax Printer', G.jokers, nil,nil,nil,nil,'j_crv_faxprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Spectral Printer', G.jokers, nil,nil,nil,nil,'j_crv_spectralprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Legendary Printer', G.jokers, nil,nil,nil,nil,'j_crv_legendaryprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Glass Printer', G.jokers, nil,nil,nil,nil,'j_crv_glassprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Camera', G.jokers, nil,nil,nil,nil,'j_crv_smile!')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Lethal Press Machine', G.jokers, nil,nil,nil,nil,'j_crv_lpm')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Devilish Printer', G.jokers, nil,nil,nil,nil,'j_crv_devilishprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Head', G.jokers, nil,nil,nil,nil,'j_crv_head')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Body', G.jokers, nil,nil,nil,nil,'j_crv_body')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Back', G.jokers, nil,nil,nil,nil,'j_crv_back')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Steel Printer', G.jokers, nil,nil,nil,nil,'j_crv_steelprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Advanced Printer', G.jokers, nil,nil,nil,nil,'j_crv_tierp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Lucky Printer', G.jokers, nil,nil,nil,nil,'j_crv_luckyprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Celestial Printer', G.jokers, nil,nil,nil,nil,'j_crv_celestialprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Polychrome Printer', G.jokers, nil,nil,nil,nil,'j_crv_pcp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Foil Printer', G.jokers, nil,nil,nil,nil,'j_crv_fcp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Holographic Printer', G.jokers, nil,nil,nil,nil,'j_crv_hcp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Negative Printer', G.jokers, nil,nil,nil,nil,'j_crv_ncp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Unregistered Printer', G.jokers, nil,nil,nil,nil,'j_crv_urp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }

       SMODS.Joker {
        key = 'thefaxprinter',
        loc_txt = {
          name = '{C:money}THE Fax Printer',
          text = {
            'When blind is selected,',
            "prints a{C:attention} Promotion",
          }
        },
        config = { extra = {  } },
        discovered = false,
        unlocked = true,
        rarity = "crv_chaos",
        atlas = 'chaosa',
        blueprint_compat = true,
        pos = { x = 1, y = 0 },
        cost = 30,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)
          return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
        end,
        calculate = function(self, card, context)
          if context.setting_blind then
                local new_card = create_card('Promotion', G.jokers, nil,nil,nil,nil,'j_crv_promotion')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end,
        in_pool = function(self, wawa, wawa2)
           
            return false
        end

    }
    
    SMODS.Joker {
        key = 'promotion',
        loc_txt = {
          name = '{C:money}Promotion',
          text = {
            "All {C:attention}Royal Cards {}and {C:attention}Aces",
            "give {C:chips}+#1#{} Chips and",
            "{X:mult,C:white}X#2#{} Mult when scored",
          }
        },
        config = { extra = { chips = 36286368, xmult = 4153211351420 } },
        rarity = 'crv_chaos',
        atlas = 'chaosa',
        blueprint_compat = true,
        discovered = false,
        pos = { x = 0, y = 0 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.chips, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() >= 11 and context.other_card:get_id() <= 14 then
              return {
                chips = card.ability.extra.chips,
                x_mult = card.ability.extra.xmult,
                card = card.other_card
              }
            end
        end
    end,

              in_pool = function(self, wawa, wawa2)
                return false
            end
      }

      SMODS.Joker{
        key = 'dirtinator9999', 
        loc_txt = { 
            name = '{C:green}Dirtinator9999',
            text = {
                'Prints a{C:green} Dirt Contract{}',
                'When blind is selected,',
              }
        },
        atlas = 'chaosa', 
        rarity = 'crv_chaos', 
        cost = 30, 
        unlocked = true, 
        discovered = false, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 0},
        config = { extra = {  }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                    local new_card = create_card('Dirt Document', G.consumeables, nil,nil,nil,nil,'c_crv_dirtdocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end
    }

    SMODS.Consumable{
        key = 'dirtdocument', --key
        set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
        atlas = 'chaosa', --atlas
        pos = {x = 2, y = 1}, --position in atlas
        discovered = true,
        loc_txt = {
            name = '{C:green}Dirt Contract', --name of card
            text = { --text of card
                'Turns #1# cards into {C:green}Dirt'
            }
        },
        config = {
            extra = {
                cards = 10,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards, }}
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                    return true
                end
            end
            return false
        end,
        use = function(self,card,area,copier)
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_crv_dirt"])
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                end
         end
    }

    SMODS.Enhancement{
        key = "dirt",
        atlas = 'chaosa',
        pos = {x = 1, y = 1},
        discovered = true,
        unlocked = true,
        loc_txt = { 
            name = 'DIRT',
            text = {
                '{C:green}Contains the power of Mother Nature'
            }},
        replace_base_card = true,
        no_rank = true,
        no_suit = true,
        overrides_base_rank = true,
        any_suit = false,
        always_scores = true,
        weight = 0,
        config = {extra = {x_mult = 99999999,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.x_mult} }
          end,
          calculate = function(self, card, context, effect)
            if context.main_scoring and context.cardarea == G.hand or context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.x_mult 
                }
            end
          end,
          in_pool = function(self,wawa,wawa2)
            return false
        end,
        }

        SMODS.Joker{
            key = 'holyprinter', 
            loc_txt = { 
                name = '{C:green}Holy Printer',
                text = {
                  'When Blind is selected',
                  'prints a {C:green}Holy Banana',
                },
                
            },
            atlas = 'chaosa', 
            rarity = 'crv_chaos', 
            cost = 30, 
            unlocked = true, 
            discovered = false, 
            blueprint_compat = false,
            eternal_compat = true, 
            perishable_compat = false, 
            pos = {x = 0, y = 2},
            config = { 
              extra = { 
        
              }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = {  } }
              end, 
            calculate = function(self,card,context)
                
                if context.setting_blind then
                    local new_card = create_card('Blueprinter', G.jokers, nil,nil,nil,nil,'j_crv_holybanana')
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
                end
            end,
            in_pool = function(self,wawa,wawa2)
                return false
            end,
           }

           SMODS.Joker{
            key = 'hfj', 
            loc_txt = { 
                name = '{C:green}Hacked File',
                text = {
                  'Saves the {C:green}4{} times the ammount of your first',
                  'scored chips and returns it as {X:mult,C:white}XMult{}.',
                  "{C:red}resets{} at the end of a round",
                  "{C:inactive}({C:attention}#1# {C:inactive}Stored)",
                },
                
            },
            atlas = 'Jokers2', 
            rarity = 'crv_chaos', 
            cost = 6, 
            unlocked = true, 
            discovered = false, 
            blueprint_compat = true,
            eternal_compat = true, 
            perishable_compat = true, 
            pos = {x = 5,y = 4},
            config = { 
              extra = { one = 0,chips = 0,ok = 0},
              
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.one,card.ability.extra.chips,card.ability.extra.ok} }
              end, 
        
        
            calculate = function(self,card,context)
        
             if context.joker_main and next(SMODS.find_mod("Talisman")) and card.ability.extra.one == 0 and not context.blueprint and not context.repetition then
                card.ability.extra.ok = card.ability.extra.ok +1
                local chips = hand_chips
                card.ability.extra.chips = chips
                card.ability.extra.one = to_number(card.ability.extra.chips*4)
                return{
                    message = 'ERROR!'
                }
             elseif context.joker_main and card.ability.extra.one == 0 and card.ability.extra.one == 0 and not context.blueprint and not context.repetition then
                card.ability.extra.ok = card.ability.extra.ok + 1
                local chips = hand_chips
                card.ability.extra.chips = chips
                card.ability.extra.one = card.ability.extra.chips*4
                return{
                    message = 'ERROR!'
                }
            end
            if context.joker_main and next(SMODS.find_mod("Talisman")) and card.ability.extra.ok > 0 then
                return {
                    x_mult = to_number(card.ability.extra.one)
                }
            elseif context.joker_main and card.ability.extra.ok > 0 then
                return {
                    x_mult = card.ability.extra.one
                }
            end
            if context.end_of_round and not context.repetition and not context.blueprint and not context.individual then
                card.ability.extra.ok = 0
                card.ability.extra.one = 0
                return{
                    message = 'Cleaning file...',
                }
            end
        end,
                             in_pool = function(self, wawa, wawa2)
                               return false
                           end
                     }
        


           ---the vault--- (things that are mostly working but not sure if i should add them or not)

   --[[        
    SMODS.Blind{
        key = 'wip',
        loc_txt = {
            name = 'WIP',
       },
        discovered = true,
        dollars = 5,
        mult = 9999999999999999^9,
        boss = {min = 1, max = 10},
        recalc_debuff = function(self,card,from_blind)  
            return true
         end,
        set_blind = function(self)
            if not (#SMODS.find_card('j_crv_st1') >= 1 ) then
                local newcard = create_card('Stage 1 Boss', G.jokers, nil, nil, nil, nil, 'j_crv_st1')
            newcard:add_to_deck()
                SMODS.Stickers["eternal"]:apply(newcard, true)
                G.jokers:emplace(newcard)
            G.E_MANAGER:add_event(Event({
                func = function()
                 local card2 = pseudorandom_element(G.playing_cards, pseudoseed('wip'))
                 local card3 = pseudorandom_element(G.playing_cards, pseudoseed('wip'))
                 local card4 = pseudorandom_element(G.playing_cards, pseudoseed('wip'))
                 local card5 = pseudorandom_element(G.playing_cards, pseudoseed('wip'))
                 local card6 = pseudorandom_element(G.playing_cards, pseudoseed('wip'))

                 card2:set_ability(G.P_CENTERS["m_crv_weapon"]) 
                 card3:set_ability(G.P_CENTERS["m_crv_weapon"])
                 card4:set_ability(G.P_CENTERS["m_crv_weapon"])
                   card5:set_ability(G.P_CENTERS["m_crv_weapon"])
                   card6:set_ability(G.P_CENTERS["m_crv_weapon"])
                   return true
                  end
                }))
          end
      end,
          drawn_to_hand = function(self)
              for k, v in pairs(G.playing_cards) do
                  if v.config.center == G.P_CENTERS.m_crv_weapon then
                      v:set_debuff(false)
                  end
              end
               for k, v in pairs(G.jokers.cards) do
              if v.config.center == G.P_CENTERS.j_crv_st1 then
                  v:set_debuff(false)
              end
          end
          end
      
          
      }
  
      SMODS.Enhancement{
          key = "weapon",
          atlas = 'wip',
          pos = {x = 0, y = 0},
          discovered = true,
          unlocked = true,
          loc_txt = { 
              name = 'Weapon',
              text = {
                  'Attack!'
              }},
          replace_base_card = true,
          no_rank = true,
          no_suit = true,
       overrides_base_rank = true,
          any_suit = false,
          always_scores = false,
          weight = 0,
          config = {extra = {}
          },
          loc_vars = function(self, info_queue, card)
              return { vars = {} }
            end
      }
  

      SMODS.Joker{
          key = 'st1', 
          loc_txt = { 
              name = 'Stage 1',
              text = {
                'Defeat this boss this boss to be able to',
                'pass the blind',
                '#1# HP Remaining',
                'Use "Attack" to deal damage',
                'Every "Attack" gives +1 Discard'
              },
   },
          atlas = 'wip', 
          rarity = 1, 
          cost = 1, 
          unlocked = true, 
          discovered = false, 
          blueprint_compat = false,
          eternal_compat = true, 
  --        perishable_compat = false, 
  --        pos = {x = 0, y = 0},
  --        config = { 
  --          extra = { hp = 3, hand = -1, abjj = 0, discard = -1
  --          }
  --        },
  --        loc_vars = function(self, info_queue, card)
  --            return { vars = { card.ability.extra.hp, } }
  --          end,
  --        calculate = function(self, card, context)
  --           if context.destroying_card and not context.blueprint then
  --                   for k, v in ipairs(context.scoring_hand) do
  --               if v.config.center == G.P_CENTERS.m_crv_weapon and not (card.ability.extra.hp == 0) and not context.blueprint then
  --                   card.ability.extra.hp = card.ability.extra.hp - 1
  --                       return {
  --                           message = 'Hit!',
  --                           ease_discard(1)
  --                       }
  --                   end
  --               end
  --            end
  --   if (card.ability.extra.hp == 0) and not context.blueprint and not context.repetition and not context.individual then
  --    if not context.blueprint and not context.repetition and not context.individual and (card.ability.extra.abjj == 0) then
  --        card.ability.extra.abjj = card.ability.extra.abjj + 1
  --    local cardab = create_card('Absolute Joker', G.jokers, nil, nil, nil, nil, 'j_crv_abj')
  --    cardab:add_to_deck()
--  G.jokers:emplace(cardab)
  --       G.E_MANAGER:add_event(Event({
  --           func = function()
  --             play_sound('tarot1')
  --             card.T.r = -0.2
  --             card:juice_up(0.3, 0.4)
  --             card.states.drag.is = true
  --             card.children.center.pinch.x = true
  --             G.E_MANAGER:add_event(Event({
  --               trigger = 'after',
  --               delay = 0.3,
  --               blockable = false,
  --               func = function()
  --                 G.jokers:remove_card(card)
  --                 card:remove()
  --                 card = nil
  --                 return true;
  --               end
  --             }))
  --             return true
  --           end              
  --  --       }))
--  end
--  end
--  if context.destroying_card and not context.blueprint and not context.repetition then
--      for k, v in ipairs(G.playing_cards) do
--          if v.config.center == G.P_CENTERS.m_crv_weakness and not (card.ability.extra.hp == 0) and not context.blueprint then
--          return {
--              message = 'Safe!',
--          }
--      end
--  end
--      end
--  end
--  
--       }
--  
--       SMODS.Joker{
--          key = 'abj', 
--          loc_txt = { 
--              name = 'Absolute Joker',
--              text = {
--                'Allows you to score {X:mult,C:white}Xinf{} Mult',
--                'for 6 hands',
--                '{C:inactive}(#2#/6 Hands )'
--              },
--              
--          },
--          atlas = 'wip', 
--          rarity = 1, 
--          cost = 1, 
--          unlocked = true, 
--          discovered = false, 
--          blueprint_compat = false,
--          eternal_compat = true, 
--          perishable_compat = false, 
--          pos = {x = 0, y = 0},
--          config = { 
--            extra = { inf = 99999999999999999999999999999^99999999999999999999999999999, timer = 0
--            }
--          },
--          loc_vars = function(self, info_queue, card)
--              return { vars = { card.ability.extra.inf,card.ability.extra.timer } }
--            end,
--          calculate = function(self, card, context)
--   if context.joker_main and not context.blueprint and not context.individual and not context.repetition and not (card.ability.extra.timer >= 6) then
--  --  card.ability.extra.timer = card.ability.extra.timer + 1
--  --  return {
--          x_mult = card.ability.extra.inf,
--      }
--   end
--  if (card.ability.extra.timer >= 6) and not context.blueprint and not context.repetition and not context.individual then
--      G.E_MANAGER:add_event(Event({
 --         func = function()
 --           play_sound('tarot1')
 --           card.T.r = -0.2
 --           card:juice_up(0.3, 0.4)
 --           card.states.drag.is = true
 --           card.children.center.pinch.x = true
  --          G.E_MANAGER:add_event(Event({
  --            trigger = 'after',
 --             delay = 0.3,
   --           blockable = false,
  --            func = function()
  --              G.jokers:remove_card(card)
  --  --              card:remove()
   --             card = nil
   --             return true;
   --           end
   --         }))
   --         return true
   --       end
  --      }))
  end
 end
       }
    ]]--

--[[

remove_from_deck = function(self, card, from_debuff)
        G.STATE = G.STATES.GAME_OVER
        G.STATE_COMPLETE = false
    end
    
    ]]