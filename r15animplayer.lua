local animation = "5847190702"
local getanim = game:GetObjects("rbxassetid://"..animation)[1]
local keyframes = {}
local motors = {}
for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if v.ClassName == "Motor6D" and v.Name ~= "Neck" then
        v.Name = v.Parent.Name
        v.Parent = nil
        table.insert(motors, v)
    end
end
local function getmethod(limbname, maincframe)
    local whattoreturn = CFrame.new(0, 0, 0)
    for i,v in pairs(motors) do
        if limbname == v.Name then
        whattoreturn = v.Part0.CFrame * (v.Part0.CFrame * v.C0 * maincframe * v.C1:inverse()):ToObjectSpace(v.Part0.CFrame):inverse()
       end
    end
    return whattoreturn
end
for i,v in pairs(getanim:GetDescendants()) do
    if v.ClassName == "Keyframe" then
        table.insert(keyframes, v)
    end
end
game.RunService.Heartbeat:connect(function()
    local character = workspace[game.Players.LocalPlayer.Name]
    if character ~= nil then
        character.HumanoidRootPart.CanCollide = false
        for i,v in pairs(character:GetDescendants()) do
            if v.ClassName == "MeshPart" then
                v.Velocity = Vector3.new(100, 100, 100)
                v.CanCollide = false
            end
        end
    end
end)
repeat
for i,v in pairs(keyframes) do
        game.RunService.Heartbeat:wait()
    for i,m in pairs(v:GetDescendants()) do
    if m.ClassName == "Pose" and m.Name ~= "HumanoidRootPart" then
    game.Players.LocalPlayer.Character[m.Name].CFrame = getmethod(m.Name, m.CFrame)
    end
    print(v)
    end
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
