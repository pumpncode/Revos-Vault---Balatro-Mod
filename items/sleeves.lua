if CardSleeves then
CardSleeves.Sleeve {
    key = "machinerys",
    atlas = "sleeves",
    unlocked = false,
    config = { discards = 0,hands = 0 },
    unlock_condition = {deck = "b_crv_mach", stake = "stake_gold"},
    pos = { x = 0, y = 0 },
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_crv_os" or self.get_current_deck_key() == "b_crv_mach" then
            key = self.key .. "_alt"
            self.config = { discards = -2,hands = -1 }
            vars = { self.config.discards,self.config.hands }
        end
        return { key = key, vars = vars }
    end,
    apply = function(self)
        CardSleeves.Sleeve.apply(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                joker_add('j_crv_printer')
                return true
            end
        }))
    end
}
CardSleeves.Sleeve {
    key = "oldscrolls",
    atlas = "sleeves",
    unlocked = false,
    config = { discards = 0,hands = 0 },
    unlock_condition = {deck = "b_crv_os", stake = "stake_gold"},
    pos = { x = 1, y = 0 },
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_crv_os" or self.get_current_deck_key() == "b_crv_mach" then
            key = self.key .. "_alt"
            self.config = { discards = -2,hands = -1 }
            vars = { self.config.discards,self.config.hands }
        end
        return { key = key, vars = vars }
    end,
    apply = function(self)
        CardSleeves.Sleeve.apply(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                joker_add('j_crv_rustyprinter')
                return true
            end
        }))
    end
}
CardSleeves.Sleeve {
    key = "goldms",
    atlas = "sleeves",
    unlocked = false,
    unlock_condition = {deck = "b_crv_gm", stake = "stake_gold"},
    pos = { x = 2, y = 0 },
    config = { dollars = 0 },
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() ~= "b_yellow" then
            key = self.key
            self.config = { dollars = 0 }
            vars = { self.config.dollars }
        else
            key = self.key .. "_alt"
            self.config = { dollars = 10 }
            vars = { self.config.dollars }
        end
        return { key = key, vars = vars }
    end,
    apply = function(self)
        CardSleeves.Sleeve.apply(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                joker_add('j_crv_moneyprinter')
                return true
            end
        }))
    end
}
CardSleeves.Sleeve {
    key = "rpds",
    atlas = "sleeves",
    unlocked = false,
    unlock_condition = {deck = "b_crv_rpd", stake = "stake_gold"},
    pos = { x = 3, y = 0 },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                joker_add('j_crv_brokenprinter')
                return true
            end
        }))
    end
}
CardSleeves.Sleeve {
    key = "jims",
    atlas = "sleeves",
    unlocked = false,
    unlock_condition = {deck = "b_crv_jw", stake = "stake_gold"},
    pos = { x = 4, y = 0 },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                joker_add('j_crv_jimboprinter')
                return true
            end
        }))
    end
}
CardSleeves.Sleeve {
    key = "grossl",
    atlas = "sleeves",
    unlocked = false,
    unlock_condition = {deck = "b_crv_gd", stake = "stake_gold"},
    pos = { x = 0, y = 1 },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                joker_add('j_crv_grossprinter')
                return true
            end
        }))
    end
}
end