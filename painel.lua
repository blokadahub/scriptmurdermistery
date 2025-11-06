--[[
    Script de GUI do Delta Executor
    Criado com ajuda de IA e monitorado por Ezequiel Bezerra.
]]

-- CONFIGURAÇÕES INICIAIS
local gui_visivel = true
local cor_principal = Color3.fromRGB(220, 38, 38) -- Vermelho
local cor_secundaria = Color3.fromRGB(185, 28, 28)
local cor_fundo = Color3.fromRGB(153, 27, 27)
local cor_texto = Color3.fromRGB(255, 255, 255)
local cor_destaque = BrickColor.new("Really red").Color -- Cor inicial do ESP/Aimbot

-- CRIAÇÃO DA GUI PRINCIPAL
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaExecutorGUI_Ezequiel"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = cor_principal
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderColor3 = cor_secundaria
mainFrame.BorderSizePixel = 2
mainFrame.Position = UDim2.new(0, 20, 0.1, 0)
mainFrame.Size = UDim2.new(0, 300, 0, 450)
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Visible = gui_visivel
mainFrame.ClipsDescendants = true
mainFrame.CornerRadius = UDim.new(0, 8)

local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = mainFrame
header.BackgroundColor3 = cor_secundaria
header.Size = UDim2.new(1, 0, 0, 40)
header.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = header
titleLabel.BackgroundColor3 = header.BackgroundColor3
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Delta Executor"
titleLabel.TextColor3 = cor_texto
titleLabel.TextSize = 20

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Parent = mainFrame
contentFrame.BackgroundColor3 = cor_principal
contentFrame.BackgroundTransparency = 1
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.ScrollBarImageColor3 = cor_secundaria
contentFrame.ScrollBarThickness = 6
contentFrame.BorderSizePixel = 0

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = contentFrame
uiListLayout.Padding = UDim.new(0, 5)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- BOTÃO PARA ABRIR/FECHAR NO CELULAR
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.BackgroundColor3 = cor_principal
toggleButton.BorderColor3 = cor_secundaria
toggleButton.BorderSizePixel = 2
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(1, -75, 1, -75)
toggleButton.Text = "Abrir"
toggleButton.TextColor3 = cor_texto
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.AutoButtonColor = true
toggleButton.CornerRadius = UDim.new(0.5, 0)
if not game:GetService("UserInputService").TouchEnabled then
    toggleButton.Visible = false
end

toggleButton.MouseButton1Click:Connect(function()
    gui_visivel = not gui_visivel
    mainFrame.Visible = gui_visivel
    if gui_visivel then
        toggleButton.Text = "Fechar"
    else
        toggleButton.Text = "Abrir"
    end
end)

