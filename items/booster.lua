local cc = {'j_crv_printer','j_crv_rustyprinter','j_crv_jimboprinter','j_crv_obeliskprinter','j_crv_moneyprinter',
'j_crv_brokenprinter','j_crv_faxprinter','j_crv_spectralprinter','j_crv_glassprinter',
'j_crv_smile!','j_crv_lpm','j_crv_devilishprinter','j_crv_head','j_crv_body','j_crv_back','j_crv_steelprinter',
'j_crv_tierp','j_crv_luckyprinter','j_crv_celestialprinter','j_crv_pcp','j_crv_fcp','j_crv_hcp','j_crv_ncp','j_crv_urp'}

SMODS.Booster{
    key = 'pbst',
    atlas = 'booster',
    pos= {x=0,y=0},
    config = {extra = 2,choose = 1},
    group_key = 'k_crv_pbstg',
    cost = 4,
    weight = 1,
    create_card = function(self, card, i)
        return create_card("Printers", G.pack_cards, nil, nil, true,  true, pseudorandom_element(cc, pseudoseed('pbst')))
    end,
}