SMODS.Stake{
    key = "blood",
    atlas = "stakes",
    pos = {x=0,y=0},
    sticker_atlas = "enh",
    sticker_pos = {x=3,y=0},
    applied_stakes = { "gold" },
    shiny = true,
    unlocked = false,
    prefix_config = { applied_stakes = { mod = false } },
    loc_txt = {
        name = "Bloody",
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