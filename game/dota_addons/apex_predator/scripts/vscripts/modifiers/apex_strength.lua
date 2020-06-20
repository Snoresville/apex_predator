apex_strength = apex_strength or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)

function apex_strength:GetTexture() return "apex_strength_icon" end -- get the icon from a different ability

function apex_strength:IsPermanent() return true end
function apex_strength:RemoveOnDeath() return false end
function apex_strength:IsHidden() return false end 	-- we can hide the modifier
function apex_strength:IsDebuff() return false end 	-- make it red or green

function apex_strength:GetAttributes()
	
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		+ MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function apex_strength:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH, -- OnDeath
		MODIFIER_PROPERTY_TOOLTIP, -- OnTooltip
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, -- Stat Bonus
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierfunction
	}
	return funcs
end

-- Stat Gain
function apex_strength:GetModifierBonusStats_Strength()
	local attribute = self:GetParent():GetModifierStackCount("apex_strength_base", self:GetParent()) or 0
	local bonus = self:GetStackCount() * 0.1
	return attribute * bonus
end

function apex_strength:GetModifierMagicalResistanceBonus()
	return math.min(self:GetModifierBonusStats_Strength() * 0.08 or 0, 99.99)
end

-- passing a number to the Tooltip in resource/addon_english.txt 
-- with %dMODIFIER_PROPERTY_TOOLTIP%
function apex_strength:OnTooltip(event)
	local percentage = self:GetStackCount() * 10
	return percentage
end

function apex_strength:OnDeath(event)
	--for k,v in pairs(event) do print("OnDeath",k,v) end -- find out what event.__ to use
	if IsClient() then return end
	
	if event.attacker:GetPlayerOwnerID() == self:GetParent():GetPlayerOwnerID() then 
		--[[ Console Tests
		print("Killer", event.attacker:GetUnitName())
		print("Parent", self:GetParent():GetUnitName())
		print("Unit that triggered event", event.unit:GetUnitName())
		--]]
		
		-- Test for hero kills
		if event.unit:IsRealHero() or event.unit:IsBuilding() or event.unit:GetUnitName() == "npc_dota_roshan" then self:SetStackCount(self:GetStackCount() + 10) 
		else self:SetStackCount(self:GetStackCount() + 1) 
		end
		self:GetParent():CalculateStatBonus()
	end
	--if event.unit~=self:GetParent() then return end -- only affect the own hero
	-- space for some fancy stuff
end