-- FUNÇÃO PARA CRIAR SEÇÕES COLAPSÁVEIS
local yPosition = 0
local function CreateCollapsibleSection(title, defaultOpen)
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = title
    sectionFrame.Parent = contentFrame
    sectionFrame.BackgroundColor3 = cor_fundo
    sectionFrame.BackgroundTransparency = 0.5
    sectionFrame.BorderColor3 = cor_secundaria
    sectionFrame.BorderSizePixel = 1
    sectionFrame.ClipsDescendants = true
    sectionFrame.Size = UDim2.new(1, -10, 0, 35)
    sectionFrame.Position = UDim2.new(0, 5, 0, yPosition)
    sectionFrame.LayoutOrder = yPosition
    sectionFrame.CornerRadius = UDim.new(0, 6)
    yPosition = yPosition + 1

    local sectionHeader = Instance.new("TextButton")
    sectionHeader.Name = "Header"
    sectionHeader.Parent = sectionFrame
    sectionHeader.BackgroundColor3 = cor_fundo
    sectionHeader.BackgroundTransparency = 1
    sectionHeader.Size = UDim2.new(1, 0, 0, 35)
    sectionHeader.Text = "  " .. title
    sectionHeader.TextColor3 = cor_texto
    sectionHeader.Font = Enum.Font.SourceSansBold
    sectionHeader.TextSize = 18
    sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
    
    local contentHolder = Instance.new("Frame")
    contentHolder.Name = "ContentHolder"
    contentHolder.Parent = sectionFrame
    contentHolder.Position = UDim2.new(0, 0, 0, 35)
    contentHolder.Size = UDim2.new(1, 0, 0, 0)
    contentHolder.BackgroundTransparency = 1
    contentHolder.ClipsDescendants = true
    
    local uiListLayoutContent = Instance.new("UIListLayout")
    uiListLayoutContent.Parent = contentHolder
    uiListLayoutContent.Padding = UDim.new(0, 5)
    uiListLayoutContent.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local isOpen = defaultOpen or false
    
    local function UpdateSection()
        local contentSize = uiListLayoutContent.AbsoluteContentSize
        contentHolder:TweenSize(UDim2.new(1, 0, 0, isOpen and contentSize.Y or 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        sectionFrame:TweenSize(UDim2.new(1, -10, 0, 35 + (isOpen and contentSize.Y or 0)), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end
    
    sectionHeader.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        UpdateSection()
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition * 40 + 200)

    contentHolder.ChildAdded:Connect(UpdateSection)
    contentHolder.ChildRemoved:Connect(UpdateSection)

    if isOpen then
        task.wait(0.1) 
        UpdateSection()
    end
    
    return contentHolder
end

-- FUNÇÃO PARA CRIAR BOTÕES DE ATIVAR/DESATIVAR
local function CreateToggleButton(parent, text)
    local toggleState = false
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Parent = parent
    buttonFrame.Size = UDim2.new(1, -10, 0, 30)
    buttonFrame.BackgroundColor3 = cor_fundo
    buttonFrame.BackgroundTransparency = 0.3
    buttonFrame.CornerRadius = UDim.new(0, 4)
    
    local label = Instance.new("TextLabel")
    label.Parent = buttonFrame
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Text = text
    label.TextColor3 = cor_texto
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 10, 0, 0)
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = buttonFrame
    toggle.Size = UDim2.new(0.25, 0, 0.8, 0)
    toggle.Position = UDim2.new(0.7, 0, 0.1, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    toggle.Text = ""
    toggle.CornerRadius = UDim.new(0, 4)
    
    toggle.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        if toggleState then
            toggle.BackgroundColor3 = Color3.fromRGB(10, 200, 10) 
        else
            toggle.BackgroundColor3 = Color3.fromRGB(120, 120, 120) 
        end
    end)
    
    return toggle, function() return toggleState end
end

-- 1. CRÉDITOS
local creditosContent = CreateCollapsibleSection("Créditos", true)
local creditosLabel = Instance.new("TextLabel")
creditosLabel.Parent = creditosContent
creditosLabel.Size = UDim2.new(1, -10, 0, 50)
creditosLabel.BackgroundColor3 = cor_principal
creditosLabel.BackgroundTransparency = 1
creditosLabel.Font = Enum.Font.SourceSans
creditosLabel.Text = "Este script foi criado com ajuda de IA e monitorado por Ezequiel Bezerra."
creditosLabel.TextColor3 = cor_texto
creditosLabel.TextSize = 14
creditosLabel.TextWrapped = true

-- 2. WALKSPEED
local walkspeedContent = CreateCollapsibleSection("Walkspeed")

local speedInput = Instance.new("TextBox")
speedInput.Parent = walkspeedContent
speedInput.Size = UDim2.new(1, -10, 0, 35)
speedInput.BackgroundColor3 = cor_fundo
speedInput.PlaceholderText = "Velocidade (Ex: 67)"
speedInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
speedInput.Text = ""
speedInput.TextColor3 = cor_texto
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 16
speedInput.ClearTextOnFocus = false
speedInput.CornerRadius = UDim.new(0, 4)

local resetButton = Instance.new("TextButton")
resetButton.Parent = walkspeedContent
resetButton.Size = UDim2.new(1, -10, 0, 30)
resetButton.BackgroundColor3 = cor_secundaria
resetButton.Text = "Resetar Walkspeed"
resetButton.TextColor3 = cor_texto
resetButton.Font = Enum.Font.SourceSansBold
resetButton.TextSize = 16
resetButton.CornerRadius = UDim.new(0, 4)

speedInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(speedInput.Text)
        if speed and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

resetButton.MouseButton1Click:Connect(function()
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
    speedInput.Text = ""
end)

-- 3. MOVIMENTO
local movimentoContent = CreateCollapsibleSection("Movimento")
local flyToggle, isFlyEnabled = CreateToggleButton(movimentoContent, "Fly")
local flySpeed = 50 
local flyConnection = nil

local function updateFly(character)
    if isFlyEnabled() and character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        local bodyVelocity = humanoidRootPart:FindFirstChild("BodyVelocity")
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        end
        bodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.lookVector * flySpeed
    else
        if character and character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.BodyVelocity then
            character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end

flyToggle.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if isFlyEnabled() then
        if not flyConnection then
             flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                updateFly(game.Players.LocalPlayer.Character)
            end)
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        updateFly(character)
    end
end)


-- 4. COMBATE
local combateContent = CreateCollapsibleSection("Combate")
CreateToggleButton(combateContent, "Aimbot (Área Grande)")
CreateToggleButton(combateContent, "ESP (Ver Players)")

-- 5. CONFIGURAÇÕES
local configContent = CreateCollapsibleSection("Configurações")

local colorLabel = Instance.new("TextLabel")
colorLabel.Parent = configContent
colorLabel.Size = UDim2.new(1, -10, 0, 20)
colorLabel.Text = "Cor do Destaque (ESP/Aimbot)"
colorLabel.TextColor3 = cor_texto
colorLabel.Font = Enum.Font.SourceSans
colorLabel.TextSize = 14
colorLabel.BackgroundTransparency = 1
colorLabel.TextXAlignment = Enum.TextXAlignment.Left

local colorInput = Instance.new("TextBox")
colorInput.Parent = configContent
colorInput.Size = UDim2.new(1, -10, 0, 35)
colorInput.BackgroundColor3 = cor_fundo
colorInput.PlaceholderText = "R, G, B (Ex: 255, 0, 0)"
colorInput.Text = "255, 38, 38"
colorInput.TextColor3 = cor_texto
colorInput.Font = Enum.Font.SourceSans
colorInput.TextSize = 16
colorInput.ClearTextOnFocus = false
colorInput.CornerRadius = UDim.new(0, 4)

colorInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = colorInput.Text
        local r, g, b = text:match("^(%d+),%s*(%d+),%s*(%d+)$")
        if r and g and b then
            cor_destaque = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
        end
    end
end)
