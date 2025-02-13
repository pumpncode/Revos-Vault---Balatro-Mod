
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