deathtower = class({})

--               modifiername used below ,       filepath            , weird valve thing
LinkLuaModifier( "deathtowermodifier", "abilities/deathtower", LUA_MODIFIER_MOTION_NONE )
function deathtower:GetIntrinsicModifierName()
	return "deathtowermodifier"
end


-------------------------------------------------------------------------------------------------------------------------------
-- everything down from here is a modifier. LinkLuaModifier adds it to the game, so the AddNewModifier(..) knows where to find it.



deathtowermodifier = class({})

function deathtowermodifier:GetTexture() return "item_mask_of_madness" end

function deathtowermodifier:IsPurgable() return false end
function deathtowermodifier:IsHidden() return false end
function deathtowermodifier:RemoveOnDeath() return false end

function deathtowermodifier:OnCreated( kv )
	if IsClient() then return end

	--self.health_multiplier = self:GetAbility():GetSpecialValueFor("max_hp_health_multiplier")
	
	local tower = self:GetParent()
	
	local ability2 = tower:AddAbility("huskar_berserkers_blood")
	local ability3 = tower:AddAbility("medusa_split_shot")
	local ability4 = tower:AddAbility("spectre_dispersion")
	local ability5 = tower:AddAbility("ursa_fury_swipes")
	local ability6 = tower:AddAbility("tidehunter_kraken_shell")
	local ability7 = tower:AddAbility("special_bonus_unique_medusa_4")
	local ability8 = tower:AddAbility("special_bonus_unique_ursa_4")
	local ability9 = tower:AddAbility("special_bonus_unique_ursa")
	local ability10 = tower:AddAbility("slardar_bash")
	local ability11 = tower:AddAbility("special_bonus_unique_faceless_void_4")
end


function deathtowermodifier:DeclareFunctions()
	return {
	
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		-- MODIFIER_EVENT_ON_TELEPORTED, -- OnTeleported 
		-- MODIFIER_PROPERTY_MANA_BONUS, -- GetModifierManaBonus 

		-- can contain everything from the API
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

	}
end

function deathtowermodifier:OnAttackLanded(params)

	--for k,v in pairs(params) do
	--	print(k,v)
	--end
	
	if IsClient() then return end
	
	if params.attacker == self:GetParent() then

		local target = params.target
		if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
			local damagetable = {
						victim = target,
						attacker = self:GetParent(),
						damage = (target:GetMaxHealth() * self:GetAbility():GetSpecialValueFor( "max_hp_percent_damage" )/100),
						damage_type = DAMAGE_TYPE_PURE,
						damage_flags = DOTA_DAMAGE_FLAG_IGNORES_MAGIC_ARMOR, -- Optional, more can be added with + .. No flags = 0.
					}
			ApplyDamage(damagetable)
		end
	end
end




--[[
-- MAN THIS FUNCTION DOESN'T EVEN WANT TO WORK!!!!!!!!!1
function deathtowermodifier:GetModifierExtraHealthBonus(params)
	
	local parent = self:GetParent() -- Modifier, finding the guy with the ability.
	local maxHealth = parent:GetMaxHealth()
	
	print(maxHealth)
	print(self.armor)
	print(self.health_multiplier)
	print("------------")
	
	return maxHealth * (self.health_multiplier - 1)
end
--]]