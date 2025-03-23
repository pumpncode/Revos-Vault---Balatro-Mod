

SMODS.Booster{
    key = 'pbst',
    atlas = 'booster',
    pos= {x=0,y=0},
    config = {extra = 2,choose = 1},
    group_key = 'k_crv_pbstg',
    cost = 4,
    weight = 0.03,
    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Joker",
            rarity = "crv_p"
        })
    end,
}


SMODS.Booster{
    key = 'cbst',
    atlas = 'booster',
    loc_txt = {
        name = "Cont",
        text = {"Cont"}
    },
    pos= {x=0,y=1},
    config = {extra = 2,choose = 1},
    group_key = 'k_crv_cbstg',
    cost = 4,
    draw_hand = true,
    weight = 0.8,
    kind = "Contract",
    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "EnchancedDocuments",
            skip_materialize = true
        })
    end,
}

SMODS.Booster{
    key = 'cbst2',
    atlas = 'booster',
    loc_txt = {
        name = "Cont",
        text = {"Cont"}
    },
    pos= {x=1,y=1},
    config = {extra = 4,choose = 1},
    group_key = 'k_crv_cbstg',
    cost = 6,
    draw_hand = true,
    weight = 0.4,
    kind = "Contract",
    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "EnchancedDocuments",
            skip_materialize = true
        })
    end,
}

SMODS.Booster{
    key = 'cbst3',
    atlas = 'booster',
    loc_txt = {
        name = "Cont",
        text = {"Cont"}
    },
    pos= {x=2,y=1},
    config = {extra = 4,choose = 2},
    group_key = 'k_crv_cbstg',
    cost = 8,
    draw_hand = true,
    weight = 0.4,
    kind = "Contract",
    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "EnchancedDocuments",
            skip_materialize = true
        })
    end,
}