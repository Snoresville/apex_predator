item_apex_agility_lua = class({})

-- Ability Start
function item_apex_agility_lua:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    if caster:IsHero() and caster:IsRealHero() and not caster:IsIllusion() then
        caster:AddNewModifier(caster, nil, "apex_agility", {})
		caster:AddNewModifier(caster, nil, "apex_agility_base", {})
		caster:SetBaseAgility(caster:GetBaseAgility + self:GetSpecialValueFor("stat_gain"))
		EmitSoundOn("Item.TomeOfKnowledge", caster)

        -- Consume one charge
        self:SpendCharge()
    end
end