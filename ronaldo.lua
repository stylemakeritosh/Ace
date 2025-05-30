-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Load Knit and StatesController
local Knit = require(ReplicatedStorage.Packages.Knit)
local StatesController = Knit.GetController("StatesController")

-- Player and Character Setup
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- Key System
local correctKey = "RONALDOOO"
local keyVerified = false
local fileName = "ronaldo.txt"

-- File Operations
local function saveKey(key)
    writefile(fileName, key)
end

local function loadKey()
    if isfile(fileName) then
        return readfile(fileName)
    end
    return nil
end

local function deleteKeyFile()
    if isfile(fileName) then
        delfile(fileName)
    end
end

-- Enhanced Loading GUI
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingGui"
loadingGui.Parent = player.PlayerGui
loadingGui.Enabled = false

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 200, 0, 200)
loadingFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.BackgroundTransparency = 0.2
loadingFrame.Parent = loadingGui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 15)
loadingCorner.Parent = loadingFrame

local spinnerOuter = Instance.new("Frame")
spinnerOuter.Size = UDim2.new(0, 80, 0, 80)
spinnerOuter.Position = UDim2.new(0.5, -40, 0.5, -60)
spinnerOuter.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
spinnerOuter.Parent = loadingFrame
local spinnerOuterCorner = Instance.new("UICorner")
spinnerOuterCorner.CornerRadius = UDim.new(1, 0)
spinnerOuterCorner.Parent = spinnerOuter

local spinnerInner = Instance.new("Frame")
spinnerInner.Size = UDim2.new(0, 40, 0, 40)
spinnerInner.Position = UDim2.new(0.5, -20, 0.5, -20)
spinnerInner.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
spinnerInner.Parent = spinnerOuter
local spinnerInnerCorner = Instance.new("UICorner")
spinnerInnerCorner.CornerRadius = UDim.new(1, 0)
spinnerInnerCorner.Parent = spinnerInner

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0, 30)
loadingText.Position = UDim2.new(0, 0, 1, -40)
loadingText.Text = "Loading..."
loadingText.TextColor3 = Color3.fromRGB(255, 0, 0)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 24
loadingText.Parent = loadingFrame

local tweenOuter = TweenService:Create(spinnerOuter, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
local tweenInner = TweenService:Create(spinnerInner, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = -360})

local function animateLoadingText()
    local dots = 0
    while loadingGui.Enabled do
        loadingText.Text = "Loading" .. string.rep(".", dots)
        dots = (dots + 1) % 4
        task.wait(0.5)
    end
end

-- Check Saved Key
local savedKey = loadKey()
local keyOutdated = false
if savedKey then
    if savedKey == correctKey then
        keyVerified = true
    else
        deleteKeyFile()
        keyOutdated = true
    end
end

