item_apex_strength_lua = class({})

-- Ability Start
function item_apex_strength_lua:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    if caster:IsHero() and caster:IsRealHero() and not caster:IsIllusion() then
        caster:AddNewModifier(caster, nil, "apex_strength", {})
		caster:AddNewModifier(caster, nil, "apex_strength_base", {})
		caster:SetBaseStrength(caster:GetBaseStrength + self:GetSpecialValueFor("stat_gain"))
		EmitSoundOn("Item.TomeOfKnowledge", caster)

        -- Consume one charge
        self:SpendCharge()
    end
end