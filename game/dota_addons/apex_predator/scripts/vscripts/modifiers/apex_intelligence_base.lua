apex_intelligence_base = apex_intelligence_base or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)

function apex_intelligence_base:GetTexture() return "apex_intelligence_icon" end -- get the icon from a different ability
function apex_intelligence_base:AllowIllusionDuplicate() return true end
function apex_intelligence_base:IsPermanent() return true end
function apex_intelligence_base:RemoveOnDeath() return false end
function apex_intelligence_base:IsHidden() return true end 	-- we can hide the modifier
function apex_intelligence_base:IsDebuff() return false end 	-- make it red or green

function apex_intelligence_base:GetAttributes()
	
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		+ MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function apex_intelligence_base:OnCreated()
	self:StartIntervalThink(0.1)
end

function apex_intelligence_base:OnIntervalThink()
	if IsClient() then return end
	self:SetStackCount(self:GetParent():GetBaseIntellect())
end
