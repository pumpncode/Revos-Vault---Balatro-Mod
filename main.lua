

-------------MOD CODE-------------
RevosVault = SMODS.current_mod

SMODS.load_file('items/jokers.lua')()
SMODS.load_file('items/decks.lua')()
SMODS.load_file('items/tags.lua')()
SMODS.load_file('items/seals.lua')()
SMODS.load_file('items/enh.lua')()
SMODS.load_file('items/cons.lua')()
SMODS.load_file('items/booster.lua')()
SMODS.load_file('items/vouchers.lua')()
SMODS.load_file('items/vault.lua')()
SMODS.load_file('items/chaos.lua')()

--cross mod content--

if CardSleeves then
SMODS.load_file('items/sleeves.lua')()
end
if JokerDisplay then
    SMODS.load_file('items/display.lua')()
end
SMODS.load_file('Cryptid/items.lua')()






SMODS.Atlas{
    key = 'modicon', 
    path = 'modicon.png', 
    px = 34, 
    py = 34 
}
SMODS.Atlas{
    key = 'booster', 
    path = 'boosters.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'holybanana', 
    path = 'holybanana.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'pedro', 
    path = 'pedro.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'rev', 
    path = 'rev.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'wip', 
    path = 'wip.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'megaprinter', 
    path = 'mega.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'megaenh', 
    path = 'megaenh.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'ghost', 
    path = 'Ghost.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'Decks', 
    path = 'Decks.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'Decks2', 
    path = 'Decks2.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'Jokers', 
    path = 'Jokers.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'Jokers2', 
    path = 'Jokers2.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'tarots', 
    path = 'tarots.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'documents', 
    path = 'documents.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'documents_u', 
    path = 'documents2.png',
    px = 71,
    py = 95 
}

SMODS.Atlas{
    key = 'enh', 
    path = 'enh.png',
    px = 71,
    py = 95 
}

SMODS.Atlas{
    key = 'scrapss', 
    path = 'Scraps.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 't', 
    path = 'tiers.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'gb', 
    path = 'gb.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'gban', 
    path = 'gban.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'spec', 
    path = 'spectrals.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'vouch', 
    path = 'voucher.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'tags', 
    path = 'tags.png', 
    px = 34, 
    py = 34 
}

SMODS.Atlas{
    key = 'mm', 
    path = 'mm.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'sleeves', 
    path = 'sleeves.png', 
    px = 73, 
    py = 95 
}

SMODS.Atlas{
    key = 'cryp', 
    path = 'cryp.png', 
    px = 71, 
    py = 95
}





function joker_add(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)
        -- (Credit to @AstroLighz for the deck codes)
        SMODS.Stickers["eternal"]:apply(j, true)


    end
end

function joker_add_etx(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)

    end
end

function joker_add_per(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)
        SMODS.Stickers["perishable"]:apply(j, true)

    end
end


local igo = Game.init_game_object
Game.init_game_object = function(self)
	local ret = igo(self)
	ret.reincarnation = 1
	ret.henchmans = 0
	ret.talisman = 0
	return ret
end


    

 