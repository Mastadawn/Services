repeat task.wait() until game:IsLoaded()

local neckOrigin = game.Players.LocalPlayer.Character.Head.Neck.C0

Utility = {
    Predict = function(player: Instance): Vector3
        return player.Character.HumanoidRootPart.Position + (player.Character.HumanoidRootPart.Velocity * 0.075)
    end,
    GetNearbyPlayers = function(range: number, addself: boolean): table
        local nearby = {}
        for _,Player in pairs(game:GetService("Players"):GetPlayers()) do
            if Player.Character and Player.Character.PrimaryPart then
                if (Player.Character.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude <= range then
                    if Player.UserId == game.Players.LocalPlayer.UserId then
                        if addself == true then
                            table.insert(nearby,Player)
                        end
                    else
                        table.insert(nearby,Player)
                    end
                end
            end
        end
        return nearby
    end,
    IsAlive = function(Entity: Instance): boolean
        if Entity and Entity.PrimaryPart and Entity:FindFirstChild("Humanoid") and Entity.Humanoid.Health > 0 then
            return true
        else
            return false
        end
    end,
    GetBestSword = function(meta: module, inv: table): Instance
        local hd = -math.huge
        local s;
      	for _, i in next, inv.items do 
        		local t = meta[i.itemType].sword;
        		if t then
          			local sd = (t.damage / t.attackSpeed);
          			if (sd > hd) then
            				s = i;
            				hd = sd;
          			end
        		end
      	end
      	return s
    end,    
    Rotation = function(v0: Vector3): nil
        local v1 = v0
        local v2 = game:GetService("Players").LocalPlayer.Character.Head
        local v3 = (v1 - v2.Position).Unit
        local v4 = game.Players.LocalPlayer.Character
        local v5 = CFrame.new(Vector3.new(), v4.PrimaryPart.CFrame:VectorToObjectSpace(v3))
        game:GetService("Players").LocalPlayer.Character.Head.Neck.C0 = v5 + Vector3.new(0,.75,0)
    end,
    ResetRotation = function(): nil
        game:GetService("Players").LocalPlayer.Character.Head.Neck.C0 = neckOrigin 
    end,
    GetChests = function(): table
      	local mdist = 40;
        local chest;
      	for _, c in next, game:GetService("CollectionService"):GetTagged("chest") do
        		if c:FindFirstChild("ChestFolderValue") then
          			if d < (c.Position - game:GetService("Players").LocalPlayer.Character.PrimaryPart.Position).Magnitude then
            				chest = c
            				mdist = (c.Position - game:GetService("Players").LocalPlayer.Character.PrimaryPart.Position).Magnitude
          			end
        		end
      	end
      	return chest:FindFirstChild("ChestFolderValue")
    end,
    GetCharacter = function(): Instance
        return game:GetService("Players").LocalPlayer.Character or nil
    end,
}

return Utility