-- Enhanced Key System UI
if not keyVerified then
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    screenGui.IgnoreGuiInset = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 230)
    frame.Position = UDim2.new(0.5, -150, 0.5, -115)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local frameGradient = Instance.new("UIGradient")
    frameGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))}
    frameGradient.Rotation = 45
    frameGradient.Parent = frame

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 15)
    frameCorner.Parent = frame

    local frameStroke = Instance.new("UIStroke")
    frameStroke.Thickness = 2
    frameStroke.Color = Color3.fromRGB(255, 0, 0)
    frameStroke.Transparency = 0.3
    frameStroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 40)
    title.Text = "Rin System"
    title.TextColor3 = Color3.fromRGB(255, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 24
    title.TextStrokeTransparency = 0.7
    title.Parent = frame

    local instruction = Instance.new("TextLabel")
    instruction.Size = UDim2.new(1, 0, 0, 20)
    instruction.Position = UDim2.new(0, 0, 0, 70)
    instruction.Text = keyOutdated and "Your saved key is outdated. Please get the latest key." or "Enter the key to unlock Ronaldo"
    instruction.TextColor3 = Color3.fromRGB(255, 0, 0)
    instruction.BackgroundTransparency = 1
    instruction.Font = Enum.Font.Gotham
    instruction.TextSize = 14
    instruction.Parent = frame

    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(0.85, 0, 0, 40)
    keyInput.Position = UDim2.new(0.075, 0, 0, 110)
    keyInput.PlaceholderText = "Enter Key Here"
    keyInput.Text = ""
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    keyInput.Font = Enum.Font.GothamSemibold
    keyInput.TextSize = 16
    keyInput.Parent = frame

    local keyInputCorner = Instance.new("UICorner")
    keyInputCorner.CornerRadius = UDim.new(0, 10)
    keyInputCorner.Parent = keyInput

    local keyInputStroke = Instance.new("UIStroke")
    keyInputStroke.Thickness = 1
    keyInputStroke.Color = Color3.fromRGB(255, 0, 0)
    keyInputStroke.Parent = keyInput

    local errorMessage = Instance.new("TextLabel")
    errorMessage.Size = UDim2.new(0.85, 0, 0, 20)
    errorMessage.Position = UDim2.new(0.075, 0, 0, 150)
    errorMessage.Text = ""
    errorMessage.TextColor3 = Color3.fromRGB(255, 0, 0)
    errorMessage.BackgroundTransparency = 1
    errorMessage.Font = Enum.Font.Gotham
    errorMessage.TextSize = 12
    errorMessage.Parent = frame
    errorMessage.Visible = false

    local checkKeyButton = Instance.new("TextButton")
    checkKeyButton.Size = UDim2.new(0.4, 0, 0, 30)
    checkKeyButton.Position = UDim2.new(0.075, 0, 0, 180)
    checkKeyButton.Text = "Verify Key"
    checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkKeyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    checkKeyButton.Font = Enum.Font.GothamBold
    checkKeyButton.TextSize = 14
    checkKeyButton.Parent = frame

    local checkKeyCorner = Instance.new("UICorner")
    checkKeyCorner.CornerRadius = UDim.new(0, 8)
    checkKeyCorner.Parent = checkKeyButton

    local getKeyButton = Instance.new("TextButton")
    getKeyButton.Size = UDim2.new(0.4, 0, 0, 30)
    getKeyButton.Position = UDim2.new(0.525, 0, 0, 180)
    getKeyButton.Text = "Get Key"
    getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    getKeyButton.Font = Enum.Font.GothamBold
    getKeyButton.TextSize = 14
    getKeyButton.Parent = frame

    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 8)
    getKeyCorner.Parent = getKeyButton

    local supportButton = Instance.new("TextButton")
    supportButton.Size = UDim2.new(0, 120, 0, 30)
    supportButton.Position = UDim2.new(0.5, -60, 0, 5)
    supportButton.Text = "Need Support?"
    supportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    supportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    supportButton.Font = Enum.Font.GothamBold
    supportButton.TextSize = 14
    supportButton.Parent = frame

    local supportCorner = Instance.new("UICorner")
    supportCorner.CornerRadius = UDim.new(0, 5)
    supportCorner.Parent = supportButton

    local supportGlow = Instance.new("UIStroke")
    supportGlow.Thickness = 2
    supportGlow.Color = Color3.fromRGB(255, 0, 0)
    supportGlow.Transparency = 0.5
    supportGlow.Parent = supportButton

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.Position = UDim2.new(1, -45, 0, 10)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 18
    closeButton.Parent = frame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeButton

    -- Get Key Frame
    local getKeyFrame = Instance.new("Frame")
    getKeyFrame.Size = UDim2.new(0, 300, 0, 200)
    getKeyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    getKeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    getKeyFrame.BackgroundTransparency = 0.05
    getKeyFrame.BorderSizePixel = 0
    getKeyFrame.Parent = screenGui
    getKeyFrame.Visible = false

    local getKeyFrameGradient = Instance.new("UIGradient")
    getKeyFrameGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))}
    getKeyFrameGradient.Rotation = 45
    getKeyFrameGradient.Parent = getKeyFrame

    local getKeyFrameCorner = Instance.new("UICorner")
    getKeyFrameCorner.CornerRadius = UDim.new(0, 15)
    getKeyFrameCorner.Parent = getKeyFrame

    local getKeyFrameStroke = Instance.new("UIStroke")
    getKeyFrameStroke.Thickness = 2
    getKeyFrameStroke.Color = Color3.fromRGB(255, 0, 0)
    getKeyFrameStroke.Transparency = 0.3
    getKeyFrameStroke.Parent = getKeyFrame

    local getKeyTitle = Instance.new("TextLabel")
    getKeyTitle.Size = UDim2.new(1, 0, 0, 30)
    getKeyTitle.Position = UDim2.new(0, 0, 0, 10)
    getKeyTitle.Text = "Get Key"
    getKeyTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
    getKeyTitle.BackgroundTransparency = 1
    getKeyTitle.Font = Enum.Font.GothamBlack
    getKeyTitle.TextSize = 24
    getKeyTitle.TextStrokeTransparency = 0.7
    getKeyTitle.Parent = getKeyFrame

    local workInkButton = Instance.new("TextButton")
    workInkButton.Size = UDim2.new(0.25, 0, 0, 40)
    workInkButton.Position = UDim2.new(0.05, 0, 0, 80)
    workInkButton.Text = "Work Ink"
    workInkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    workInkButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    workInkButton.Font = Enum.Font.GothamBold
    workInkButton.TextSize = 14
    workInkButton.Parent = getKeyFrame

    local workInkCorner = Instance.new("UICorner")
    workInkCorner.CornerRadius = UDim.new(0, 8)
    workInkCorner.Parent = workInkButton

    local linkvertiseButton = Instance.new("TextButton")
    linkvertiseButton.Size = UDim2.new(0.25, 0, 0, 40)
    linkvertiseButton.Position = UDim2.new(0.375, 0, 0, 80)
    linkvertiseButton.Text = "Linkvertise"
    linkvertiseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    linkvertiseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    linkvertiseButton.Font = Enum.Font.GothamBold
    linkvertiseButton.TextSize = 14
    linkvertiseButton.Parent = getKeyFrame

    local linkvertiseCorner = Instance.new("UICorner")
    linkvertiseCorner.CornerRadius = UDim.new(0, 8)
    linkvertiseCorner.Parent = linkvertiseButton

    local discordButton = Instance.new("TextButton")
    discordButton.Size = UDim2.new(0.25, 0, 0, 40)
    discordButton.Position = UDim2.new(0.375, 0, 0, 130)
    discordButton.Text = "Discord"
    discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    discordButton.Font = Enum.Font.GothamBold
    discordButton.TextSize = 14
    discordButton.Parent = getKeyFrame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 8)
    discordCorner.Parent = discordButton

    local adFocusButton = Instance.new("TextButton")
    adFocusButton.Size = UDim2.new(0.25, 0, 0, 40)
    adFocusButton.Position = UDim2.new(0.7, 0, 0, 80)
    adFocusButton.Text = "AdFocus"
    adFocusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    adFocusButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    adFocusButton.Font = Enum.Font.GothamBold
    adFocusButton.TextSize = 14
    adFocusButton.Parent = getKeyFrame

    local adFocusCorner = Instance.new("UICorner")
    adFocusCorner.CornerRadius = UDim.new(0, 8)
    adFocusCorner.Parent = adFocusButton

    local backButton = Instance.new("TextButton")
    backButton.Size = UDim2.new(0.4, 0, 0, 30)
    backButton.Position = UDim2.new(0.3, 0, 0, 160)
    backButton.Text = "Back"
    backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    backButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    backButton.Font = Enum.Font.GothamBold
    backButton.TextSize = 14
    backButton.Parent = getKeyFrame

    local backCorner = Instance.new("UICorner")
    backCorner.CornerRadius = UDim.new(0, 8)
    backCorner.Parent = backButton

    local function makeDraggable(element)
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(element, tweenInfo, {Position = newPos}):Play()
        end
        element.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = element.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        element.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then update(input) end
        end)
    end

    local function createHoverEffect(button)
        local originalSize = button.Size
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 0),
                Size = originalSize + UDim2.new(0, 10, 0, 10)
            }):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = button.BackgroundColor3,
                Size = originalSize
            }):Play()
        end)
    end

    makeDraggable(frame)
    makeDraggable(getKeyFrame)
    createHoverEffect(checkKeyButton)
    createHoverEffect(getKeyButton)
    createHoverEffect(workInkButton)
    createHoverEffect(linkvertiseButton)
    createHoverEffect(discordButton)
    createHoverEffect(adFocusButton)
    createHoverEffect(backButton)
    createHoverEffect(closeButton)

    supportButton.MouseEnter:Connect(function()
        TweenService:Create(supportButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 255, 0),
            Size = UDim2.new(0, 130, 0, 35)
        }):Play()
        TweenService:Create(supportGlow, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    supportButton.MouseLeave:Connect(function()
        TweenService:Create(supportButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 0, 255),
            Size = UDim2.new(0, 120, 0, 30)
        }):Play()
        TweenService:Create(supportGlow, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)

    checkKeyButton.MouseButton1Click:Connect(function()
        if keyInput.Text == correctKey then
            saveKey(keyInput.Text)
            keyVerified = true
            loadingGui.Enabled = true
            tweenOuter:Play()
            tweenInner:Play()
            task.spawn(animateLoadingText)
            task.delay(4, function()
                loadingGui:Destroy()
            end)
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local tween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
            for _, child in ipairs(frame:GetChildren()) do
                if child:IsA("GuiObject") then
                    TweenService:Create(child, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
                end
            end
            tween:Play()
            tween.Completed:Connect(function()
                screenGui:Destroy()
            end)
        else
            errorMessage.Text = "Incorrect key. Please get the latest key."
            errorMessage.Visible = true
            task.delay(5, function()
                errorMessage.Visible = false
            end)
            game.StarterGui:SetCore("SendNotification", {Title = "Invalid Key", Text = "Please enter the correct key!", Duration = 3})
            local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 2, true)
            TweenService:Create(frame, tweenInfo, {Position = frame.Position + UDim2.new(0, 10, 0, 0)}):Play()
        end
    end)

    getKeyButton.MouseButton1Click:Connect(function()
        frame.Visible = false
        getKeyFrame.Visible = true
    end)

    workInkButton.MouseButton1Click:Connect(function()
        setclipboard("https://workink.net/1Zkc/c5pora3p")
        game.StarterGui:SetCore("SendNotification", {Title = "Link Copied", Text = "Work Ink link copied to clipboard!", Duration = 3})
    end)

    linkvertiseButton.MouseButton1Click:Connect(function()
        setclipboard("https://link-hub.net/1343090/e6EFrzpuVYS2")
        game.StarterGui:SetCore("SendNotification", {Title = "Link Copied", Text = "Linkvertise link copied to clipboard!", Duration = 3})
    end)

    discordButton.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/QG5PHd7mVD")
        game.StarterGui:SetCore("SendNotification", {Title = "Link Copied", Text = "Discord invite link copied to clipboard!", Duration = 3})
    end)

    adFocusButton.MouseButton1Click:Connect(function()
        setclipboard("https://adfoc.us/872092110320640")
        game.StarterGui:SetCore("SendNotification", {Title = "Link Copied", Text = "AdFocus link copied to clipboard!", Duration = 3})
    end)

    backButton.MouseButton1Click:Connect(function()
        getKeyFrame.Visible = false
        frame.Visible = true
    end)

    supportButton.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/QG5PHd7mVD")
        game.StarterGui:SetCore("SendNotification", {Title = "Support Link", Text = "Discord support link copied!", Duration = 3})
    end)

    closeButton.MouseButton1Click:Connect(function()
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local tween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA("GuiObject") then
                TweenService:Create(child, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            end
        end
        if getKeyFrame.Visible then
            for _, child in ipairs(getKeyFrame:GetChildren()) do
                if child:IsA("GuiObject") then
                    TweenService:Create(child, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
                end
            end
            TweenService:Create(getKeyFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
        end
        tween:Play()
        tween.Completed:Connect(function() screenGui:Destroy() end)
    end)
end

while not keyVerified do task.wait() end

if not loadingGui.Enabled then
    loadingGui.Enabled = true
    tweenOuter:Play()
    tweenInner:Play()
    task.spawn(animateLoadingText)
    task.delay(4, function()
        loadingGui:Destroy()
    end)
end

-- Ability Settings
local suiKickEnabled = true
local blitzRushEnabled = true
local wildShotEnabled = true
local quickShiftEnabled = true
local gyroNovaEnabled = true
local royalRelayEnabled = true
local predatorSnatchEnabled = true
local abilityCooldowns = { SuiKick = 5, BlitzRush = 2, WildShot = 5, QuickShift = 2, GyroNova = 10, RoyalRelay = 5, PredatorSnatch = 3 }
local lastUsedTimes = { SuiKick = 0, BlitzRush = 0, WildShot = 0, QuickShift = 0, GyroNova = 0, RoyalRelay = 0, PredatorSnatch = 0 }
local currentVariant = "GyroNova" -- Variable to track current variant

-- Connections for Cleanup
local inputConnection
local heartbeatConnection

-- Teammate Marking System for Royal Relay
local markedTeammate = nil
local markLocked = false

local function getTeammates()
    local teammates = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Team == player.Team then
            table.insert(teammates, plr)
        end
    end
    return teammates
end

RunService.Heartbeat:Connect(function()
    if not markLocked then
        local teammates = getTeammates()
        local closestTeammate = nil
        local minDistance = math.huge
        for _, teammate in ipairs(teammates) do
            local char = teammate.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local viewportPoint, onScreen = camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local screenPos = Vector2.new(viewportPoint.X, viewportPoint.Y)
                    local center = camera.ViewportSize / 2
                    local distance = (screenPos - center).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                        closestTeammate = teammate
                    end
                end
            end
        end
        markedTeammate = closestTeammate
    end
end)

-- Sui Kick Animation and Sound
local suiKickAnimation = Instance.new("Animation")
suiKickAnimation.AnimationId = "rbxassetid://18679009688"
local suiKickAnimationTrack = humanoid:LoadAnimation(suiKickAnimation)
suiKickAnimationTrack.Looped = false

local suiKickAnimation2 = Instance.new("Animation")
suiKickAnimation2.AnimationId = "rbxassetid://118398458393139"
local suiKickAnimationTrack2 = humanoid:LoadAnimation(suiKickAnimation2)
suiKickAnimationTrack2.Looped = false

local suiKickSound = Instance.new("Sound")
suiKickSound.SoundId = "rbxassetid://9119594880"
suiKickSound.Volume = 5
suiKickSound.Parent = humanoidRootPart

local suiKickShootSound = Instance.new("Sound")
suiKickShootSound.SoundId = "rbxassetid://156572165"
suiKickShootSound.Volume = 3
suiKickShootSound.Parent = humanoidRootPart

-- Blitz Rush Animation and Sound
local blitzRushAnimation = Instance.new("Animation")
blitzRushAnimation.AnimationId = "rbxassetid://76950247429784"
local blitzRushAnimationTrack = humanoid:LoadAnimation(blitzRushAnimation)
blitzRushAnimationTrack.Looped = false

local blitzRushSound = Instance.new("Sound")
blitzRushSound.SoundId = "rbxassetid://5989939664"
blitzRushSound.Volume = 3
blitzRushSound.Parent = humanoidRootPart

-- Wild Shot Animation and Sound
local wildShotAnimation = Instance.new("Animation")
wildShotAnimation.AnimationId = "rbxassetid://118398458393139"
local wildShotAnimationTrack = humanoid:LoadAnimation(wildShotAnimation)
wildShotAnimationTrack.Looped = false

local wildShotSound = Instance.new("Sound")
wildShotSound.SoundId = "rbxassetid://86189574144865"
wildShotSound.Volume = 3
wildShotSound.Parent = humanoidRootPart

-- Quick Shift Animation and Sound
local quickShiftAnimation1 = Instance.new("Animation")
quickShiftAnimation1.AnimationId = "rbxassetid://92816903497495"
local quickShiftAnimationTrack1 = humanoid:LoadAnimation(quickShiftAnimation1)
quickShiftAnimationTrack1.Looped = false

local quickShiftAnimation2 = Instance.new("Animation")
quickShiftAnimation2.AnimationId = "rbxassetid://121503438555116"
local quickShiftAnimationTrack2 = humanoid:LoadAnimation(quickShiftAnimation2)
quickShiftAnimationTrack2.Looped = false

local quickShiftSound = Instance.new("Sound")
quickShiftSound.SoundId = "rbxassetid://6874043782"
quickShiftSound.Volume = 5
quickShiftSound.Parent = humanoidRootPart

-- Gyro Nova Animation and Sounds
local gyroNovaAnimation = Instance.new("Animation")
gyroNovaAnimation.AnimationId = "rbxassetid://84377108321213"
local gyroNovaAnimationTrack = humanoid:LoadAnimation(gyroNovaAnimation)
gyroNovaAnimationTrack.Looped = false

local upSound = Instance.new("Sound")
upSound.SoundId = "rbxassetid://7514417921"
upSound.Volume = 5
upSound.Parent = humanoidRootPart

local moveSoundTemplate = Instance.new("Sound")
moveSoundTemplate.SoundId = "rbxassetid://3077287610"
moveSoundTemplate.Volume = 5

local finalSoundTemplate = Instance.new("Sound")
finalSoundTemplate.SoundId = "rbxassetid://18635283528"
finalSoundTemplate.Volume = 5

-- Bang Drive Animation and Sounds
local bangDriveAnimation = Instance.new("Animation")
bangDriveAnimation.AnimationId = "rbxassetid://133213936644960"
local bangDriveAnimationTrack = humanoid:LoadAnimation(bangDriveAnimation)
bangDriveAnimationTrack.Looped = false

-- Royal Relay Animation and Sounds
local royalRelayAnimation = Instance.new("Animation")
royalRelayAnimation.AnimationId = "rbxassetid://70640343048614"
local royalRelayAnimationTrack = humanoid:LoadAnimation(royalRelayAnimation)
royalRelayAnimationTrack.Looped = false

local royalRelaySound1 = Instance.new("Sound")
royalRelaySound1.SoundId = "rbxassetid://75364604862973"
royalRelaySound1.Volume = 2
royalRelaySound1.Parent = humanoidRootPart

local royalRelaySound2 = Instance.new("Sound")
royalRelaySound2.SoundId = "rbxassetid://1837831424"
royalRelaySound2.Volume = 3
royalRelaySound2.Parent = humanoidRootPart

-- Predator Snatch Animation and Sounds (Same as Crash In)
local predatorSnatchAnimation = Instance.new("Animation")
predatorSnatchAnimation.AnimationId = "rbxassetid://83474010887370"
local predatorSnatchAnimationTrack = humanoid:LoadAnimation(predatorSnatchAnimation)
predatorSnatchAnimationTrack.Looped = false

local predatorSnatchSound1 = Instance.new("Sound")
predatorSnatchSound1.SoundId = "rbxassetid://116704562284891"
predatorSnatchSound1.Volume = 3
predatorSnatchSound1.Parent = humanoidRootPart

local predatorSnatchSound2 = Instance.new("Sound")
predatorSnatchSound2.SoundId = "rbxassetid://72014632956520"
predatorSnatchSound2.Volume = 3
predatorSnatchSound2.Parent = humanoidRootPart

-- Utility Functions
local function findBall()
    local football = workspace:FindFirstChild("Football")
    if football then
        local ballPart = (football:FindFirstChild("BallAnims") and football.BallAnims:FindFirstChild("BALL")) or football:FindFirstChild("BALL")
        if ballPart then return ballPart end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local ballInChar = plr.Character:FindFirstChild("BALL")
            if ballInChar then return ballInChar end
        end
    end
    return nil
end

local function waitForBallShot(maxWaitTime)
    local startTime = tick()
    while tick() - startTime < maxWaitTime do
        local ball = findBall()
        if ball and ball.Velocity.Magnitude > 10 then
            return true
        end
        task.wait()
    end
    return false
end

local function displayTextAboveCharacter(text)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 150, 0, 40)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = character:FindFirstChild("Head")

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 16
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Parent = billboardGui

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0}):Play()

    task.delay(2, function()
        TweenService:Create(textLabel, tweenInfo, {TextTransparency = 1}):Play()
        task.wait(0.5)
        billboardGui:Destroy()
    end)
    return billboardGui
