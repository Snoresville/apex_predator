item_apex_intelligence_lua = class({})

-- Ability Start
function item_apex_intelligence_lua:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    if caster:IsHero() and caster:IsRealHero() and not caster:IsIllusion() then
        caster:AddNewModifier(caster, nil, "apex_intelligence", {})
		caster:AddNewModifier(caster, nil, "apex_intelligence_base", {})
		caster:SetBaseIntellect(caster:GetBaseIntellect + self:GetSpecialValueFor("stat_gain"))
		EmitSoundOn("Item.TomeOfKnowledge", caster)

        -- Consume one charge
        self:SpendCharge()
    end
end