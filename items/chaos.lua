    

SMODS.Rarity{
  key = "chaos",
 badge_colour = G.C.DARK_EDITION,
  pools = {}, 
}

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
  py = 95
}



local chaos_keys = {'j_crv_chaoticprintermachine','j_crv_thefaxprinter','j_crv_dirtinator9999','j_crv_holyprinter','j_crv_hfj'}

SMODS.Consumable{
    key = "chaoticsol", 
    set = 'Spectral',
    hidden = true,
    soul_set = 'Spectral',
        soul_rate = 0.03,
        can_repeat_soul = false,
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
                local new_card = create_card('Camera', G.jokers, nil,nil,nil,nil,'j_crv_smile')
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
          info_queue[#info_queue+1] = G.P_CENTERS.j_crv_promotion
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
            info_queue[#info_queue+1] = G.P_CENTERS.c_crv_dirtdocument
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
            atlas = 'chaosa', 
            rarity = 'crv_chaos', 
            cost = 30, 
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
            loc_vars = function(self, info_queue, card)
              info_queue[#info_queue+1] = G.P_CENTERS.j_crv_holybanana
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
                    message = localize('k_crv_error')
                }
             elseif context.joker_main and card.ability.extra.one == 0 and card.ability.extra.one == 0 and not context.blueprint and not context.repetition then
                card.ability.extra.ok = card.ability.extra.ok + 1
                local chips = hand_chips
                card.ability.extra.chips = chips
                card.ability.extra.one = card.ability.extra.chips*4
                return{
                    message = localize('k_crv_error')
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
                    message = localize('k_crv_cleaning')
                }
            end
        end,
                             in_pool = function(self, wawa, wawa2)
                               return false
                           end
                     }
        