end

local abilityLines = {
    "I’m not here to please anyone, just to win.",
    "You can’t catch me, I’m too fast.",
    "They pass, I score.",
    "Second place? a place for losers.",
    "goku vs me?, is that a joke?",
    "I don’t compete with others, I compete with myself.",
    "Suiii!!!",
    "I’m the king, the rest are pawns.",
    "Keep doubting, I’ll keep winning.",
    "They try, but they can’t match my level.",
    "Try harder, you’re still behind me.",
    "I don’t follow records; records follow me.",
    "Haters? Just noise in my victory parade.",
    "I’m the one they all chase.",
    "You talk..... i kill"
}

-- Load NongkhawKawaii UI Library
local Env = loadstring(game:HttpGet("https://raw.githubusercontent.com/MerrySubs4t/96soul/refs/heads/main/Utilities/NongkhawKawaii-UI.luau", true))()
local __Class, translate, Configs, Funcs, Default = table.unpack(loadstring(game:HttpGet("https://raw.githubusercontent.com/MerrySubs4t/96soul/refs/heads/main/Utilities/Compiler.inc", true))())
local Window = Env:Window({Title = translate("Souls Hub", "น้องข้าว"), Desc = translate("Ronaldo", "โปรเจกต์")})

local Banners = {
    ['Genral'] = 101849161408766,
    ['Auto'] = 110162136250435,
    ['Setting'] = 72210587662292,
    ['Misc'] = 84034775913393,
    ['Items'] = 98574803492996,
    ['Shop'] = 74630923244478,
    ['Teleport'] = 137847566773112,
    ['Visual'] = 123257335719276,
    ['Combat'] = 112935442242481,
    ['Update'] = 86844430363710,
}

local function Add(Title, Desc, Banner)
    return Window:Add({Title = Title, Desc = Desc, Banner = Banners and Banners[Banner]})
end

local function Section(Adds, Title, Side)
    return Adds:Section({Title = Title, Side = Side})
end

local function Button(Sec, Title, Desc, Icon, Callback)
    if Icon and Desc then
        return Sec:Button({Title = Title, Desc = Desc, Icon = Icon, Callback = Callback})
    else
        return Sec:Button({Title = Title, Callback = Callback})
    end
end

local function Toggle(Sec, Title, Desc, Icon, SettingName, Callback)
    local tasks
    local function runCallback(value)
        Configs[SettingName] = value
        if value then
            tasks = task.spawn(function()
                if Funcs[SettingName] then
                    Funcs[SettingName](Configs[SettingName])
                end
            end)
        elseif not value and tasks then
            task.cancel(tasks)
        end
        __Class:Save(SettingName, value)
        if Callback then Callback(value) end
    end

    local props = {
        Title = Title,
        Desc = Desc,
        Value = Configs[SettingName],
        Callback = runCallback
    }

    if Icon then
        props.Icon = Icon
    end

    return Sec:Toggle(props)
end

local function Textbox(Sec, Setting, Placeholder, ClearOnFocus)
    return Sec:Textbox({
        Value = Configs[Setting],
        PlaceHolder = Placeholder,
        ClearOnFocus = ClearOnFocus,
        Callback = function(v)
            Configs[Setting] = v
            __Class:Save(Setting, v)
        end
    })
end

local function Slider(Sec, Title, Min, Max, Setting, Rounding)
    return Sec:Slider({
        Title = Title,
        Min = Min,
        Max = Max,
        Value = Configs[Setting],
        Rounding = Rounding,
        CallBack = function(v)
            Configs[Setting] = v
            __Class:Save(Setting, v)
        end
    })
end

local function Dropdown(Sec, Title, Multi, List, Setting)
    return Sec:Dropdown({
        Title = Title,
        Multi = Multi,
        List = List,
        Value = Configs[Setting],
        Callback = function(v)
            Configs[Setting] = v
            __Class:Save(Setting, v)
        end
    })
end

-- Create Abilities Tab
local AbilitiesTab = Add("Abilities", "Ability Controls", "Combat")
local AbilitiesSection = Section(AbilitiesTab, "Ability Controls", "l")

-- Add Toggles for Abilities
Toggle(AbilitiesSection, "Sui Kick", "Toggle Sui Kick ability", nil, "SuiKickEnabled", function(value)
    suiKickEnabled = value
end)

Toggle(AbilitiesSection, "Blitz Rush", "Toggle Blitz Rush ability", nil, "BlitzRushEnabled", function(value)
    blitzRushEnabled = value
end)

Toggle(AbilitiesSection, "Wild Shot", "Toggle Wild Shot ability", nil, "WildShotEnabled", function(value)
    wildShotEnabled = value
end)

Toggle(AbilitiesSection, "Quick Shift", "Toggle Quick Shift ability", nil, "QuickShiftEnabled", function(value)
    quickShiftEnabled = value
end)

Toggle(AbilitiesSection, "Gyro Nova", "Toggle Gyro Nova ability", nil, "GyroNovaEnabled", function(value)
    gyroNovaEnabled = value
end)

Toggle(AbilitiesSection, "Royal Relay", "Toggle Royal Relay ability", nil, "RoyalRelayEnabled", function(value)
    royalRelayEnabled = value
end)

Toggle(AbilitiesSection, "Predator Snatch", "Toggle Predator Snatch ability", nil, "PredatorSnatchEnabled", function(value)
    predatorSnatchEnabled = value
end)

-- Function to Add Cooldown Overlay to Buttons
local function addCooldownOverlay(button)
    local cooldownOverlay = Instance.new("Frame")
    cooldownOverlay.Name = "CooldownOverlay"
    cooldownOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cooldownOverlay.BackgroundTransparency = 0.5
    cooldownOverlay.BorderSizePixel = 0
    cooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
    cooldownOverlay.Position = UDim2.new(0, 0, 0, 0)
    cooldownOverlay.AnchorPoint = Vector2.new(0, 0)
    cooldownOverlay.ZIndex = 10
    cooldownOverlay.Parent = button
end

