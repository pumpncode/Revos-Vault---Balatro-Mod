-------------MOD CODE-------------
RevosVault = SMODS.current_mod

SMODS.load_file("items/jokers.lua")()
SMODS.load_file("items/decks.lua")()
SMODS.load_file("items/tags.lua")()
SMODS.load_file("items/seals.lua")()
SMODS.load_file("items/enh.lua")()
SMODS.load_file("items/cons.lua")()
SMODS.load_file("items/booster.lua")()
SMODS.load_file("items/vouchers.lua")()
SMODS.load_file("items/stickers.lua")()
SMODS.load_file("items/stakes.lua")()
SMODS.load_file("items/challenge.lua")()
SMODS.load_file("items/blinds.lua")()
SMODS.load_file("items/vault.lua")()
SMODS.load_file("items/chaos.lua")()

--cross mod content--

if next(SMODS.find_mod("RiftRaft")) then
	SMODS.load_file("items/Cross-Mod/riftraft.lua")()
end

if next(SMODS.find_mod("reverse_tarot")) then
	SMODS.load_file("items/Cross-Mod/reversetarot.lua")()
end

if next(SMODS.find_mod("TOGAPack")) then
	SMODS.load_file("items/Cross-Mod/toga.lua")()
end

if CardSleeves then
	SMODS.load_file("items/Cross-Mod/sleeves.lua")()
end

if JokerDisplay then
	SMODS.load_file("items/Cross-Mod/display.lua")()
end
SMODS.load_file("Cryptid/items.lua")()

if Bakery_API and Bakery_API.Charm or next(SMODS.find_mod("Bakery")) then
	SMODS.load_file("items/Cross-Mod/charms.lua")()
end

if next(SMODS.find_mod("Maximus")) then
	SMODS.load_file("items/Cross-Mod/maximus.lua")()
end

if next(SMODS.find_mod("MoreFluff")) then
	SMODS.load_file("items/Cross-Mod/morefluff.lua")()
end

if next(SMODS.find_mod("Prism")) then
	SMODS.load_file("items/Cross-Mod/prism.lua")()
end

SMODS.Atlas({
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34,
})
SMODS.Atlas({
	key = "booster",
	path = "boosters.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "holybanana",
	path = "holybanana.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "pedro",
	path = "pedro.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "rev",
	path = "rev.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "wip",
	path = "wip.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "megaprinter",
	path = "mega.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "megaprinterc",
	path = "megac.png",
	px = 174,
	py = 95,
})

SMODS.Atlas({
	key = "megaenh",
	path = "megaenh.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "ghost",
	path = "Ghost.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "Decks",
	path = "Decks.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "Decks2",
	path = "Decks2.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "Jokers",
	path = "Jokers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "Jokers2",
	path = "Jokers2.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "tarots",
	path = "tarots.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "documents",
	path = "documents.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "documents_u",
	path = "documents2.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "enh",
	path = "enh.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "scrapss",
	path = "Scraps.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "t",
	path = "tiers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "gb",
	path = "gb.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "gban",
	path = "gban.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "spec",
	path = "spectrals.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "vouch",
	path = "voucher.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "tags",
	path = "tags.png",
	px = 34,
	py = 34,
})

SMODS.Atlas({
	key = "blinds",
	path = "blinds.png",
	atlas_table = "ANIMATION_ATLAS",
	px = 34,
	py = 34,
	frames = 21,
})

SMODS.Atlas({
	key = "mm",
	path = "mm.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "sleeves",
	path = "sleeves.png",
	px = 73,
	py = 95,
})

SMODS.Atlas({
	key = "stakes",
	path = "stakes.png",
	px = 29,
	py = 29,
})

SMODS.Atlas({
	key = "cryp",
	path = "cryp.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "riftr",
	path = "rift.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "rtarot",
	path = "reversetarot.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "togap",
	path = "toga.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "togaw",
	path = "toga.png",
	px = 73,
	py = 95,
})

SMODS.Atlas({
	key = "bakerycharms",
	path = "charms.png",
	px = 68,
	py = 68,
})

SMODS.Atlas({
	key = "maximusc",
	path = "maximus.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "morefluff45",
	path = "morefluff45.png",
	px = 114,
	py = 114,
})

SMODS.Atlas({
	key = "prismc",
	path = "prism.png",
	px = 71,
	py = 95,
})



function joker_add(jKey)
	if type(jKey) == "string" then
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
	if type(jKey) == "string" then
		local j = SMODS.create_card({
			key = jKey,
		})

		j:add_to_deck()
		G.jokers:emplace(j)
	end
end

function joker_add_per(jKey)
	if type(jKey) == "string" then
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
	if next(SMODS.find_mod("Talisman")) then
		ret.talisman = 1
	else
		ret.talisman = 0
	end
	return ret
end