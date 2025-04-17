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
if next(SMODS.find_mod("Cryptid")) then
	SMODS.load_file("Cryptid/items.lua")()
end

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

if next(SMODS.find_mod("sdm0sstuff")) then
	SMODS.load_file("items/Cross-Mod/sdm0.lua")()
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
	path = "togabpack.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "togaw",
	path = "togaprint.png",
	px = 72,
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

SMODS.Atlas({
	key = "sdm0",
	path = "sdm0.png",
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

--all vanilla jokers.

local vanilla = {
	"j_joker",
	"j_greedy_joker",
	"j_lusty_joker",
	"j_wrathful_joker",
	"j_gluttenous_joker",
	"j_zany",
	"j_mad",
	"j_crazy",
	"j_droll",
	"j_sly",
	"j_wily",
	"j_clever",
	"j_devious",
	"j_crafty",
	"j_half",
	"j_stencil",
	"j_four_fingers",
	"j_mime",
	"j_credit_card",
	"j_ceremonial",
	"j_banner",
	"j_mystic_summit",
	"j_marble",
	"j_loyalty_card",
	"j_8_ball",
	"j_misprint",
	"j_dusk",
	"j_raised_fist",
	"j_chaos",
	"j_fibonacci",
	"j_steel_joker",
	"j_scary_face",
	"j_abstract",
	"j_delayed_grat",
	"j_hack",
	"j_pareidolia",
	"j_gros_michel",
	"j_even_steven",
	"j_odd_todd",
	"j_scholar",
	"j_business",
	"j_supernova",
	"j_ride_the_bus",
	"j_space",
	"j_egg",
	"j_burglar",
	"j_blackboard",
	"j_runner",
	"j_ice_cream",
	"j_dna",
	"j_splash",
	"j_blue_joker",
	"j_sixth_sense",
	"j_constellation",
	"j_hiker",
	"j_faceless",
	"j_green_joker",
	"j_superposition",
	"j_todo_list",
	"j_cavendish",
	"j_card_sharp",
	"j_red_card",
	"j_madness",
	"j_square",
	"j_seance",
	"j_riff_raff",
	"j_vampire",
	"j_shortcut",
	"j_hologram",
	"j_vagabond",
	"j_baron",
	"j_cloud_9",
	"j_rocket",
	"j_obelisk",
	"j_midas_mask",
	"j_luchador",
	"j_photograph",
	"j_gift",
	"j_turtle_bean",
	"j_erosion",
	"j_reserved_parking",
	"j_mail",
	"j_to_the_moon",
	"j_hallucination",
	"j_fortune_teller",
	"j_juggler",
	"j_drunkard",
	"j_stone",
	"j_golden",
	"j_lucky_cat",
	"j_baseball",
	"j_bull",
	"j_diet_cola",
	"j_trading",
	"j_flash",
	"j_popcorn",
	"j_trousers",
	"j_ancient",
	"j_ramen",
	"j_walkie_talkie",
	"j_selzer",
	"j_castle",
	"j_smiley",
	"j_campfire",
	"j_ticket",
	"j_mr_bones",
	"j_acrobat",
	"j_sock_and_buskin",
	"j_swashbuckler",
	"j_troubadour",
	"j_certificate",
	"j_smeared",
	"j_throwback",
	"j_hanging_chad",
	"j_rough_gem",
	"j_bloodstone",
	"j_arrowhead",
	"j_onyx_agate",
	"j_glass",
	"j_ring_master",
	"j_flower_pot",
	"j_blueprint",
	"j_wee",
	"j_merry_andy",
	"j_oops",
	"j_idol",
	"j_seeing_double",
	"j_matador",
	"j_hit_the_road",
	"j_duo",
	"j_trio",
	"j_family",
	"j_order",
	"j_tribe",
	"j_stuntman",
	"j_invisible",
	"j_brainstorm",
	"j_satellite",
	"j_shoot_the_moon",
	"j_drivers_license",
	"j_cartomancer",
	"j_astronomer",
	"j_burnt",
	"j_bootstraps",
	"j_caino",
	"j_triboulet",
	"j_yorick",
	"j_chicot",
	"j_perkeo",
}


--ily cryptid
SMODS.ObjectType({
	key = "Food",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_egg)
		self:inject_card(G.P_CENTERS.j_ice_cream)
		self:inject_card(G.P_CENTERS.j_cavendish)
		self:inject_card(G.P_CENTERS.j_turtle_bean)
		self:inject_card(G.P_CENTERS.j_diet_cola)
		self:inject_card(G.P_CENTERS.j_popcorn)
		self:inject_card(G.P_CENTERS.j_ramen)
		self:inject_card(G.P_CENTERS.j_selzer)
	end,
})

SMODS.ObjectType({
	key = "BananaPool",
	cards = {
		["j_crv_ghostbanana"] = true,
		["j_crv_plantain"] = true,
		["j_crv_reban"] = true,
		["j_crv_tundan"] = true,
		["j_crv_bluj"] = true,
		["j_crv_bananavine"] = true,
		["j_crv_plainb"] = true,
		["j_crv_tickingb"] = true,
		["j_crv_uneasyb"] = true,
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_cavendish)
	end,
})

RevosVault.optional_features = {retrigger_joker = true}

SMODS.Joker({   --used for the title screen
	key = "printertitle",
	atlas = "Jokers",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = true,
	no_collection = true,
	pos = {
		x = 0,
		y = 0,
	},
	in_pool = function(self)
		return false
	end,
})

SMODS.Joker({ 	--used for the title screen
	key = "grossprintertitle",
	atlas = "Jokers",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = true,
	no_collection = true,
	pos = {
		x = 0,
		y = 1,
	},
	in_pool = function(self)
		return false
	end,
})

--Adds Gross Printer to the main menu. Code from Cryptid


local oldfunc = Game.main_menu   --ily cryptid x2
	Game.main_menu = function(change_context)
		local ret = oldfunc(change_context)

		local newcard = Card(
			G.title_top.T.x,
			G.title_top.T.y,
			G.CARD_W,
			G.CARD_H,
			G.P_CARDS.empty,
			G.P_CENTERS.j_crv_grossprintertitle,
			{ bypass_discovery_center = true }
		)

		G.title_top.T.w = G.title_top.T.w * 1.7675
		G.title_top.T.x = G.title_top.T.x - 0.8
		G.title_top:emplace(newcard)

		newcard.T.w = newcard.T.w * 1.1 * 1.25
		newcard.T.h = newcard.T.h * 1.1 * 1.25
		newcard.no_ui = true
		newcard.states.visible = true
	end
