apex_agility = apex_agility or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)

function apex_agility:GetTexture() return "apex_agility_icon" end -- get the icon from a different ability

function apex_agility:IsPermanent() return true end
function apex_agility:RemoveOnDeath() return false end
function apex_agility:IsHidden() return false end 	-- we can hide the modifier
function apex_agility:IsDebuff() return false end 	-- make it red or green

function apex_agility:GetAttributes()
	
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		+ MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function apex_agility:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH, -- OnDeath
		MODIFIER_PROPERTY_TOOLTIP, -- OnTooltip
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS, -- Stat Bonus
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierfunction
	}
	return funcs
end

-- Stat Gain
function apex_agility:GetModifierBonusStats_Agility()
	local attribute = self:GetParent():GetBaseAgility()
	local bonus = self:GetStackCount() * 0.1
	return attribute * bonus
end



-- passing a number to the Tooltip in resource/addon_english.txt 
-- with %dMODIFIER_PROPERTY_TOOLTIP%
function apex_agility:OnTooltip(event)
	local percentage = self:GetStackCount() * 10
	return percentage
end

function apex_agility:OnDeath(event)
	--for k,v in pairs(event) do print("OnDeath",k,v) end -- find out what event.__ to use
	if IsClient() then return end
	
	if event.attacker == self:GetParent() then 
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

