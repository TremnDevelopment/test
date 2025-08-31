-- ReplicatedStorage.TabModule
local TabModule = {}

-- Create a tab system inside a sidebar
function TabModule.new(frame: Frame, sidebar: Frame)
    local tabSystem = {}
    tabSystem.Frame = frame
    tabSystem.Sidebar = sidebar
    tabSystem.Content = Instance.new("Frame")

    -- Content container
    tabSystem.Content.Size = UDim2.new(1, 0, 1, 0)
    tabSystem.Content.Position = UDim2.new(0, 0, 0, 0)
    tabSystem.Content.BackgroundTransparency = 1
    tabSystem.Content.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = sidebar

    local tabButtons = {}
    local currentTab = nil

    -- Function to add a new tab
    function tabSystem:AddTab(name: string)
        -- Button inside sidebar
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -10, 0, 35)
        button.Position = UDim2.new(0, 5, 0, 0)
        button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 18
        button.Text = name
        button.Parent = sidebar

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = button

        -- Content frame for this tab
        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1 - sidebar.Size.X.Scale, -sidebar.Size.X.Offset, 1, 0)
        tabContent.Position = UDim2.new(sidebar.Size.X.Scale, sidebar.Size.X.Offset, 0, 0)
        tabContent.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        tabContent.Visible = false
        tabContent.ZIndex = 1 -- make sure it renders above frame but below sidebar
        tabContent.Parent = tabSystem.Content

        local contentCorner = Instance.new("UICorner")
        contentCorner.CornerRadius = UDim.new(0, 12)
        contentCorner.Parent = tabContent

        -- Button click: switch tab
        button.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Visible = false
            end
            tabContent.Visible = true
            currentTab = tabContent
        end)

        tabButtons[name] = {
            Button = button,
            Content = tabContent
        }

        return tabContent -- so caller can put stuff inside
    end

    return tabSystem
end

return TabModule