-- Ability Functions
local function performSuiKick()
    if not suiKickEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.SuiKick < abilityCooldowns.SuiKick then
        warn("Sui Kick on cooldown!")
        return
    end

    local airTime = 1
    local shootDelay = 0.2
    local ballCheckTime = 0.6

    suiKickAnimationTrack:Play()

    local originalPosition = humanoidRootPart.Position
    local targetUpPosition = originalPosition + Vector3.new(0, 13, 0)

    local alignPos = Instance.new("AlignPosition")
    alignPos.MaxForce = 10000
    alignPos.Responsiveness = 50
    alignPos.Parent = humanoidRootPart
    local attachment = Instance.new("Attachment")
    attachment.Parent = humanoidRootPart
    alignPos.Attachment0 = attachment
    local targetAttachment = Instance.new("Attachment")
    targetAttachment.Position = targetUpPosition
    targetAttachment.Parent = workspace.Terrain
    alignPos.Attachment1 = targetAttachment

    local alignOri = Instance.new("AlignOrientation")
    alignOri.MaxTorque = 10000
    alignOri.Responsiveness = 200
    alignOri.Attachment0 = attachment
    local camLook = camera.CFrame.LookVector
    local lookVector = Vector3.new(-camLook.X, 0, -camLook.Z).Unit
    local yAxis = -Vector3.yAxis
    local zAxis = -lookVector
    local xAxis = yAxis:Cross(zAxis).Unit
    local desiredOrientation = CFrame.fromMatrix(Vector3.new(0, 0, 0), xAxis, yAxis, zAxis)
    alignOri.CFrame = desiredOrientation
    alignOri.Parent = humanoidRootPart

    task.delay(airTime, function()
        targetAttachment.Position = originalPosition
        task.wait(0.5)
        alignPos:Destroy()
        alignOri:Destroy()
        attachment:Destroy()
        targetAttachment:Destroy()
        suiKickAnimationTrack2:Stop()
    end)

    task.wait(shootDelay)

    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Shoot:FireServer(50)
    suiKickSound:Play()
    suiKickShootSound:Play()

    local randomLine = abilityLines[math.random(1, #abilityLines)]
    local textGui = displayTextAboveCharacter(randomLine)

    if waitForBallShot(ballCheckTime) then
        lastUsedTimes.SuiKick = currentTime
        local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
        if rightFoot then
            for i = 1, 2 do
                local vfx1 = game.ReplicatedStorage.Effects.BeinschussCutscene.CutsceneVFX.AryuSmash.Attachment:Clone()
                vfx1.Parent = rightFoot
                for _, child in ipairs(vfx1:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 3
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(20)
                        child.Enabled = true
                    end
                end
                task.delay(0.5, function()
                    for _, child in ipairs(vfx1:GetChildren()) do
                        if child:IsA("ParticleEmitter") then child.Enabled = false end
                    end
                    vfx1:Destroy()
                end)

                local vfx2 = game.ReplicatedStorage.Effects.MagnusCutscene.CutsceneVFX.Root.emit:Clone()
                vfx2.Parent = rightFoot
                for _, child in ipairs(vfx2:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 3
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(20)
                        child.Enabled = true
                    end
                end
                task.delay(0.5, function()
                    for _, child in ipairs(vfx2:GetChildren()) do
                        if child:IsA("ParticleEmitter") then child.Enabled = false end
                    end
                    vfx2:Destroy()
                end)
            end
        end

        local ball = findBall()
        if ball then
            local direction = -camera.CFrame.LookVector.Unit
            local speed = 200
            local duration = 1.5
            local initialBallPos = ball.Position

            for _, child in ipairs(ball:GetChildren()) do
                if child:IsA("AlignPosition") then child:Destroy() end
            end

            local alignPosBall = Instance.new("AlignPosition")
            alignPosBall.MaxForce = 10000
            alignPosBall.Responsiveness = 250
            alignPosBall.Parent = ball
            local attachmentBall = Instance.new("Attachment")
            attachmentBall.Parent = ball
            alignPosBall.Attachment0 = attachmentBall
            local targetAttachmentBall = Instance.new("Attachment")
            targetAttachmentBall.Parent = workspace.Terrain
            alignPosBall.Attachment1 = targetAttachmentBall

            local ballVFXList = {
                game.ReplicatedStorage.Effects.NELRin.DestructiveCrashShotFX.VFX.ChargeKick.Attachment,
                game.ReplicatedStorage.Effects.NELRin.ANewToy.Environment.BallFX.w.VFX,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment
            }
            for _, vfxTemplate in ipairs(ballVFXList) do
                local vfx = vfxTemplate:Clone()
                vfx.Parent = ball
                for _, child in ipairs(vfx:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 12
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(40)
                        child.Enabled = true
                    end
                end
                Debris:AddItem(vfx, 2.5)
            end

            local startTime = tick()
            local ballConnection
            ballConnection = RunService.Heartbeat:Connect(function()
                local elapsed = tick() - startTime
                if elapsed >= duration then
                    ballConnection:Disconnect()
                    alignPosBall:Destroy()
                    attachmentBall:Destroy()
                    targetAttachmentBall:Destroy()
                    if textGui then textGui:Destroy() end
                else
                    local targetPos = initialBallPos + direction * speed * elapsed
                    targetAttachmentBall.Position = targetPos
                end
            end)
        end
    else
        warn("Ball not shot within time limit")
    end
end

local function performBlitzRush()
    if not blitzRushEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.BlitzRush < abilityCooldowns.BlitzRush then
        warn("Blitz Rush on cooldown!")
        return
    end
    lastUsedTimes.BlitzRush = currentTime

    local ball = findBall()
    local targetDirection = humanoidRootPart.CFrame.LookVector
    if ball then
        local ballPosition = ball.Position
        local playerPosition = humanoidRootPart.Position
        local toBall = ballPosition - playerPosition
        local distance = toBall.Magnitude
        if distance <= 25 then
            targetDirection = toBall.Unit
        end
    end
    local targetPosition = humanoidRootPart.Position + targetDirection * 25

    local alignPos = Instance.new("AlignPosition")
    alignPos.MaxForce = 20000
    alignPos.Responsiveness = 200
    alignPos.Parent = humanoidRootPart
    local attachment = Instance.new("Attachment")
    attachment.Parent = humanoidRootPart
    alignPos.Attachment0 = attachment
    local targetAttachment = Instance.new("Attachment")
    targetAttachment.Position = targetPosition
    targetAttachment.Parent = workspace.Terrain
    alignPos.Attachment1 = targetAttachment

    blitzRushAnimationTrack:Play()
    blitzRushSound:Play()

    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Slide:FireServer()

    local vfxList = {
        game.ReplicatedStorage.Effects.CrowTheft.RunningFX.Attachment,
        game.ReplicatedStorage.Assets.Vfx.ChigiriRun.Attachment,
        game.ReplicatedStorage.Assets.Vfx.KingsDribble.RunPlr.Attachment,
        game.ReplicatedStorage.Effects.NELRin.DestructionDribble.SmokeRun.Attachment
    }
    local attachedVFX = {}
    for _, vfxTemplate in ipairs(vfxList) do
        local vfx = vfxTemplate:Clone()
        vfx.Parent = humanoidRootPart
        for _, child in ipairs(vfx:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                })
                child.Rate = child.Rate * 2
                child.Lifetime = NumberRange.new(child.Lifetime.Min * 1, child.Lifetime.Max * 2)
                child.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 3),
                    NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 3)
                })
                child:Emit(50)
                child.Enabled = true
            end
        end
        table.insert(attachedVFX, vfx)
    end

    task.delay(0.15, function()
        ReplicatedStorage.Packages.Knit.Services.BallService.RE.Slide:FireServer()
    end)

    task.wait(0.3)

    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Slide:FireServer()

    alignPos:Destroy()
    attachment:Destroy()
    targetAttachment:Destroy()
    for _, vfx in ipairs(attachedVFX) do
        for _, child in ipairs(vfx:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false
            end
        end
        Debris:AddItem(vfx, 2)
    end

    local randomLine = abilityLines[math.random(1, #abilityLines)]
    displayTextAboveCharacter(randomLine)
end

local function performWildShot()
    if not wildShotEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.WildShot < abilityCooldowns.WildShot then
        warn("Wild Shot on cooldown!")
        return
    end

    wildShotAnimationTrack:Play()
    wildShotSound:Play()
    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Shoot:FireServer(50)

    if waitForBallShot(0.6) then
        lastUsedTimes.WildShot = currentTime
        local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
        if rightFoot then
            for i = 1, 2 do
                local vfx1 = game.ReplicatedStorage.Effects.BeinschussCutscene.CutsceneVFX.AryuSmash.Attachment:Clone()
                vfx1.Parent = rightFoot
                for _, child in ipairs(vfx1:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 3
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(20)
                        child.Enabled = true
                    end
                end
                task.delay(0.5, function()
                    for _, child in ipairs(vfx1:GetChildren()) do
                        if child:IsA("ParticleEmitter") then child.Enabled = false end
                    end
                    vfx1:Destroy()
                end)

                local vfx2 = game.ReplicatedStorage.Effects.MagnusCutscene.CutsceneVFX.Root.emit:Clone()
                vfx2.Parent = rightFoot
                for _, child in ipairs(vfx2:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 3
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(20)
                        child.Enabled = true
                    end
                end
                task.delay(0.5, function()
                    for _, child in ipairs(vfx2:GetChildren()) do
                        if child:IsA("ParticleEmitter") then child.Enabled = false end
                    end
                    vfx2:Destroy()
                end)
            end
        end

        local ball = findBall()
        if ball then
            local P0 = ball.Position
            local D = camera.CFrame.LookVector.Unit
            local P2 = P0 + D * 800
            local P1 = P0 + D * 66 + Vector3.new(0, 5, 0)

            for _, child in ipairs(ball:GetChildren()) do
                if child:IsA("AlignPosition") then child:Destroy() end
            end

            local alignPos = Instance.new("AlignPosition")
            alignPos.MaxForce = 10000
            alignPos.Responsiveness = 250
            alignPos.Parent = ball
            local attachment = Instance.new("Attachment")
            attachment.Parent = ball
            alignPos.Attachment0 = attachment
            local targetAttachment = Instance.new("Attachment")
            targetAttachment.Parent = workspace.Terrain
            alignPos.Attachment1 = targetAttachment

            local ballVFXList = {
                game.ReplicatedStorage.Effects.NELRin.DestructiveCrashShotFX.VFX.ChargeKick.Attachment,
                game.ReplicatedStorage.Effects.NELRin.ANewToy.Environment.BallFX.w.VFX,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment
            }
            for _, vfxTemplate in ipairs(ballVFXList) do
                local vfx = vfxTemplate:Clone()
                vfx.Parent = ball
                for _, child in ipairs(vfx:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 6
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(30)
                        child.Enabled = true
                    end
                end
                Debris:AddItem(vfx, 3.5)
            end

            local startTime = tick()
            local T = 1

            local connection
            connection = RunService.Heartbeat:Connect(function()
                local elapsed = tick() - startTime
                local t = elapsed / T
                if t >= 1 then
                    t = 1
                    connection:Disconnect()
                    alignPos:Destroy()
                    attachment:Destroy()
                    targetAttachment:Destroy()
                else
                    local pos = (1 - t)^2 * P0 + 2 * (1 - t) * t * P1 + t^2 * P2
                    targetAttachment.Position = pos
                end
            end)
        end
    else
        warn("Ball not shot within time limit")
    end

    local randomLine = abilityLines[math.random(1, #abilityLines)]
    displayTextAboveCharacter(randomLine)
end

local function performQuickShift()
    if not quickShiftEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.QuickShift < abilityCooldowns.QuickShift then
        warn("Quick Shift on cooldown!")
        return
    end
    lastUsedTimes.QuickShift = currentTime

    quickShiftAnimationTrack1:Play()
    quickShiftAnimationTrack2:Play()
    quickShiftSound:Play()

    local initialCFrame = humanoidRootPart.CFrame
    local dashAngles = {45, -45, -90, -45}
    local dashDistance = 20
    local dashDuration = 0.2

    local vfxList = {
        game.ReplicatedStorage.Effects.CrowTheft.RunningFX.Attachment,
        game.ReplicatedStorage.Assets.Vfx.ChigiriRun.Attachment,
        game.ReplicatedStorage.Assets.Vfx.KingsDribble.RunPlr.Attachment,
        game.ReplicatedStorage.Effects.NELRin.DestructionDribble.SmokeRun.Attachment
    }
    local attachedVFX = {}
    for _, vfxTemplate in ipairs(vfxList) do
        local vfx = vfxTemplate:Clone()
        vfx.Parent = humanoidRootPart
        for _, child in ipairs(vfx:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                })
                child.Rate = child.Rate * 3
                child.Lifetime = NumberRange.new(child.Lifetime.Min * 6, child.Lifetime.Max * 6)
                child.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 3),
                    NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 3)
                })
                child.Enabled = true
            end
        end
        table.insert(attachedVFX, vfx)
    end

    for i, angle in ipairs(dashAngles) do
        local direction = (initialCFrame * CFrame.Angles(0, math.rad(angle), 0)).LookVector
        local targetPosition = humanoidRootPart.Position + direction * dashDistance

        local alignPos = Instance.new("AlignPosition")
        alignPos.MaxForce = 15000
        alignPos.Responsiveness = 150
        alignPos.Parent = humanoidRootPart
        local attachment = Instance.new("Attachment")
        attachment.Parent = humanoidRootPart
        alignPos.Attachment0 = attachment
        local targetAttachment = Instance.new("Attachment")
        targetAttachment.Position = targetPosition
        targetAttachment.Parent = workspace.Terrain
        alignPos.Attachment1 = targetAttachment

        task.wait(dashDuration)

        alignPos:Destroy()
        attachment:Destroy()
        targetAttachment:Destroy()
    end

    for _, vfx in ipairs(attachedVFX) do
        for _, child in ipairs(vfx:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false
            end
        end
        Debris:AddItem(vfx, 2)
    end

    local randomLine = abilityLines[math.random(1, #abilityLines)]
    displayTextAboveCharacter(randomLine)
end

local function performGyroNova()
    if not gyroNovaEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.GyroNova < abilityCooldowns.GyroNova then
        warn("Gyro Nova on cooldown!")
        return
    end
    lastUsedTimes.GyroNova = currentTime

    upSound:Play()

    local originalPosition = humanoidRootPart.Position
    local targetUpPosition = originalPosition + Vector3.new(0, 28, 0)
    local alignPos = Instance.new("AlignPosition")
    alignPos.MaxForce = 10000
    alignPos.Responsiveness = 50
    alignPos.Parent = humanoidRootPart
    local attachment = Instance.new("Attachment")
    attachment.Parent = humanoidRootPart
    alignPos.Attachment0 = attachment
    local targetAttachment = Instance.new("Attachment")
    targetAttachment.Position = targetUpPosition
    targetAttachment.Parent = workspace.Terrain
    alignPos.Attachment1 = targetAttachment

    gyroNovaAnimationTrack:Play()

    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Shoot:FireServer(50)

    if waitForBallShot(0.6) then
        local ball = findBall()
        if ball then
            local ballVFXList = {
                game.ReplicatedStorage.Effects.NELRin.DestructiveCrashShotFX.VFX.ChargeKick.Attachment,
                game.ReplicatedStorage.Effects.NELRin.ANewToy.Environment.BallFX.w.VFX,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment
            }
            local attachedBallVFX = {}
            for _, vfxTemplate in ipairs(ballVFXList) do
                local vfx = vfxTemplate:Clone()
                vfx.Parent = ball
                for _, child in ipairs(vfx:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 6
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(30)
                        child.Enabled = true
                    end
                end
                table.insert(attachedBallVFX, vfx)
            end

            for i = 1, 6 do
                task.delay(i - 1, function()
                    local localOffset = Vector3.new(math.random(-5, 5), math.random(-2, 2), -30)
                    local worldOffset = humanoidRootPart.CFrame:VectorToWorldSpace(localOffset)
                    local randomPosition = humanoidRootPart.Position + worldOffset

                    local ballAlignPos = Instance.new("AlignPosition")
                    ballAlignPos.MaxForce = 10000
                    ballAlignPos.Responsiveness = 200
                    ballAlignPos.Parent = ball
                    local ballAttachment = Instance.new("Attachment")
                    ballAttachment.Parent = ball
                    ballAlignPos.Attachment0 = ballAttachment
                    local ballTargetAttachment = Instance.new("Attachment")
                    ballTargetAttachment.Position = randomPosition
                    ballTargetAttachment.Parent = workspace.Terrain
                    ballAlignPos.Attachment1 = ballTargetAttachment

                    local moveSound = moveSoundTemplate:Clone()
                    moveSound.Parent = ball
                    moveSound:Play()

                    task.delay(1, function()
                        ballAlignPos:Destroy()
                        ballAttachment:Destroy()
                        ballTargetAttachment:Destroy()
                        moveSound:Destroy()
                    end)
                end)
            end

            task.delay(6, function()
                local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
                if rightFoot then
                    local frontDirection = humanoidRootPart.CFrame.LookVector
                    local nearFootPosition = rightFoot.Position + frontDirection * 12

                    local ballAlignPos = Instance.new("AlignPosition")
                    ballAlignPos.MaxForce = 10000
                    ballAlignPos.Responsiveness = 200
                    ballAlignPos.Parent = ball
                    local ballAttachment = Instance.new("Attachment")
                    ballAttachment.Parent = ball
                    ballAlignPos.Attachment0 = ballAttachment
                    local ballTargetAttachment = Instance.new("Attachment")
                    ballTargetAttachment.Position = nearFootPosition
                    ballTargetAttachment.Parent = workspace.Terrain
                    ballAlignPos.Attachment1 = ballTargetAttachment

                    task.delay(0.5, function()
                        ballAlignPos:Destroy()
                        ballAttachment:Destroy()
                        ballTargetAttachment:Destroy()
                    end)
                end
            end)

            task.delay(6.5, function()
                local aimDirection = camera.CFrame.LookVector
                local speed = 500
                local duration = 2
                local startTime = tick()
                local initialBallPos = ball.Position

                local ballAlignPos = Instance.new("AlignPosition")
                ballAlignPos.MaxForce = 10000
                ballAlignPos.Responsiveness = 200
                ballAlignPos.Parent = ball
                local ballAttachment = Instance.new("Attachment")
                ballAttachment.Parent = ball
                ballAlignPos.Attachment0 = ballAttachment
                local ballTargetAttachment = Instance.new("Attachment")
                ballTargetAttachment.Parent = workspace.Terrain
                ballAlignPos.Attachment1 = ballTargetAttachment

                local finalSound = finalSoundTemplate:Clone()
                finalSound.Parent = ball
                finalSound:Play()

                local ballConnection
                ballConnection = RunService.Heartbeat:Connect(function()
                    local elapsed = tick() - startTime
                    if elapsed >= duration then
                        ballConnection:Disconnect()
                        ballAlignPos:Destroy()
                        ballAttachment:Destroy()
                        ballTargetAttachment:Destroy()
                        finalSound:Destroy()
                        for _, vfx in ipairs(attachedBallVFX) do
                            vfx:Destroy()
                        end
                    else
                        local targetPos = initialBallPos + aimDirection * speed * elapsed
                        ballTargetAttachment.Position = targetPos
                    end
                end)
            end)
        end
    end

    task.delay(8.5, function()
        targetAttachment.Position = originalPosition
        task.wait(0.5)
        alignPos:Destroy()
        attachment:Destroy()
        targetAttachment:Destroy()
        gyroNovaAnimationTrack:Stop()
    end)
end

local function performBangDrive()
    if not gyroNovaEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.GyroNova < abilityCooldowns.GyroNova then
        warn("Bang Drive on cooldown!")
        return
    end
    lastUsedTimes.GyroNova = currentTime

    bangDriveAnimationTrack:Play()

    task.wait(5)

    local upSoundBang = Instance.new("Sound")
    upSoundBang.SoundId = "rbxassetid://7970264045"
    upSoundBang.Volume = 5
    upSoundBang.Parent = humanoidRootPart
    upSoundBang:Play()

    local originalPosition = humanoidRootPart.Position
    local targetUpPosition = originalPosition + Vector3.new(0, 26, 0)
    local alignPos = Instance.new("AlignPosition")
    alignPos.MaxForce = 10000
    alignPos.Responsiveness = 50
    alignPos.Parent = humanoidRootPart
    local attachment = Instance.new("Attachment")
    attachment.Parent = humanoidRootPart
    alignPos.Attachment0 = attachment
    local targetAttachment = Instance.new("Attachment")
    targetAttachment.Position = targetUpPosition
    targetAttachment.Parent = workspace.Terrain
    alignPos.Attachment1 = targetAttachment

    local alignOri = Instance.new("AlignOrientation")
    alignOri.MaxTorque = 10000
    alignOri.Responsiveness = 200
    alignOri.Parent = humanoidRootPart
    alignOri.Attachment0 = attachment
    local desiredCFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.pi, 0)
    alignOri.CFrame = desiredCFrame

    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Shoot:FireServer(50)

    if waitForBallShot(0.6) then
        local ball = findBall()
        if ball then
            local ballVFXList = {
                game.ReplicatedStorage.Effects.NELRin.DestructiveCrashShotFX.VFX.ChargeKick.Attachment,
                game.ReplicatedStorage.Effects.NELRin.ANewToy.Environment.BallFX.w.VFX,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment
            }
            local attachedBallVFX = {}
            for _, vfxTemplate in ipairs(ballVFXList) do
                local vfx = vfxTemplate:Clone()
                vfx.Parent = ball
                for _, child in ipairs(vfx:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 6
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(30)
                        child.Enabled = true
                    end
                end
                table.insert(attachedBallVFX, vfx)
            end

            local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
            if rightFoot then
                local ballAlignPos = Instance.new("AlignPosition")
                ballAlignPos.MaxForce = 10000
                ballAlignPos.Responsiveness = 200
                ballAlignPos.Parent = ball
                local ballAttachment = Instance.new("Attachment")
                ballAttachment.Parent = ball
                ballAlignPos.Attachment0 = ballAttachment
                local ballTargetAttachment = Instance.new("Attachment")
                ballTargetAttachment.Parent = workspace.Terrain
                ballAlignPos.Attachment1 = ballTargetAttachment

                local controlDuration = 4
                local startTime = tick()
                while tick() - startTime < controlDuration do
                    local frontDirection = humanoidRootPart.CFrame.LookVector
                    local pausePosition = rightFoot.Position + frontDirection * 6
                    ballTargetAttachment.Position = pausePosition
                    task.wait()
                end

                task.delay(2, function()
                    targetAttachment.Position = originalPosition
                end)

                local fastControlSound = Instance.new("Sound")
                fastControlSound.SoundId = "rbxassetid://121534347094974"
                fastControlSound.Volume = 5
                fastControlSound.Parent = ball
                fastControlSound:Play()

                local characterVFXList = {
                    game.ReplicatedStorage.Effects.BeinschussCutscene.CutsceneVFX.AryuSmash.Attachment,
                    game.ReplicatedStorage.Effects.MagnusCutscene.CutsceneVFX.Root.emit
                }
                local attachedCharacterVFX = {}
                for _, vfxTemplate in ipairs(characterVFXList) do
                    local vfx = vfxTemplate:Clone()
                    vfx.Parent = rightFoot
                    for _, child in ipairs(vfx:GetChildren()) do
                        if child:IsA("ParticleEmitter") then
                            child.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                            })
                            child.Rate = child.Rate * 3
                            child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                            child.Size = NumberSequence.new({
                                NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                                NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                            })
                            child:Emit(20)
                            child.Enabled = true
                        end
                    end
                    table.insert(attachedCharacterVFX, vfx)
                end

                ballAlignPos:Destroy()
                ballAttachment:Destroy()
                ballTargetAttachment:Destroy()

                local aimDirection = camera.CFrame.LookVector
                local speed = 500
                local duration = 2
                local shootStartTime = tick()
                local initialBallPos = ball.Position

                local shootAlignPos = Instance.new("AlignPosition")
                shootAlignPos.MaxForce = 10000
                shootAlignPos.Responsiveness = 200
                shootAlignPos.Parent = ball
                local shootAttachment = Instance.new("Attachment")
                shootAttachment.Parent = ball
                shootAlignPos.Attachment0 = shootAttachment
                local shootTargetAttachment = Instance.new("Attachment")
                shootTargetAttachment.Parent = workspace.Terrain
                shootAlignPos.Attachment1 = shootTargetAttachment

                local ballConnection
                ballConnection = RunService.Heartbeat:Connect(function()
                    local elapsed = tick() - shootStartTime
                    if elapsed >= duration then
                        ballConnection:Disconnect()
                        shootAlignPos:Destroy()
                        shootAttachment:Destroy()
                        shootTargetAttachment:Destroy()
                        fastControlSound:Destroy()
                        for _, vfx in ipairs(attachedBallVFX) do
                            vfx:Destroy()
                        end
                        for _, vfx in ipairs(attachedCharacterVFX) do
                            vfx:Destroy()
                        end
                    else
                        local targetPos = initialBallPos + aimDirection * speed * elapsed
                        shootTargetAttachment.Position = targetPos
                    end
                end)
            end
        end
    end

    task.delay(8, function()
        alignPos:Destroy()
        alignOri:Destroy()
        attachment:Destroy()
        targetAttachment:Destroy()
        bangDriveAnimationTrack:Stop()
        upSoundBang:Destroy()
    end)
end

local function performRoyalRelay()
    if not royalRelayEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.RoyalRelay < abilityCooldowns.RoyalRelay then
        warn("Royal Relay on cooldown!")
        return
    end
    lastUsedTimes.RoyalRelay = currentTime

    if not markedTeammate or not markedTeammate.Character or not markedTeammate.Character:FindFirstChild("HumanoidRootPart") then
        warn("No marked teammate!")
        return
    end

    markLocked = true
    royalRelayAnimationTrack:Play()
    royalRelaySound1:Play()

    ReplicatedStorage.Packages.Knit.Services.BallService.RE.Shoot:FireServer(50)

    if waitForBallShot(1) then
        local rightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
        if rightFoot then
            local vfx1 = game.ReplicatedStorage.Effects.BeinschussCutscene.CutsceneVFX.AryuSmash.Attachment:Clone()
            vfx1.Parent = rightFoot
            for _, child in ipairs(vfx1:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                    })
                    child.Rate = child.Rate * 3
                    child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                    child.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                        NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                    })
                    child:Emit(20)
                    child.Enabled = true
                end
            end
            task.delay(0.5, function()
                for _, child in ipairs(vfx1:GetChildren()) do
                    if child:IsA("ParticleEmitter") then child.Enabled = false end
                end
                vfx1:Destroy()
            end)

            local vfx2 = game.ReplicatedStorage.Effects.MagnusCutscene.CutsceneVFX.Root.emit:Clone()
            vfx2.Parent = rightFoot
            for _, child in ipairs(vfx2:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                    })
                    child.Rate = child.Rate * 3
                    child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                    child.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                        NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                    })
                    child:Emit(20)
                    child.Enabled = true
                end
            end
            task.delay(0.5, function()
                for _, child in ipairs(vfx2:GetChildren()) do
                    if child:IsA("ParticleEmitter") then child.Enabled = false end
                end
                vfx2:Destroy()
            end)
        end

        local ball = findBall()
        if ball then
            royalRelaySound2:Play()

            local ballVFXList = {
                game.ReplicatedStorage.Effects.NELRin.DestructiveCrashShotFX.VFX.ChargeKick.Attachment,
                game.ReplicatedStorage.Effects.NELRin.ANewToy.Environment.BallFX.w.VFX,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment,
                game.ReplicatedStorage.Effects.NELRin.Impulse.SmokeRun.Attachment
            }
            for _, vfxTemplate in ipairs(ballVFXList) do
                local vfx = vfxTemplate:Clone()
                vfx.Parent = ball
                for _, child in ipairs(vfx:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                        })
                        child.Rate = child.Rate * 6
                        child.Lifetime = NumberRange.new(child.Lifetime.Min * 2, child.Lifetime.Max * 2)
                        child.Size = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 2),
                            NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 2)
                        })
                        child:Emit(30)
                        child.Enabled = true
                    end
                end
                Debris:AddItem(vfx, 3.5)
            end

            for _, child in ipairs(ball:GetChildren()) do
                if child:IsA("AlignPosition") then child:Destroy() end
            end

            local direction = (markedTeammate.Character.HumanoidRootPart.Position - ball.Position).Unit
            local leftDirection = Vector3.new(0, 1, 0):Cross(direction).Unit
            local liftOffset = Vector3.new(0, 30, 0) + leftDirection * 30
            local liftPos = ball.Position + liftOffset

            local attachment = Instance.new("Attachment", ball)
            local liftTarget = Instance.new("Attachment")
            liftTarget.Position = liftPos
            liftTarget.Parent = workspace.Terrain

            local alignPosLift = Instance.new("AlignPosition")
            alignPosLift.MaxForce = 10000
            alignPosLift.Responsiveness = 200
            alignPosLift.Attachment0 = attachment
            alignPosLift.Attachment1 = liftTarget
            alignPosLift.Parent = ball

            task.delay(0.5, function()
                alignPosLift:Destroy()
                liftTarget:Destroy()
                local targetAttachment = Instance.new("Attachment")
                targetAttachment.Parent = markedTeammate.Character.HumanoidRootPart
                local alignPosMove = Instance.new("AlignPosition")
                alignPosMove.MaxForce = 15000
                alignPosMove.Responsiveness = 300
                alignPosMove.Attachment0 = attachment
                alignPosMove.Attachment1 = targetAttachment
                alignPosMove.Parent = ball
                task.delay(3, function()
                    alignPosMove:Destroy()
                    attachment:Destroy()
                    targetAttachment:Destroy()
                end)
            end)
        end
    else
        warn("Ball not shot within time limit")
    end
    task.delay(3, function()
        markLocked = false
    end)
