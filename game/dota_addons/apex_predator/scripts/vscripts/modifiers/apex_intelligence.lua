apex_intelligence = apex_intelligence or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)

function apex_intelligence:GetTexture() return "apex_intelligence_icon" end -- get the icon from a different ability

function apex_intelligence:IsPermanent() return true end
function apex_intelligence:RemoveOnDeath() return false end
function apex_intelligence:IsHidden() return false end 	-- we can hide the modifier
function apex_intelligence:IsDebuff() return false end 	-- make it red or green

function apex_intelligence:GetAttributes()
	
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		+ MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function apex_intelligence:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH, -- OnDeath
		MODIFIER_PROPERTY_TOOLTIP, -- OnTooltip
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, -- Stat Bonus
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierfunction
	}
	return funcs
end

-- Stat Gain
function apex_intelligence:GetModifierBonusStats_Intellect()
	local attribute = self:GetParent():GetModifierStackCount("apex_intelligence_base", self:GetParent()) or 0
	local bonus = self:GetStackCount() * 0.1
	return attribute * bonus
end

function apex_intelligence:GetModifierSpellAmplify_Percentage()
	return self:GetModifierBonusStats_Intellect() * 0.06
end

-- passing a number to the Tooltip in resource/addon_english.txt 
-- with %dMODIFIER_PROPERTY_TOOLTIP%
function apex_intelligence:OnTooltip(event)
	local percentage = self:GetStackCount() * 10
	return percentage
end

function apex_intelligence:OnDeath(event)
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

