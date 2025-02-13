
SMODS.Back{
    name = 'Machinery',
    key = 'mach',
    atlas = 'Decks',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Machinery',
        text = {
            'Start with an',
            'Eternal {C:attention}Blueprinter{}'
        },
    },
    
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_printer')


                return true
            end
        }))
    end
}


SMODS.Back{
    name = 'Old Scroll',
    key = 'os',
    atlas = 'Decks',
    pos = {x = 1, y = 0},
    loc_txt = {
        name = 'Old Scroll',
        text = {
            'Start with an',
            'Eternal{C:attention} Rusty Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_rustyprinter')


                return true
            end
        }))
    end
}


SMODS.Back{
    name = 'Gold Mayhem',
    key = 'gm',
    atlas = 'Decks',
    pos = {x = 2, y = 1},
    loc_txt = {
        name = 'Gold Mayhem',
        text = {
            'Start with an',
            'Eternal {C:money}Money Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_moneyprinter')


                return true
            end
        }))
    end
}


    SMODS.Back{
    name = 'Ripped Deck',
    key = 'rpd',
    atlas = 'Decks',
    pos = {x = 0, y = 2},
    loc_txt = {
        name = 'Ripped Deck',
        text = {
            'Start with an',
            'Eternal {C:attention}Broken Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_brokenprinter')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Jimbo's World",
    key = 'jw',
    atlas = 'Decks',
    pos = {x = 2, y = 0},
    loc_txt = {
        name = 'Jimbo World',
        text = {
            'Start with an',
            'Eternal {C:attention}Jimbo Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_jimboprinter')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'Gross Deck',
    key = 'gd',
    atlas = 'Decks',
    pos = {x = 0, y = 1},
    loc_txt = {
        name = 'Gross Deck',
        text = {
            'Start with an',
            'Eternal {C:attention}Gross Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_grossprinter')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'The Suspicious Desert',
    key = 'tsd',
    atlas = 'Decks',
    pos = {x = 1, y = 1},
    loc_txt = {
        name = 'The Suspicious Desert',
        text = {
            'Start with an',
            'Eternal {C:attention}Obelisk Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({
            func = function ()
                joker_add('j_crv_obeliskprinter')
                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'Speaking Fax',
    key = 'spx',
    atlas = 'Decks',
    pos = {x = 1, y = 2},
    loc_txt = {
        name = 'Speaking Fax',
        text = {
            'Start with an',
            'Eternal {C:attention}Fax Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({
            func = function ()
                joker_add('j_crv_faxprinter')
                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'Phantom Forge',
    key = 'phf',
    atlas = 'Decks',
    pos = {x = 2, y = 2},
    loc_txt = {
        name = 'Phantom Forge',
        text = {
            'Start with an',
            'Eternal {C:attention}Spectral Printer{}',
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({
            func = function ()
                joker_add('j_crv_spectralprinter')
                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'Hollow Gems',
    key = 'hg',
    atlas = 'Decks',
    pos = {x = 0, y = 3},
    loc_txt = {
        name = 'Hollow Gems',
        text = {
            'Start with an',
            'Eternal{C:attention} Legendary Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_legendaryprinter')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'Glassbound',
    key = 'gb',
    atlas = 'Decks',
    pos = {x = 1, y = 3},
    loc_txt = {
        name = 'Glassbound',
        text = {
            'Start with an',
            'Eternal{C:attention} Glass Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_glassprinter')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'Art Gallery',
    key = 'atg',
    atlas = 'Decks',
    pos = {x = 2, y = 3},
    loc_txt = {
        name = 'Art Gallery',
        text = {
            'Start with an',
            'Eternal{C:attention} Camera{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_smile!')
                joker_add('j_joker')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = 'The Company Is Hiring!',
    key = 'tcih',
    atlas = 'Decks',
    pos = {x = 0, y = 4},
    loc_txt = {
        name = 'The Company Is Hiring!',
        text = {
            'Start with an',
            'Eternal{C:attention} Lethal Press Machine{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_lpm')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Devil's Casino",
    key = 'dc',
    atlas = 'Decks2',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Devil's Casino",
        text = {
            'Start with an',
            'Eternal{C:attention} Devilish Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_devilishprinter')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = "MDeck HQ",
    key = 'rf',
    atlas = 'Decks2',
    pos = {x = 1, y = 0},
    loc_txt = {
        name = "MDeck HQ",
        text = {
            'Start with an',
            'Eternal{C:attention} Completed Mega Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_head')
                joker_add('j_crv_body')
                joker_add('j_crv_back')


                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Steelbound",
    key = 'sb',
    atlas = 'Decks2',
    pos = {x = 2, y = 0},
    loc_txt = {
        name = "Steelbound",
        text = {
            'Start with an',
            'Eternal{C:attention} Steel Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_steelprinter')



                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Upgrade!",
    key = 'up',
    atlas = 'Decks2',
    pos = {x = 3, y = 0},
    loc_txt = {
        name = "Upgrade!",
        text = {
            'Start with an',
            'Eternal{C:attention} Advanced Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_tierp')



                return true
            end
        }))
    end
}
SMODS.Back{
    name = "Lucky Pot",
    key = 'lp',
    atlas = 'Decks2',
    pos = {x = 0, y = 1},
    loc_txt = {
        name = "Lucky Pot",
        text = {
            'Start with an',
            'Eternal{C:attention} Lucky Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_luckyprinter')



                return true
            end
        }))
    end
}


SMODS.Back{
    name = "Celestial Forge",
    key = 'cf',
    atlas = 'Decks2',
    pos = {x = 1, y = 1},
    loc_txt = {
        name = "Celestial Forge",
        text = {
            'Start with an',
            'Eternal{C:attention} Celestial Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_celestialprinter')



                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Polychrome Deck",
    key = 'pd',
    atlas = 'Decks2',
    pos = {x = 2, y = 2},
    loc_txt = {
        name = "Polychrome Deck",
        text = {
            'Start with an',
            'Eternal{C:attention} Polychrome Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_pcp')



                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Foil Deck",
    key = 'fd',
    atlas = 'Decks2',
    pos = {x = 0, y = 2},
    loc_txt = {
        name = "Foil Deck",
        text = {
            'Start with an',
            'Eternal{C:attention} Foil Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_fcp')



                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Holographic Deck",
    key = 'hd',
    atlas = 'Decks2',
    pos = {x = 1, y = 2},
    loc_txt = {
        name = "Holographic Deck",
        text = {
            'Start with an',
            'Eternal{C:attention} Holographic Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_hcp')



                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Negative Deck",
    key = 'nd',
    atlas = 'Decks2',
    pos = {x = 3, y = 2},
    loc_txt = {
        name = "Negative Deck",
        text = {
            'Start with an',
            'Eternal{C:attention} Negative Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_ncp')



                return true
            end
        }))
    end
}

SMODS.Back{
    key = 'und',
    atlas = 'Decks2',
    pos = {x = 3, y = 1},
    loc_txt = {
        name = "Unregistered Deck",
        text = {
            'Start with an',
            'Eternal{C:attention} Unregistered Printer{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()


                joker_add('j_crv_urp')



                return true
            end
        }))
    end
}