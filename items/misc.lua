SMODS.Sound({ key = "facmult", path = "facmult.ogg" })

if SMODS and SMODS.calculate_individual_effect then
	local calcinvold = SMODS.calculate_individual_effect
	function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		local ret = calcinvold(effect, scored_card, key, amount, from_edition)
		if ret then
			return ret
		end

		if
			(key == "f_mult" or key == "F_mult" or key == "Factorial_mult" or key == "factorial_mult")
			and amount ~= 0
		then
			if effect.card then
				juice_card(effect.card)
			end
			mult = mod_chips(RevosVault.factorial(mult) * amount)
			update_hand_text({ delay = 0 }, { chips = hand_chips, mult = mult })
			card_eval_status_text(scored_card, "extra", nil, nil, nil, { message = "Mult! * " .. amount })
			return true
		end

		if (key == "p_mult" or key == "P_mult" or key == "perc_mult" or key == "Perc_mult") and amount ~= 0 then
			if effect.card then
				juice_card(effect.card)
			end
			mult = mod_chips(mult + RevosVault.perc(mult,amount))
			update_hand_text({ delay = 0 }, { chips = hand_chips, mult = mult })
			card_eval_status_text(scored_card, "extra", nil, nil, nil, { message = "+%"..amount})
			return true
		end
	end
	for _, v in ipairs({ "p_mult", "P_mult", "perc_mult", "Perc_mult", "f_mult", "F_mult", "Factorial_mult", "factorial_mult"  }) do
		table.insert(SMODS.calculation_keys, v)
	end
end