end

local function performPredatorSnatch()
    if not predatorSnatchEnabled then return end
    local currentTime = tick()
    if currentTime - lastUsedTimes.PredatorSnatch < abilityCooldowns.PredatorSnatch then
        warn("Predator Snatch on cooldown!")
        return
    end

    local opponents = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Team ~= player.Team then
            table.insert(opponents, plr)
        end
    end
    local closestOpponent = nil
    local minDistance = math.huge
    for _, opponent in ipairs(opponents) do
        local char = opponent.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local distance = (hrp.Position - humanoidRootPart.Position).Magnitude
            if distance < 50 and distance < minDistance then
                minDistance = distance
                closestOpponent = opponent
            end
        end
    end
    if not closestOpponent then
        warn("No opponent within range!")
        return
    end
    lastUsedTimes.PredatorSnatch = currentTime

    local opponentMarkGui = Instance.new("BillboardGui")
    opponentMarkGui.Name = "OpponentMark"
    opponentMarkGui.AlwaysOnTop = true
    opponentMarkGui.Size = UDim2.new(0, 50, 0, 50)
    opponentMarkGui.StudsOffset = Vector3.new(0, 3, 0)
    opponentMarkGui.Adornee = closestOpponent.Character:FindFirstChild("HumanoidRootPart")
    opponentMarkGui.Parent = player.PlayerGui

    local xFrame1 = Instance.new("Frame")
    xFrame1.Size = UDim2.new(0, 2, 0, 20)
    xFrame1.Position = UDim2.new(0.5, -10, 0.5, -10)
    xFrame1.Rotation = 45
    xFrame1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    xFrame1.BorderSizePixel = 0
    xFrame1.Parent = opponentMarkGui
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 2)
    corner1.Parent = xFrame1

    local xFrame2 = Instance.new("Frame")
    xFrame2.Size = UDim2.new(0, 2, 0, 20)
    xFrame2.Position = UDim2.new(0.5, -10, 0.5, -10)
    xFrame2.Rotation = -45
    xFrame2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    xFrame2.BorderSizePixel = 0
    xFrame2.Parent = opponentMarkGui
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 2)
    corner2.Parent = xFrame2

    predatorSnatchAnimationTrack:Play()
    predatorSnatchSound1:Play()
    predatorSnatchSound2:Play()

    local vfxList = {
        game.ReplicatedStorage.Effects.CrowTheft.RunningFX.Attachment,
        game.ReplicatedStorage.Assets.Vfx.ChigiriRun.Attachment,
        game.ReplicatedStorage.Assets.Vfx.KingsDribble.RunPlr.Attachment,
        game.ReplicatedStorage.Effects.NELRin.DestructionDribble.SmokeRun.Attachment
    }
    for _, vfxTemplate in ipairs(vfxList) do
        local vfx = vfxTemplate:Clone()
        vfx.Parent = humanoidRootPart
        for _, child in ipairs(vfx:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 150))
                })
                child.Rate = child.Rate * 5
                child.Lifetime = NumberRange.new(child.Lifetime.Min * 3, child.Lifetime.Max * 3)
                child.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, child.Size.Keypoints[1].Value * 3),
                    NumberSequenceKeypoint.new(1, child.Size.Keypoints[2].Value * 3)
                })
                child:Emit(50)
                child.Enabled = true
            end
        end
        Debris:AddItem(vfx, 2)
    end

    local alignPos = Instance.new("AlignPosition")
    alignPos.MaxForce = 100000
    alignPos.Responsiveness = 200
    alignPos.Parent = humanoidRootPart
    local attachment0 = Instance.new("Attachment", humanoidRootPart)
    alignPos.Attachment0 = attachment0
    local targetAttachment = Instance.new("Attachment", closestOpponent.Character.HumanoidRootPart)
    alignPos.Attachment1 = targetAttachment

    local alignOri = Instance.new("AlignOrientation")
    alignOri.MaxTorque = 10000
    alignOri.Responsiveness = 200
    alignOri.Attachment0 = attachment0
    alignOri.Parent = humanoidRootPart

    local dashSpeed = 350
    local maxDashTime = 0.8
    local startTime = tick()

    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not closestOpponent or not closestOpponent.Character or not closestOpponent.Character:FindFirstChild("HumanoidRootPart") then
            connection:Disconnect()
            alignPos:Destroy()
            alignOri:Destroy()
            attachment0:Destroy()
            targetAttachment:Destroy()
            opponentMarkGui:Destroy()
            return
        end
        local opponentHRP = closestOpponent.Character.HumanoidRootPart
        alignOri.CFrame = CFrame.lookAt(humanoidRootPart.Position, opponentHRP.Position)
        local distance = (opponentHRP.Position - humanoidRootPart.Position).Magnitude
        if distance <= 3 then
            ReplicatedStorage.Packages.Knit.Services.BallService.RE.Slide:FireServer()
        end
        if tick() - startTime >= maxDashTime then
            connection:Disconnect()
            alignPos:Destroy()
            alignOri:Destroy()
            attachment0:Destroy()
            targetAttachment:Destroy()
            opponentMarkGui:Destroy()
            local randomLine = abilityLines[math.random(1, #abilityLines)]
            displayTextAboveCharacter(randomLine)
        end
    end)
end

local function performAbility()
    if currentVariant == "GyroNova" then
        performGyroNova()
    elseif currentVariant == "BangDrive" then
        performBangDrive()
    end
end

-- Destroy Everything Function (Updated for NongkhawKawaii UI)
local function destroyEverything()
    local khawGui = game:GetService("CoreGui"):FindFirstChild("Khaw")
    if khawGui then khawGui:Destroy() end

    local customButtons = {
        "SuiKickButton",
        "BlitzRushButton",
        "WildShotButton",
        "QuickShiftButton",
        "PredatorSnatchButton",
        "RoyalRelayButton",
        "GyroNovaButton",
        "ChangeVariantButton",
        "DestroyAbilitiesButton"
    }
    local bottomAbilities = player.PlayerGui:WaitForChild("InGameUI"):WaitForChild("Bottom"):WaitForChild("Abilities")
    for _, btnName in ipairs(customButtons) do
        local btn = bottomAbilities:FindFirstChild(btnName)
        if btn then btn:Destroy() end
    end

    if inputConnection then inputConnection:Disconnect() end
    if heartbeatConnection then heartbeatConnection:Disconnect() end

    game.StarterGui:SetCore("SendNotification", {
        Title = "Abilities Destroyed",
        Text = "All abilities and UI have been removed.",
        Duration = 5
    })
end

-- Setup Ability Buttons
local bottomAbilities = player.PlayerGui:WaitForChild("InGameUI"):WaitForChild("Bottom"):WaitForChild("Abilities")

local btnSuiKick = bottomAbilities["1"]:Clone()
btnSuiKick.Name = "SuiKickButton"
btnSuiKick.Parent = bottomAbilities
btnSuiKick.LayoutOrder = 1
btnSuiKick.Keybind.Text = "R"
btnSuiKick.Timer.Text = "Sui Kick"
btnSuiKick.ActualTimer.Text = ""
if btnSuiKick:FindFirstChild("Cooldown") then btnSuiKick.Cooldown:Destroy() end
btnSuiKick.Visible = true
addCooldownOverlay(btnSuiKick)

local btnBlitzRush = bottomAbilities["1"]:Clone()
btnBlitzRush.Name = "BlitzRushButton"
btnBlitzRush.Parent = bottomAbilities
btnBlitzRush.LayoutOrder = 2
btnBlitzRush.Keybind.Text = "T"
btnBlitzRush.Timer.Text = "Blitz Rush"
btnBlitzRush.ActualTimer.Text = ""
if btnBlitzRush:FindFirstChild("Cooldown") then btnBlitzRush.Cooldown:Destroy() end
btnBlitzRush.Visible = true
addCooldownOverlay(btnBlitzRush)

local btnWildShot = bottomAbilities["1"]:Clone()
btnWildShot.Name = "WildShotButton"
btnWildShot.Parent = bottomAbilities
btnWildShot.LayoutOrder = 3
btnWildShot.Keybind.Text = "Z"
btnWildShot.Timer.Text = "Wild Shot"
btnWildShot.ActualTimer.Text = ""
if btnWildShot:FindFirstChild("Cooldown") then btnWildShot.Cooldown:Destroy() end
btnWildShot.Visible = true
addCooldownOverlay(btnWildShot)

local btnQuickShift = bottomAbilities["1"]:Clone()
btnQuickShift.Name = "QuickShiftButton"
btnQuickShift.Parent = bottomAbilities
btnQuickShift.LayoutOrder = 4
btnQuickShift.Keybind.Text = "Y"
btnQuickShift.Timer.Text = "Quick Shift"
btnQuickShift.ActualTimer.Text = ""
if btnQuickShift:FindFirstChild("Cooldown") then btnQuickShift.Cooldown:Destroy() end
btnQuickShift.Visible = true
addCooldownOverlay(btnQuickShift)

local btnPredatorSnatch = bottomAbilities["1"]:Clone()
btnPredatorSnatch.Name = "PredatorSnatchButton"
btnPredatorSnatch.Parent = bottomAbilities
btnPredatorSnatch.LayoutOrder = 5
btnPredatorSnatch.Keybind.Text = "1"
btnPredatorSnatch.Timer.Text = "Predator Snatch"
btnPredatorSnatch.ActualTimer.Text = ""
if btnPredatorSnatch:FindFirstChild("Cooldown") then btnPredatorSnatch.Cooldown:Destroy() end
btnPredatorSnatch.Visible = true
addCooldownOverlay(btnPredatorSnatch)

local btnRoyalRelay = bottomAbilities["1"]:Clone()
btnRoyalRelay.Name = "RoyalRelayButton"
btnRoyalRelay.Parent = bottomAbilities
btnRoyalRelay.LayoutOrder = 6
btnRoyalRelay.Keybind.Text = "2"
btnRoyalRelay.Timer.Text = "Royal Relay"
btnRoyalRelay.ActualTimer.Text = ""
if btnRoyalRelay:FindFirstChild("Cooldown") then btnRoyalRelay.Cooldown:Destroy() end
btnRoyalRelay.Visible = true
addCooldownOverlay(btnRoyalRelay)

local btnGyroNova = bottomAbilities["1"]:Clone()
btnGyroNova.Name = "GyroNovaButton"
btnGyroNova.Parent = bottomAbilities
btnGyroNova.LayoutOrder = 7
btnGyroNova.Keybind.Text = "3"
btnGyroNova.Timer.Text = "Gyro Nova"
btnGyroNova.ActualTimer.Text = ""
if btnGyroNova:FindFirstChild("Cooldown") then btnGyroNova.Cooldown:Destroy() end
btnGyroNova.Visible = true
addCooldownOverlay(btnGyroNova)

local btnChangeVariant = bottomAbilities["1"]:Clone()
btnChangeVariant.Name = "ChangeVariantButton"
btnChangeVariant.Parent = bottomAbilities
btnChangeVariant.LayoutOrder = 8
btnChangeVariant.Keybind.Text = "0"
btnChangeVariant.Timer.Text = "Change Variant"
btnChangeVariant.ActualTimer.Text = ""
if btnChangeVariant:FindFirstChild("Cooldown") then btnChangeVariant.Cooldown:Destroy() end
btnChangeVariant.Visible = true

local btnDestroyAbilities = bottomAbilities["1"]:Clone()
btnDestroyAbilities.Name = "DestroyAbilitiesButton"
btnDestroyAbilities.Parent = bottomAbilities
btnDestroyAbilities.LayoutOrder = 9
btnDestroyAbilities.Keybind.Text = "9"
btnDestroyAbilities.Timer.Text = "Destroy Everything"
btnDestroyAbilities.ActualTimer.Text = ""
if btnDestroyAbilities:FindFirstChild("Cooldown") then btnDestroyAbilities.Cooldown:Destroy() end
btnDestroyAbilities.Visible = true

btnSuiKick.Activated:Connect(performSuiKick)
btnBlitzRush.Activated:Connect(performBlitzRush)
btnWildShot.Activated:Connect(performWildShot)
btnQuickShift.Activated:Connect(performQuickShift)
btnDestroyAbilities.Activated:Connect(destroyEverything)
btnGyroNova.Activated:Connect(performAbility)
btnRoyalRelay.Activated:Connect(performRoyalRelay)
btnPredatorSnatch.Activated:Connect(performPredatorSnatch)

btnChangeVariant.Activated:Connect(function()
    if currentVariant == "GyroNova" then
        currentVariant = "BangDrive"
        btnGyroNova.Timer.Text = "Bang Drive"
    else
        currentVariant = "GyroNova"
        btnGyroNova.Timer.Text = "Gyro Nova"
    end
end)

-- Input Handling
inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        performSuiKick()
    elseif input.KeyCode == Enum.KeyCode.T then
        performBlitzRush()
    elseif input.KeyCode == Enum.KeyCode.Z then
        performWildShot()
    elseif input.KeyCode == Enum.KeyCode.Y then
        performQuickShift()
    elseif input.KeyCode == Enum.KeyCode.One then
        performPredatorSnatch()
    elseif input.KeyCode == Enum.KeyCode.Two then
        performRoyalRelay()
    elseif input.KeyCode == Enum.KeyCode.Three then
        performAbility()
    elseif input.KeyCode == Enum.KeyCode.Zero then
        if currentVariant == "GyroNova" then
            currentVariant = "BangDrive"
            btnGyroNova.Timer.Text = "Bang Drive"
        else
            currentVariant = "GyroNova"
            btnGyroNova.Timer.Text = "Gyro Nova"
        end
    elseif input.KeyCode == Enum.KeyCode.Nine then
        destroyEverything()
    end
end)

