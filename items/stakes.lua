SMODS.Stake{
    key = "blood",
    atlas = "stakes",
    colour = HEX("830000"),
    pos = {x=0,y=0},
    sticker_atlas = "enh",
    sticker_pos = {x=3,y=0},
    applied_stakes = { "gold" },
    shiny = true,
    unlocked = false,
    prefix_config = { applied_stakes = { mod = false } },
    loc_txt = {
        name = "Bloody Stake",
        text = {"{C:attentionAll{} Jokers can become {C:red}Vampiric",
                "{C:inactive,s:0.8}(Card is destroyed if neither sides are empty)"},
                sticker = {
                    name = "Bloody Sticker",
                    text = {"Used this Joker",
                            "to win on {C:attention}Bloody",
                            "{C:attention}Stake{} difficulty"}

                }
    },
    modifiers = function()
        G.GAME.modifiers.enable_crv_vamp = true
    end
}

SMODS.Stake{
    key = "haunt",
    atlas = "stakes",
    colour = HEX("232323"),
    pos = {x=1,y=0},
    sticker_atlas = "enh",
    sticker_pos = {x=3,y=1},
    applied_stakes = { "crv_blood" },
    shiny = true,
    unlocked = false,
    prefix_config = { applied_stakes = { mod = false} },
    loc_txt = {
        name = "Haunted Stake",
        text = {"{C:attentionAll{} Jokers can become {C:blue}Haunted",
                "{C:inactive,s:0.8}(Card is destroyed at the end of the round)"},
                sticker = {
                    name = "Haunted Sticker",
                    text = {"Used this Joker",
                            "to win on {C:attention}Haunted",
                            "{C:attention}Stake{} difficulty"}

                }
    },
    modifiers = function()
        G.GAME.modifiers.enable_crv_haunted = true
    end
}


SMODS.Stake{
    key = "raido",
    atlas = "stakes",
    colour = HEX("bd9400"),
    pos = {x=2,y=0},
    sticker_atlas = "enh",
    sticker_pos = {x=3,y=1},
    applied_stakes = { "crv_haunt" },
    shiny = true,
    unlocked = false,
    prefix_config = { applied_stakes = { mod = false} },
    loc_txt = {
        name = "Radioactive Stake",
        text = {"{C:attentionAll{} Jokers can become {C:money}Radioactive",
                "{C:inactive,s:0.8}(At the end of a round, randomly destroy the card on the left or right)"},
                sticker = {
                    name = "Radioactive Sticker",
                    text = {"Used this Joker",
                            "to win on {C:attention}Radioactive",
                            "{C:attention}Stake{} difficulty"}

                }
    },
    modifiers = function()
        G.GAME.modifiers.enable_crv_radioactive = true
    end
}

SMODS.Stake{
    key = "absol",
    atlas = "stakes",
    pos = {x=3,y=0},
    colour = HEX("ffe9b5"),
    sticker_atlas = "enh",
    sticker_pos = {x=4,y=1},
    applied_stakes = { "crv_raido" },
    shiny = true,
    unlocked = false,
    prefix_config = { applied_stakes = { mod = false} },
    loc_txt = {
        name = "Absolute Stake",
        text = {"{C:attentionAll{} Jokers can become {C:attention}Absolute",
                "{C:inactive,s:0.8}(1/4 to create another of self)"},
                sticker = {
                    name = "Absolute Sticker",
                    text = {"Used this Joker",
                            "to win on {C:attention}Absolute",
                            "{C:attention}Stake{} difficulty"}

                }
    },
    modifiers = function()
        G.GAME.modifiers.enable_crv_absolute = true
    end
}