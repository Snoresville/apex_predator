apex_agility_base = apex_agility_base or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)

function apex_agility_base:GetTexture() return "apex_agility_icon" end -- get the icon from a different ability

function apex_agility_base:IsPermanent() return true end
function apex_agility_base:RemoveOnDeath() return false end
function apex_agility_base:IsHidden() return true end 	-- we can hide the modifier
function apex_agility_base:IsDebuff() return false end 	-- make it red or green

function apex_agility_base:GetAttributes()
	
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		+ MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function apex_agility_base:OnCreated()
	self:StartIntervalThink(0.1)
end

function apex_agility_base:OnIntervalThink()
	if IsClient() then return end
	self:SetStackCount(self:GetParent():GetBaseAgility())
end
