local TabModule = {}

function TabModule.new(frame)
    local tabSystem = {}

    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0.25, 0, 1, 0) -- 25% of width
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = frame
    tabSystem.Sidebar = sidebar

    -- Scrolling list for tabs
    local tabList = Instance.new("UIListLayout")
    tabList.Parent = sidebar
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabSystem.TabList = tabList

    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(0.75, 0, 1, 0) -- Remaining space
    contentContainer.Position = UDim2.new(0.25, 0, 0, 0)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = frame
    tabSystem.Content = contentContainer

    tabSystem.Tabs = {}
    tabSystem.ActiveTab = nil

    -- Add tab function
    function tabSystem:AddTab(tabName)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 40)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.Text = tabName
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 18
        button.Parent = sidebar

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, 0) -- fills content container
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        tabContent.BorderSizePixel = 0
        tabContent.Visible = false
        tabContent.Parent = contentContainer

        self.Tabs[tabName] = {
            Button = button,
            Content = tabContent
        }

        -- Button click -> switch tabs
        button.MouseButton1Click:Connect(function()
            self:ShowTab(tabName)
        end)

        -- Auto-open first tab
        if not self.ActiveTab then
            self:ShowTab(tabName)
        end

        return tabContent
    end

    -- ShowTab function
    function tabSystem:ShowTab(tabName)
        for name, tab in pairs(self.Tabs) do
            tab.Content.Visible = (name == tabName)
            tab.Button.BackgroundColor3 = (name == tabName)
                and Color3.fromRGB(90, 90, 90)
                or Color3.fromRGB(70, 70, 70)
        end
        self.ActiveTab = tabName
    end

    return tabSystem
end

return TabModule
