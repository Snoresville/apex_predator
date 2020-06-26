local Thinker = class({})

ListenToGameEvent("game_rules_state_game_in_progress", function()
		Timers:CreateTimer( 0, Thinker.Minute00 )
		Timers:CreateTimer( 20*60, Thinker.DontForgetToSubscribe )
		Timers:CreateTimer( 30*60, Thinker.LateGame )
		Timers:CreateTimer( Thinker.VeryVeryOften )
		Timers:CreateTimer( Thinker.VeryOften )
		Timers:CreateTimer( Thinker.Often )
		Timers:CreateTimer( Thinker.Regular )
		Timers:CreateTimer( Thinker.Seldom )
end, GameMode)

local buildings = {
	"npc_dota_tower",
	"ent_dota_fountain",
	"npc_dota_barracks",
	"npc_dota_fort",
	"npc_dota_filler",
}

function Thinker:Minute00()
	if IsClient() then return end
	
	for _,towerName in ipairs(buildings) do
		local tTowers = Entities:FindAllByClassname(towerName)
		for k, v in pairs(tTowers) do
			v:AddAbility("deathtower")
		end
	end

	print("The Game begins!")
	return nil -- does not repeat
end

function Thinker:DontForgetToSubscribe()
	-- print("20 minutes")
	return nil -- does not repeat
end

function Thinker:LateGame()
	-- print("30 minutes")
	return nil -- does not repeat
end

function Thinker:VeryVeryOften()
	-- print("every 10 seconds")
	return 10
end

function Thinker:VeryOften()
	-- print("every minute")
	return 1*60
end

function Thinker:Often()
	-- print("every 5 minutes")
	BUTTINGS.GOLD_PER_MINUTE = BUTTINGS.GOLD_PER_MINUTE * 2
	BUTTINGS.GOLD_GAIN_PERCENTAGE = BUTTINGS.GOLD_GAIN_PERCENTAGE * 2
	GameRules:SetGoldTickTime( 60/(BUTTINGS.GOLD_PER_MINUTE) )
	
	
	
	return 5*60
end

function Thinker:Regular()
	-- print("every 15 minutes")
	return 15*60
end

function Thinker:Seldom()
	-- print("every 30 minutes")
	return 30*60
end