-- Character Respawn
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    suiKickAnimationTrack = humanoid:LoadAnimation(suiKickAnimation)
    suiKickAnimationTrack2 = humanoid:LoadAnimation(suiKickAnimation2)
    blitzRushAnimationTrack = humanoid:LoadAnimation(blitzRushAnimation)
    wildShotAnimationTrack = humanoid:LoadAnimation(wildShotAnimation)
    quickShiftAnimationTrack1 = humanoid:LoadAnimation(quickShiftAnimation1)
    quickShiftAnimationTrack2 = humanoid:LoadAnimation(quickShiftAnimation2)
    gyroNovaAnimationTrack = humanoid:LoadAnimation(gyroNovaAnimation)
    bangDriveAnimationTrack = humanoid:LoadAnimation(bangDriveAnimation)
    royalRelayAnimationTrack = humanoid:LoadAnimation(royalRelayAnimation)
    predatorSnatchAnimationTrack = humanoid:LoadAnimation(predatorSnatchAnimation)
    suiKickSound.Parent = humanoidRootPart
    suiKickShootSound.Parent = humanoidRootPart
    blitzRushSound.Parent = humanoidRootPart
    wildShotSound.Parent = humanoidRootPart
    quickShiftSound.Parent = humanoidRootPart
    upSound.Parent = humanoidRootPart
    royalRelaySound1.Parent = humanoidRootPart
    royalRelaySound2.Parent = humanoidRootPart
    predatorSnatchSound1.Parent = humanoidRootPart
    predatorSnatchSound2.Parent = humanoidRootPart
