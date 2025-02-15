
SMODS.Tag{
    key = 'pst',

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