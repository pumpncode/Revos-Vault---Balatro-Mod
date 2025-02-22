
local printer_keys = {'j_crv_printer','j_crv_rustyprinter','j_crv_jimboprinter','j_crv_grossprinter','j_crv_obeliskprinter','j_crv_moneyprinter','j_crv_brokenprinter','j_crv_faxprinter','j_crv_spectralprinter',
'j_crv_glassprinter','j_crv_lpm','j_crv_devilishprinter','j_crv_steelprinter','j_crv_tierp','j_crv_luckyprinter','j_crv_celestialprinter','j_crv_fcp','j_crv_pcp','j_crv_hcp','j_crv_ngp','j_crv_urp'}

SMODS.Consumable{
    key = 'inkintuition', 
    set = 'Tarot',
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
        if pseudorandom('inkintuition') < G.GAME.probabilities.normal / card.ability.extra.odds then   
            SMODS.add_card({set = "Joker",area = G.jokers,rarity = 'crv_p'})
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
            key = 'dreamsdesires', 
            set = 'Tarot',
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
                    local random_key = (pseudorandom_element(machine_keys, pseudoseed("dreamsdesires")))
                        local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                delay(1.5)
            end
                }


SMODS.ConsumableType{
    key = 'scrap', 
    collection_rows = {4,5}, 
    primary_colour = G.C.RED,
    secondary_colour = G.C.RED ,
}

SMODS.UndiscoveredSprite{
    key = 'scrap',
    atlas = 'documents2.png',
    pos = {x = 0, y = 0}
}


SMODS.Consumable{
    in_pool = function(self,wawa,wawa2)
            return false
    end,
    key = 'horn', 
    discovered = true,
    unlocked = true,
    set = 'scrap', 
    atlas = 'scrapss', 
    cost = 0,
    pos = {x = 2, y = 0}, 
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
            return false
    end,
        key = 'pickles', 
        discovered = true,
        unlocked = true,
        set = 'scrap', 
        atlas = 'scrapss', 
        cost = 0,
        pos = {x = 0, y = 0}, 
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
                    return false
            end,
            key = 'mp', 
            discovered = true,
            unlocked = true,
            set = 'scrap', 
            atlas = 'scrapss', 
            cost = 0,
            pos = {x = 1, y = 0}, 
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
        return false
end,
    key = 'ap',
    discovered = true,
    unlocked = true,
    set = 'scrap', 
    atlas = 'scrapss', 
    cost = 0,
    pos = {x = 3, y = 0}, 
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
        return false
end,
    key = 'dc', 
    discovered = true,
    unlocked = true,
    set = 'scrap', 
    atlas = 'scrapss', 
    cost = 0,
    pos = {x = 4, y = 0}, 
    can_use = function(self,card)
                return true
            end,
    use = function()
        return {
            ease_dollars(15),
        }
    end


}


        SMODS.ConsumableType{
            key = 'EnchancedDocuments',
        
            collection_rows = {4,5}, 
            primary_colour = G.C.WHITE, 
            secondary_colour = G.C.BLACK, 
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
            key = 'steeldocument', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 'documents', 
            pos = {x = 3, y = 0}, 
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
            key = 'devilscontract', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 'documents',
            pos = {x = 1, y = 0}, 
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
            key = 'megadoc', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 'megaenh',
            pos = {x = 1, y = 0}, 
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
            key = 't1doc', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 't', 
            pos = {x = 0, y = 1}, 
            config = {extra ={ cards = 1}},
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
            key = 't2doc', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 't', 
            pos = {x = 1, y = 1},
            config = {extra ={ cards = 2}},
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
            key = 'boostdoc', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 't', 
            pos = {x = 3, y = 1},
            config = {extra = { cards = 1}}, 
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
            key = 'luckydocument', 
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 'documents',
            pos = {x = 2, y = 0}, 
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
            key = 'polydoc',
            set = 'EnchancedDocuments', 
            discovered = true,
            atlas = 'documents',
            pos = {x = 2, y = 1}, 
            config = {
                extra = {
                    cards = 1,}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards and #G.jokers.highlighted == 0 then
                        return true
                    elseif #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= card.ability.extra.cards and #G.hand.highlighted == 0 then
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
                    for i, card in pairs(G.jokers.highlighted) do
                        card:set_edition({polychrome = true}, true)
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                        delay(0.5)
                    end
                end
     }
    
     SMODS.Consumable{
        key = 'foildoc', 
        set = 'EnchancedDocuments',
        discovered = true,
        atlas = 'documents', 
        pos = {x = 0, y = 1}, 
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards and #G.jokers.highlighted == 0 then
                    return true
                elseif #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= card.ability.extra.cards and #G.hand.highlighted == 0 then
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
                for i, card in pairs(G.jokers.highlighted) do
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
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards and #G.jokers.highlighted == 0 then
                    return true
                elseif #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= card.ability.extra.cards and #G.hand.highlighted == 0 then
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
                for i, card in pairs(G.jokers.highlighted) do
                    card:set_edition({holo = true}, true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
            end
    }
    
    SMODS.Consumable{
        key = 'negdoc', 
        set = 'EnchancedDocuments', 
        discovered = true,
        atlas = 'documents', 
        pos = {x = 3, y = 1}, 
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards and #G.jokers.highlighted == 0 then
                    return true
                elseif #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= card.ability.extra.cards and #G.hand.highlighted == 0 then
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
                for i, card in pairs(G.jokers.highlighted) do
                    card:set_edition({negative = true}, true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
            end
    }

    SMODS.Consumable{
        key = 'uedoc', 
        set = 'EnchancedDocuments', 
        discovered = true,
        atlas = 'documents', 
        pos = {x = 0, y = 2}, 
        config = {
            extra = {
                cards = 1,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards} }
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards and #G.jokers.highlighted == 0 then
                    return true
                elseif #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= card.ability.extra.cards and #G.hand.highlighted == 0 then
                    return true
                end
            end
            return false
        end,
        use = function(self,card,area,copier)
                for i, card in pairs(G.hand.highlighted) do
                    card:set_edition(poll_edition(pseudorandom('uedoc'), nil, true, true,{{name = 'e_foil', weight = 1}, {name = 'e_holo', weight = 1},{name = 'e_polychrome', weight = 1}}))
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
                for i, card in pairs(G.jokers.highlighted) do
                    card:set_edition(poll_edition(pseudorandom('uedoc'), nil, true, true,{{name = 'e_foil', weight = 1}, {name = 'e_holo', weight = 1},{name = 'e_polychrome', weight = 1}}))
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                    delay(0.5)
                end
            end
    }

    
        
    