end)

-- Update Button Visibility with Cooldown Overlay
local function updateButtonVisibility()
    local currentTime = tick()
    if btnSuiKick and btnSuiKick.Parent then
        btnSuiKick.Visible = suiKickEnabled
        if suiKickEnabled then
            local remaining = abilityCooldowns.SuiKick - (currentTime - lastUsedTimes.SuiKick)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.SuiKick
                btnSuiKick.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnSuiKick.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnSuiKick.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnSuiKick.Timer.Text = "Sui Kick"
            end
        end
    end
    if btnBlitzRush and btnBlitzRush.Parent then
        btnBlitzRush.Visible = blitzRushEnabled
        if blitzRushEnabled then
            local remaining = abilityCooldowns.BlitzRush - (currentTime - lastUsedTimes.BlitzRush)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.BlitzRush
                btnBlitzRush.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnBlitzRush.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnBlitzRush.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnBlitzRush.Timer.Text = "Blitz Rush"
            end
        end
    end
    if btnWildShot and btnWildShot.Parent then
        btnWildShot.Visible = wildShotEnabled
        if wildShotEnabled then
            local remaining = abilityCooldowns.WildShot - (currentTime - lastUsedTimes.WildShot)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.WildShot
                btnWildShot.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnWildShot.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnWildShot.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnWildShot.Timer.Text = "Wild Shot"
            end
        end
    end
    if btnQuickShift and btnQuickShift.Parent then
        btnQuickShift.Visible = quickShiftEnabled
        if quickShiftEnabled then
            local remaining = abilityCooldowns.QuickShift - (currentTime - lastUsedTimes.QuickShift)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.QuickShift
                btnQuickShift.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnQuickShift.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnQuickShift.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnQuickShift.Timer.Text = "Quick Shift"
            end
        end
    end
    if btnDestroyAbilities and btnDestroyAbilities.Parent then
        btnDestroyAbilities.Visible = true
        btnDestroyAbilities.Timer.Text = "Destroy Everything"
    end
    if btnGyroNova and btnGyroNova.Parent then
        btnGyroNova.Visible = gyroNovaEnabled
        if gyroNovaEnabled then
            local remaining = abilityCooldowns.GyroNova - (currentTime - lastUsedTimes.GyroNova)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.GyroNova
                btnGyroNova.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnGyroNova.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnGyroNova.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnGyroNova.Timer.Text = currentVariant == "GyroNova" and "Gyro Nova" or "Bang Drive"
            end
        end
    end
    if btnChangeVariant and btnChangeVariant.Parent then
        btnChangeVariant.Visible = true
        btnChangeVariant.Timer.Text = "Change Variant"
    end
    if btnRoyalRelay and btnRoyalRelay.Parent then
        btnRoyalRelay.Visible = royalRelayEnabled
        if royalRelayEnabled then
            local remaining = abilityCooldowns.RoyalRelay - (currentTime - lastUsedTimes.RoyalRelay)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.RoyalRelay
                btnRoyalRelay.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnRoyalRelay.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnRoyalRelay.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnRoyalRelay.Timer.Text = "Royal Relay"
            end
        end
    end
    if btnPredatorSnatch and btnPredatorSnatch.Parent then
        btnPredatorSnatch.Visible = predatorSnatchEnabled
        if predatorSnatchEnabled then
            local remaining = abilityCooldowns.PredatorSnatch - (currentTime - lastUsedTimes.PredatorSnatch)
            if remaining > 0 then
                local fraction = remaining / abilityCooldowns.PredatorSnatch
                btnPredatorSnatch.CooldownOverlay.Size = UDim2.new(1, 0, fraction, 0)
                btnPredatorSnatch.Timer.Text = string.format("CD: %.1f s", remaining)
            else
                btnPredatorSnatch.CooldownOverlay.Size = UDim2.new(1, 0, 0, 0)
                btnPredatorSnatch.Timer.Text = "Predator Snatch"
            end
        end
    end
end

heartbeatConnection = RunService.Heartbeat:Connect(updateButtonVisibility)

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Welcome to Souls Hub",
    Text = "Ronaldo",
    Duration = 5
})

-- Style Name and Description Setup
local styleGui = player.PlayerGui:WaitForChild("Style")
local st = styleGui:WaitForChild("BG"):WaitForChild("StyleTxt")
local Slot1 = styleGui.BG.Slots.ScrollingFrame:WaitForChild("Slot1")
local Slot1TextLabel = Slot1:FindFirstChild("TextLabel") or Slot1:FindFirstChild("Text")
local des = styleGui.BG:WaitForChild("Desc")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Ronaldo Style Loaded!",
    Text = "Thank You For Using My Script:)",
    Button1 = "W",
    Button2 = "np",
    Duration = 3
})

spawn(function()
    while task.wait() do
        if st then
            st.Text = "Ronaldo"
            st.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        if Slot1TextLabel then
            Slot1TextLabel.Text = "Ronaldo"
            Slot1TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        if des then
            des.Text = "Suiii"
            des.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        if Slot1 then
            Slot1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Join Souls Hub For Updates!",
    Text = "CRISTIANOOOO",
    Button1 = "W",
    Button2 = "W Dev",
    Duration = 5
})