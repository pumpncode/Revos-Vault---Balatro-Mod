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
          