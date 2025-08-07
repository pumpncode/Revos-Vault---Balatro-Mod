



SMODS.Stake{
    key = "pitch_black",
    atlas = "stakes",
    pos = {x=2,y=1},
    colour = HEX("fdffa8"),
    sticker_atlas = "enh",
    sticker_pos = {x=6,y=3},
    applied_stakes = { "crv_overt" },
    shiny = true,
    unlocked = false,
    prefix_config = { applied_stakes = { mod = false} },
    loc_txt = {
        name = "Overtime Stake",
        text = {"{C:attentionAll{} Jokers can have {C:money}Overtime"},
                sticker = {
                    name = "Overtime Sticker",
                    text = {"Used this Joker",
                            "to win on {C:attention}Overtime",
                            "{C:attention}Stake{} difficulty"}

                }
    },
    modifiers = function()
        G.GAME.modifiers.enable_no_vouchers = true
    end
}