if Library and Library.Unload then
    Library:Unload()
end
-- separator
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")
local GuiService = game:GetService("GuiService")
-- separator
local Client = Players.LocalPlayer
local Camera = Workspace:FindFirstChildWhichIsA("Camera")
local Viewport = Camera.ViewportSize
-- separator
do -- Folders
    if not isfolder("gamesense") then
        makefolder("gamesense")
    end
    -- separator
    if not isfolder("gamesense/Configs") then
        makefolder("gamesense/Configs")
    end
end
-- separator
do -- Library
    getgenv().Library = {
        Connections = {},
        Errors = {},
        Tweens = {},
        Objects = {},
        Sections = {},
        ThemeSections = {},
        Flags = {},
        UnnamedFlags = 0,
        Build = "Beta",
        UID = "1",
        UnsafeMode = false,
        InitTime = os.clock(),
        Folder = "gamesense",
        ConfigFolder = "gamesense/Configs",
        UI = {
            Name = "gamesense",
            CloseBind = Enum.KeyCode.Insert,
            SectionResizeIncrements = 1,
            WatermarkRefreshRate = 1,
            MainUI = nil,
            Initialized = false,
            Faded = false,
            LastCopiedColor = nil,
            TabIndex = 0,
            Viewing = false,
            CurrentSelectedColorPicker = nil,
            CurrentSelectedColorPickerExtra = nil,
            CurrentSelectedKeybindMode = nil,
            TotalColorPickers = 0,
            TotalKeybindModes = 0,
            WatermarkPosition = "Top Right",
            SectionZIndex = 100,
            Resizing = false,
            DropdownZIndex = 1,
            OpenColorFrames = 0,
            ScreenGUI = nil,
            TweenSpeed = 0.15,
            NewFont = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            FontSize = 13,
            DraggingGui = nil,
            Notifications = {TopLeft = {}, Middle = {}},
            Keys = {
                [Enum.KeyCode.LeftShift] = "LSHF",
                [Enum.KeyCode.RightShift] = "RSHF",
                [Enum.KeyCode.LeftControl] = "LCTR",
                [Enum.KeyCode.RightControl] = "RCTR",
                [Enum.KeyCode.LeftAlt] = "LALT",
                [Enum.KeyCode.RightAlt] = "RALT",
                [Enum.KeyCode.CapsLock] = "CAPS",
                [Enum.KeyCode.Space] = "SPCE",
                [Enum.KeyCode.One] = "ONE",
                [Enum.KeyCode.Two] = "TWO",
                [Enum.KeyCode.Three] = "THREE",
                [Enum.KeyCode.Four] = "FOUR",
                [Enum.KeyCode.Five] = "FIVE",
                [Enum.KeyCode.Six] = "SIX",
                [Enum.KeyCode.Seven] = "SEVEN",
                [Enum.KeyCode.Eight] = "EIGHT",
                [Enum.KeyCode.Nine] = "NINE",
                [Enum.KeyCode.Zero] = "ZERO",
                [Enum.KeyCode.KeypadOne] = "NUM1",
                [Enum.KeyCode.KeypadTwo] = "NUM2",
                [Enum.KeyCode.KeypadThree] = "NUM3",
                [Enum.KeyCode.KeypadFour] = "NUM4",
                [Enum.KeyCode.KeypadFive] = "NUM5",
                [Enum.KeyCode.KeypadSix] = "NUM6",
                [Enum.KeyCode.KeypadSeven] = "NUM7",
                [Enum.KeyCode.KeypadEight] = "NUM8",
                [Enum.KeyCode.KeypadNine] = "NUM9",
                [Enum.KeyCode.KeypadZero] = "NUM0",
                [Enum.KeyCode.Insert] = "INS",
                [Enum.KeyCode.Minus] = "-",
                [Enum.KeyCode.Equals] = "=",
                [Enum.KeyCode.Tilde] = "~",
                [Enum.KeyCode.LeftBracket] = "[",
                [Enum.KeyCode.RightBracket] = "]",
                [Enum.KeyCode.RightParenthesis] = ")",
                [Enum.KeyCode.LeftParenthesis] = "(",
                [Enum.KeyCode.Semicolon] = ",",
                [Enum.KeyCode.Quote] = "'",
                [Enum.KeyCode.BackSlash] = "\\",
                [Enum.KeyCode.Comma] = ",",
                [Enum.KeyCode.Period] = ".",
                [Enum.KeyCode.Slash] = "/",
                [Enum.KeyCode.Asterisk] = "*",
                [Enum.KeyCode.Plus] = "+",
                [Enum.KeyCode.Period] = ".",
                [Enum.KeyCode.Backquote] = "`",
                [Enum.UserInputType.MouseButton1] = "M1",
                [Enum.UserInputType.MouseButton2] = "M2",
                [Enum.UserInputType.MouseButton3] = "M3"
            },
        },
        Theme = {
            Objects = {},
            Default = {
                Accent = Color3.fromRGB(153, 196, 39),
                SecondAccent = Color3.fromRGB(124, 158, 32),
                TextColor = Color3.fromRGB(205, 205, 205),
                Risky = Color3.fromRGB(165, 165, 120),
            }
        }
    }
    -- separator
    function Library:Validate(Defaults, Options)
        for Index, Value in Defaults do
            if Options[Index] == nil then
                Options[Index] = Value
            end
        end
        -- separator
        return Options
    end
    -- separator
    function Library:Connection(Signal, Func, Name, Table)
        Name = Name or "Unknown"
        Table = Table or Library.Connections
        -- separator
        local Connection; Connection = Signal:Connect(function(...)
            local Args = {...}
            -- separator
            local Success, Message = pcall(function() coroutine.wrap(Func)(unpack(Args)) end)
            -- separator
            if not Success and not Library.Errors[Message] then
                if Library.Notify then
                    Library:Notify({Message = ("[ERROR] | An error has occurred:\n%s\nName: %s"):format(Message, Name), Delay = math.huge})
                else
                    warn(("[ERROR] | An error has occurred:\n%s\nName: %s"):format(Message, Name))
                end
                -- separator
                Library.Errors[Message] = Message
                -- separator
                if Table[Connection] then
                    Table[Connection] = nil
                end
                -- separator
                return Connection and Connection:Disconnect()
            end
        end)
        -- separator
        if Connection and Table then
            table.insert(Table, Connection)
        end
        -- separator
        return Connection
    end
    -- separator
    function Library:TweenObject(Object, Info, Goal, Callback)
        if not Object then return end
        -- separator
        local Tween = TweenService:Create(Object, Info, Goal)
        -- separator
        Library:Connection(Tween.Completed, Callback or function() end)
        -- separator
        Tween:Play()
        -- separator
        Library.Tweens[#Library.Tweens + 1] = Tween
    end
    -- separator
    function Library:NewFlag()
        Library.UnnamedFlags += 1
        -- separator
        return ("UnknownFlag%s"):format(tostring(Library.UnnamedFlags))
    end
    -- separator
    function Library:ClampString(String, MaxWidth)
        local Clamped = String
        -- separator
        local TextLabel = Library:CreateObject("TextLabel", {
            FontFace = Library.UI.NewFont,
            TextStrokeTransparency = 0,
            Text = String,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextScaled = false,
            TextWrapped = false,
            Visible = false,
            TextSize = Library.UI.FontSize,
            Parent = Client.PlayerGui
        })
        -- separator
        if TextLabel.TextBounds.X <= MaxWidth then
            TextLabel:Destroy()
            -- separator
            return String
        end
        -- separator
        while TextLabel.TextBounds.X > MaxWidth and #Clamped > 0 do
            Clamped = Clamped:sub(1, #Clamped - 1)
            -- separator
            TextLabel.Text = Clamped .. "..."
            -- separator
            task.wait()
        end
        -- separator
        TextLabel:Destroy()
        -- separator
        return Clamped .. "..."
    end
    -- separator
    function Library:GetConfig()
        local Config = {}
        -- separator
        for Index, Value in Library.Flags do
            if Value.Get and not string.find(Index, "_Status") then
                if typeof(Value:Get()) == "table" and Value:Get().Color and Value:Get().Transparency then
                    local Transparency = Value:Get().Transparency
                    local Hue, Saturation, Value = Value:Get().Color:ToHSV()
                    -- separator
                    Config[Index] = {Hue, Saturation, Value, Transparency}
                else
                    Config[Index] = Value:Get()
                end
            end
        end
        -- separator
        return HttpService:JSONEncode(Config)
    end
    -- separator
    function Library:LoadConfig(Config)
        local Config = HttpService:JSONDecode(Config)
        -- separator
        for Index, Value in Config do
            if Library.Flags[Index] and Library.Flags[Index].Set then
                Library.Flags[Index]:Set(Value)
            end
        end
    end
    -- separator
    function Library:SectionDragging(Frame)
        local MousePosition = UserInputService:GetMouseLocation()
        local Position = Frame.AbsolutePosition
        local Size = Frame.AbsoluteSize
        -- separator
        local InsideX = MousePosition.X >= Position.X and MousePosition.X <= Position.X + Size.X
        local InsideY = MousePosition.Y >= Position.Y and MousePosition.Y <= Position.Y + Size.Y
        -- separator
        return InsideX and InsideY
    end
    -- separator
    function Library:CreateObject(Type, Properties, Hidden)
        local Hidden = Hidden or false
        local Object = Instance.new(Type)
        -- separator
        for Index, Value in Properties do
            if (not RunService:IsStudio()) and Index == "Name" and not string.match(Value, "%d") then
                Value = "\0"
            end
            -- separator
            if Index == "TextStrokeTransparency" and Value == 0 then
                local Stroke = Instance.new("UIStroke")
                -- separator
                Stroke.Parent = Object
                Stroke.LineJoinMode = Enum.LineJoinMode.Miter
                -- separator
                Library.Objects[Stroke] = {Stroke, {Parent = Object, LineJoinMode = Enum.LineJoinMode.Miter}, Hidden}
            else
                Object[Index] = Value
            end
        end
        -- separator
        Library.Objects[Object] = {Object, Properties, Hidden}
        -- separator
        return Object
    end
    -- separator
    function Library:AddTheme(Object, Properties)
        for Index, Value in Properties do
            Library.Theme.Objects[Object] = Library.Theme.Objects[Object] or {}
            Library.Theme.Objects[Object][Index] = Value
        end
    end
    -- separator
    function Library:GetTableIndexes(Table, Custom)
        local Table2 = {}
        -- separator
        for Index, Value in Table do
            Table2[Custom and Value[1] or #Table2 + 1] = Index 
        end
        -- separator
        return Table2
    end
    -- separator
    function Library:UpdateConfigList(List, Type)
        for _, File in listfiles("gamesense/Configs") do
            local FileName = File:gsub("\\", "/"):gsub("gamesense/Configs/", ""):gsub(".cfg", "")
            -- separator
            if Type == "Remove" then
                List:RemoveValue(FileName)
            else
                List:AddValue(FileName)
            end
        end
    end
    -- separator
    function Library:GetObjectsTable(MainUI, AddMain, Ignored)
        local AddMain = AddMain or false
        local Ignored = Ignored or {}
        local DescendantTable = {}
        local NewTable = {}
        -- separator
        for _, Descendant in MainUI:GetDescendants() do
            if table.find(Ignored, Descendant) then continue end
            -- separator
            DescendantTable[#DescendantTable + 1] = Descendant
        end
        -- separator
        if AddMain then
            DescendantTable[#DescendantTable + 1] = MainUI
        end
        -- separator
        for _, Descendant in DescendantTable do
            local Found = Library.Objects[Descendant]
            -- separator
            if Found then
                local Properties = Found[2]
                local HiddenValue = Found[3]
                -- separator
                NewTable[#NewTable + 1] = {Descendant, Properties, HiddenValue}
            end
        end
        -- separator
        return NewTable
    end
    -- separator
    function Library:SetTableVisible(Table, State, Ignored)
        local Ignored = Ignored or {}
        -- separator
        for _, Object in Table do
            if table.find(Ignored, Object) then continue end
            -- separator
            if typeof(Object) == "table" and Object.SetVisible then 
                Object:SetVisible(State)
            end
        end
    end
    -- separator
    function Library:UpdateColor(ColorType, ColorValue)
        Library.Theme.Default[ColorType] = ColorValue
        -- separator
        for Object, Properties in Library.Theme.Objects do
            for Property, ThemeKeys in Properties do
                if typeof(ThemeKeys) == "table" then
                    if Object:IsA("UIGradient") and Property == "Color" then
                        if Library.Theme.Default[ThemeKeys[1]] then
                            Object.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Library.Theme.Default[ThemeKeys[1]]), ColorSequenceKeypoint.new(1, Library.Theme.Default[ThemeKeys[2]])}
                        end
                    end
                else
                    if ThemeKeys == ColorType then
                        Object[Property] = Library.Theme.Default[ThemeKeys]
                    end
                end
            end
        end
    end
    -- separator
    function Library:ViewPlayer(Player)
        if not Library.UI.Viewing then
            Camera.CameraSubject = Player.Character.Humanoid
        else
            Camera.CameraSubject = Client.Character.Humanoid
        end
        -- separator
        Library.UI.Viewing = not Library.UI.Viewing
    end
    -- separator
    function Library:GetTableLength(Table)
        local Length = 0
        -- separator
        for Index, Value in pairs(Table) do
            Length += 1
        end
        -- separator
        return Length
    end
    -- separator
    function Library:ScrollingCheck(ScrollingFrame, Frame)
        if not ScrollingFrame:IsA("ScrollingFrame") then return true end
        -- separator
        local VisibleTopLeft = ScrollingFrame.CanvasPosition
        local VisibleBottomRight = VisibleTopLeft + ScrollingFrame.AbsoluteWindowSize
        -- separator
        local FrameTopLeft = Frame.AbsolutePosition - ScrollingFrame.AbsolutePosition + ScrollingFrame.CanvasPosition
        local FrameBottomRight = FrameTopLeft + Frame.AbsoluteSize
        -- separator
        return FrameBottomRight.X > VisibleTopLeft.X and FrameTopLeft.X < VisibleBottomRight.X and FrameBottomRight.Y > VisibleTopLeft.Y and FrameTopLeft.Y < VisibleBottomRight.Y
    end
    -- separator
    function Library:ClampPosition(Object, Position, Offset)
        local ClampedX = math.clamp(Position.X.Offset, Offset, Viewport.X - Object.AbsoluteSize.X - Offset)
        local ClampedY = math.clamp(Position.Y.Offset, Offset, Viewport.Y - Object.AbsoluteSize.Y - Offset)
        -- separator
        return UDim2.new(Position.X.Scale, ClampedX, Position.Y.Scale, ClampedY)
    end
    -- separator
    function Library:Fade(State, Table, MainUI, Speed)
        local IsMainUI = Table == Library.Objects
        -- separator
        MainUI.Active = State
        -- separator
        if State then
            MainUI.Visible = true
        end
        -- separator
        if IsMainUI then
            Library.UI.Faded = not State
        end
        --  handle toggle transparency when fading out since im not using fade out for now as it causes fps issues
        if not State and IsMainUI then
            -- find all toggle elements and force them transparent immediately instead of waiting since some things may not leave instantly
            for _, obj in pairs(MainUI:GetDescendants()) do
                if obj.ClassName == "Frame" then
                    if obj.Name == "ToggleMain" then
                        obj.BackgroundTransparency = 1
                    end
                end
            end
        end
        -- separator
        for _, Object in Table do
            if not Object[3] then
                if Object[1].ClassName == "Frame" and (Object[2]["BackgroundTransparency"] or 0) ~= 1 then
                    -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1})
                    Object[1].BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1
                elseif Object[1].ClassName == "ImageLabel" or Object[1].ClassName == "ImageButton" then
                    if (Object[2]["BackgroundTransparency"] or 0) ~= 1 then
                        -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1})
                        Object[1].BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1
                    end
                    -- separator
                    if (Object[2]["ImageTransparency"] or 0) ~= 1 then
                        -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {ImageTransparency = State and (Object[2]["ImageTransparency"] or 0) or 1})
                        Object[1].ImageTransparency = State and (Object[2]["ImageTransparency"] or 0) or 1
                    end
                elseif Object[1].ClassName == "TextLabel" or Object[1].ClassName == "TextButton" or Object[1].ClassName == "TextBox" then
                    if (Object[2]["BackgroundTransparency"] or 0) ~= 1 then
                        -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1})
                        Object[1].BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1
                    end
                    -- separator
                    if (Object[2]["TextTransparency"] or 0) ~= 1 then
                        -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {TextTransparency = State and (Object[2]["TextTransparency"] or 0) or 1})
                        Object[1].TextTransparency = State and (Object[2]["TextTransparency"] or 0) or 1
                    end
                elseif Object[1].ClassName == "ScrollingFrame" then
                    if (Object[2]["BackgroundTransparency"] or 0) ~= 1 then
                        -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1})
                        Object[1].BackgroundTransparency = State and (Object[2]["BackgroundTransparency"] or 0) or 1
                    end
                    -- separator
                    if (Object[2]["ScrollBarImageTransparency"] or 0) ~= 1 then
                        -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {ScrollBarImageTransparency = State and (Object[2]["ScrollBarImageTransparency"] or 0) or 1})
                        Object[1].ScrollBarImageTransparency = State and (Object[2]["ScrollBarImageTransparency"] or 0) or 1
                    end
                elseif Object[1].ClassName == "UIStroke" then
                    -- Library:TweenObject(Object[1], TweenInfo.new(Speed, Enum.EasingStyle.Linear, State and Enum.EasingDirection["Out"] or Enum.EasingDirection["In"]), {Transparency = State and (Object[2]["Transparency"] or 0) or 1})
                    Object[1].Transparency = State and (Object[2]["Transparency"] or 0) or 1
                end
            end
        end
        -- separator
        if not State then
            task.delay(Speed, function()
                if not MainUI.Parent then return end
                MainUI.Visible = false
            end)
        end
    end
    -- separator
    function Library:CheckFrameFirst(FrameA, FrameB)
        local Parent = FrameA.Parent
        local Frames = {}
        local IndexA, IndexB
        -- separator
        for _, Child in Parent:GetChildren() do
            if Child:IsA("Frame") then
                table.insert(Frames, Child)
            end
        end
        -- separator
        table.sort(Frames, function(a, b)
            if a.LayoutOrder == b.LayoutOrder then
                for _, Child in Parent:GetChildren() do
                    if Child == a then return true end
                    if Child == b then return false end
                end
            end
            -- separator
            return a.LayoutOrder < b.LayoutOrder
        end)
        -- separator
        for i, Frame in Frames do
            if Frame == FrameA then IndexA = i end
            if Frame == FrameB then IndexB = i end
        end
        -- separator
        return IndexA and IndexB and IndexA < IndexB
    end
    -- separator
    function Library:Resizable(Object, DragFrame, MinResize, MaxResize, Increments, UseIcon, UseParent, Delay)
        local StartingSize, ObjectSize, Dragging, MouseLocation, PerformanceDragUI, NewMouse, Hovering
        -- separator
        local function UpdateSize()
            if not MouseLocation then return end
            -- separator
            Library.UI.Resizing = true
            -- separator
            local CurrentMousePosition = UserInputService:GetMouseLocation()
            local Delta = CurrentMousePosition - MouseLocation
            local NewSizeX = StartingSize.X.Offset + Delta.X
            local NewSizeY = StartingSize.Y.Offset + Delta.Y
            local Parent = Object.Parent
            local ParentSize = Parent.AbsoluteSize
            -- separator
            if UseParent then
                local OccupiedSpaceY = 0
                local FrameCount = 0
                -- separator
                for _, Child in Parent:GetChildren() do
                    if Child:IsA("Frame") and Child ~= Object then
                        FrameCount += 1
                        -- separator
                        if Library:CheckFrameFirst(Object, Child) then
                            if Child.AbsoluteSize.Y >= (ParentSize.Y - Object.AbsoluteSize.Y) - 57 then
                                Child.Size = UDim2.new(Child.Size.X.Scale, Child.Size.X.Offset, 0, math.max(50, (ParentSize.Y - Object.AbsoluteSize.Y) - 57))
                            end
                        else
                            OccupiedSpaceY += Child.AbsoluteSize.Y + 19
                        end
                    end
                end
                -- separator
                if OccupiedSpaceY == 0 then
                    MaxResize = UDim2.new(0, 0, 0, (ParentSize.Y - OccupiedSpaceY) - (FrameCount * (50 + 19)) - 38)
                else
                    MaxResize = UDim2.new(0, 0, 0, (ParentSize.Y - OccupiedSpaceY) - 38)
                end
            end
            -- separator
            if Increments then
                NewSizeY = math.clamp(math.round(NewSizeY / Increments) * Increments, MinResize.Y.Offset, MaxResize.Y.Offset)
            else
                NewSizeY = math.clamp(NewSizeY, MinResize.Y.Offset, MaxResize.Y.Offset)
                NewSizeX = math.clamp(NewSizeX, MinResize.X.Offset, MaxResize.X.Offset)
            end
            -- separator
            return UseParent and UDim2.new(1, 0, 0, NewSizeY) or UDim2.new(0, NewSizeX, 0, NewSizeY)
        end
        
        -- separator
        Library:Connection(DragFrame.MouseEnter, function()
            Hovering = true
        end)
        -- separator
        Library:Connection(DragFrame.MouseLeave, function()
            if NewMouse then NewMouse:Destroy() NewMouse = nil end
            -- separator
            UserInputService.MouseIconEnabled = true
            Hovering = false
        end)
        -- separator
        Library:Connection(DragFrame.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                MouseLocation = UserInputService:GetMouseLocation()
                StartingSize = Object.Size
            end
        end)
        -- separator
        Library:Connection(RunService.PreRender, function()
            if (Hovering or Dragging) and UseIcon then
                local MousePosition = UserInputService:GetMouseLocation()
                -- separator
                UserInputService.MouseIconEnabled = false
                -- separator
                if not NewMouse then
                    NewMouse = Library:CreateObject("ImageLabel", {
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Image = "rbxassetid://87982048533100",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Name = "Transparency",
                        Size = UDim2.new(0, 35, 0, 35),
                        ZIndex = 10000,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = Library.UI.ScreenGUI
                    }, true)
                end
                -- separator
                NewMouse.Position = UDim2.new(0, MousePosition.X, 0, MousePosition.Y)
            end
            -- separator
            if Dragging then
                if Delay then task.delay(Delay, function()
                        Object.Size = UpdateSize()
                    end)
                else
                    Object.Size = UpdateSize()
                end
            end
        end)
        -- separator
        Library:Connection(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and Dragging then
                if NewMouse then NewMouse:Destroy() NewMouse = nil end
                -- separator
                if UseParent then
                    for _, Child in Object.Parent:GetChildren() do
                        if Child:IsA("Frame") and Child ~= Object then
                            if Library:CheckFrameFirst(Object, Child) then
                                if Child.AbsoluteSize.Y >= (Object.Parent.AbsoluteSize.Y - Object.AbsoluteSize.Y) - 57 then
                                    Child.Size = UDim2.new(Child.Size.X.Scale, Child.Size.X.Offset, 0, math.max(50, (Object.Parent.AbsoluteSize.Y - Object.AbsoluteSize.Y) - 57))
                                end
                            end
                        end
                    end
                end
                -- separator
                UserInputService.MouseIconEnabled = true
                Dragging = false
                Library.UI.Resizing = false
            end
        end)
    end
    -- separator
    Library.__index = Library
    Library.Sections.__index = Library.Sections
    -- separator
    local Sections = Library.Sections
    -- separator
    function Library:ColorPicker(Options)
        Options = Library:Validate({
            Name = "Preview Color Picker",
            Default = Library.Theme.Default.Accent,
            Alpha = 0,
            AlphaBar = true,
            Parent = nil,
            MainUI = nil,
            TabUI = nil,
            Count = 1,
            Keybind = false,
            Flag = Library:NewFlag(),
            Callback = function() end,
        }, Options or {})
        -- separator
        local Hue, Saturation, Value = Options.Default:ToHSV()
        -- separator
        local ColorPicker = {
            Hover = false,
            Active = false,
            MouseDown = false,
            MainFrameHover = false,
            Color = Options.Default,
            SecondColor = Color3.fromRGB(math.max(math.floor(Options.Default.R * 255) - 14, 0), math.max(math.floor(Options.Default.G * 255) - 14, 0), math.max(math.floor(Options.Default.B * 255) - 14, 0)),
            Saturation = {Saturation, Value},
            Alpha = Options.Alpha,
            Hue = Hue,
            ActiveFrame = false,
            LastCopiedColor = {self.Color, self.Alpha},
            FrameOpened = false,
        }
        -- separator
        Library.Flags[Options.Flag] = ColorPicker
        -- separator
        Library.UI.TotalColorPickers += 1
        -- separator
        if Options.Keybind then
            Options.Count += 1
        end
        -- separator
        local ColorPickerOutline_1 = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            Name = "ColorPickerOutline" .. Library.UI.TotalColorPickers,
            Position = UDim2.new(1, 0 - (Options.Count - 1) * 22, 0, 0),
            Size = UDim2.new(0, 17, 0, 9),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = Options.Parent
        })
        -- separator
        local ColorPickerChecker = Library:CreateObject("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 4),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 0, 0, 1),
            Visible = false,
            BorderSizePixel = 0,
            Parent = ColorPickerOutline_1
        })
        -- separator
        local Button_9 = Library:CreateObject("TextButton", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_9",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ColorPickerOutline_1
        })
        -- separator
        local ColorPickerTransparency = Library:CreateObject("ImageLabel", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Image = "rbxassetid://18249241978",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Name = "Transparency",
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1),
            BorderSizePixel = 0,
            ZIndex = 3,
            ScaleType = Enum.ScaleType.Tile,
            TileSize = UDim2.new(0, 6, 0, 6),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ColorPickerOutline_1
        })
        -- separator
        local ColorPickerInline_1 = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "ColorPickerInline_1",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ColorPickerOutline_1
        })
        -- separator
        local UIGradient_24 = Library:CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, ColorPicker.Color),
                ColorSequenceKeypoint.new(1, ColorPicker.SecondColor)
            },
            Parent = ColorPickerInline_1
        })
        -- separator
        do -- Functions
            function ColorPicker:SetVisible(Bool)
                ColorPickerOutline_1.Visible = Bool
                -- separator
                if Bool == false then
                    ColorPicker:RemoveFrame()
                end
            end
            -- separator
            function ColorPicker:AddFrame()
                Library.UI.CurrentSelectedColorPicker = {ColorPicker = ColorPicker, ColorPickerOutline = ColorPickerOutline_1, Parent = Options.Parent}
                -- separator
                Library.UI.OpenColorFrames += 1
                -- separator
                local ColorPickerOutline = Library:CreateObject("Frame", {
                    Size = UDim2.new(0, 180, 0, 175),
                    Name = "ColorPickerFrame" .. Library.UI.TotalColorPickers,
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = Library.UI.ScreenGUI
                })
                -- separator
                ColorPickerOutline.BackgroundTransparency = 1
                -- separator
                local ColorPickerInline = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "ColorPickerInline",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                    Parent = ColorPickerOutline
                })
                -- separator
                ColorPickerInline.BackgroundTransparency = 1
                -- separator
                local ColorPickerMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "ColorPickerMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    Parent = ColorPickerInline
                })
                -- separator
                ColorPickerMain.BackgroundTransparency = 1
                -- separator
                local MainPicker = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -24, 1, -19),
                    Name = "MainPicker",
                    Position = UDim2.new(0, 2, 0, 2),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = ColorPickerMain
                })
                -- separator
                MainPicker.BackgroundTransparency = 1
                -- separator
                local Button_91 = Library:CreateObject("TextButton", {
                    FontFace = Library.UI.NewFont,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_9",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    ZIndex = 250,
                    TextSize = Library.UI.FontSize,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = MainPicker
                })
                -- separator
                local MainPickerColor = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "MainPickerColor",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = MainPicker
                })
                -- separator
                MainPickerColor.BackgroundTransparency = 1
                -- separator
                local UIGradient_20 = Library:CreateObject("UIGradient", {
                    Rotation = 180,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                    },
                    Parent = MainPickerColor
                })
                -- separator
                local BackImage = Library:CreateObject("ImageLabel", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Image = "rbxassetid://13966897785",
                    BackgroundTransparency = 1,
                    Name = "BackImage",
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    Parent = MainPickerColor
                })
                -- separator
                BackImage.ImageTransparency = 1
                -- separator
                local DraggingMainOutline = Library:CreateObject("Frame", {
                    Size = UDim2.new(0, 4, 0, 4),
                    Name = "DraggingMainOutline",
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = MainPicker
                })
                -- separator
                DraggingMainOutline.BackgroundTransparency = 1
                -- separator
                local DraggingMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "DraggingMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = DraggingMainOutline
                })
                -- separator
                DraggingMain.BackgroundTransparency = 1
                -- separator
                local SaturationSlider = Library:CreateObject("Frame", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(0, 1),
                    Name = "SaturationSlider",
                    Position = UDim2.new(0, 2, 1, -2),
                    Size = UDim2.new(1, -24, 0, 12),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = ColorPickerMain
                })
                -- separator
                SaturationSlider.BackgroundTransparency = 1
                -- separator
                local Button_915241 = Library:CreateObject("TextButton", {
                    FontFace = Library.UI.NewFont,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_9",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    ZIndex = 250,
                    TextSize = Library.UI.FontSize,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = SaturationSlider
                })
                -- separator
                local SaturationColor = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "SaturationColor",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = SaturationSlider
                })
                -- separator
                SaturationColor.BackgroundTransparency = 1
                -- separator
                local UIGradient_21 = Library:CreateObject("UIGradient", {
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                    },
                    Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 0.10000000149011612),
                        NumberSequenceKeypoint.new(0.5, 0.800000011920929),
                        NumberSequenceKeypoint.new(1, 1)
                    },
                    Rotation = 180,
                    Parent = SaturationColor
                })
                -- separator
                local BackImage_1 = Library:CreateObject("ImageLabel", {
                    ScaleType = Enum.ScaleType.Tile,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "BackImage_1",
                    TileSize = UDim2.new(0, 12, 0, 12),
                    Image = "rbxassetid://18249241978",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    Parent = SaturationSlider
                })
                -- separator
                BackImage_1.ImageTransparency = 1
                -- separator
                local DraggingSatOutline = Library:CreateObject("Frame", {
                    Size = UDim2.new(0, 4, 1, 0),
                    Name = "DraggingSatOutline",
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = SaturationSlider
                })
                -- separator
                DraggingSatOutline.BackgroundTransparency = 1
                -- separator
                local DraggingSatMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "DraggingSatMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = DraggingSatOutline
                })
                -- separator
                DraggingSatMain.BackgroundTransparency = 1
                -- separator
                local HueSlider = Library:CreateObject("Frame", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    Name = "HueSlider",
                    Position = UDim2.new(1, -2, 0, 2),
                    Size = UDim2.new(0, 17, 1, -19),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = ColorPickerMain
                })
                -- separator
                HueSlider.BackgroundTransparency = 1
                -- separator
                local Button_9141 = Library:CreateObject("TextButton", {
                    FontFace = Library.UI.NewFont,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_9",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    ZIndex = 250,
                    TextSize = Library.UI.FontSize,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = HueSlider
                })
                -- separator
                local BackImage_2 = Library:CreateObject("ImageLabel", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "BackImage_2",
                    TileSize = UDim2.new(0, 12, 0, 12),
                    Image = "rbxassetid://8180989234",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    ZIndex = 250,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    Parent = HueSlider
                })
                -- separator
                BackImage_2.ImageTransparency = 1
                -- separator
                local DraggingHueOutline = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, 0, 0, 4),
                    Name = "DraggingHueOutline",
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = HueSlider
                })
                -- separator
                DraggingHueOutline.BackgroundTransparency = 1
                -- separator
                local DraggingHueMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "DraggingHueMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 251,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = DraggingHueOutline
                })
                -- separator
                DraggingHueMain.BackgroundTransparency = 1
                -- separator
                do -- Functions
                    function ColorPicker:UpdateSize()
                        ColorPickerOutline.Position = UDim2.new(0, ColorPickerOutline_1.AbsolutePosition.X, 0, (ColorPickerOutline_1.AbsolutePosition.Y + ColorPickerOutline_1.AbsoluteSize.Y + GuiService:GetGuiInset().Y + 2))
                    end
                    -- separator
                    ColorPicker:UpdateSize()
                    -- separator
                    Library:Connection(Options.MainUI:GetPropertyChangedSignal("AbsolutePosition"), ColorPicker.UpdateSize)
                    -- separator
                    local StartingY = ColorPickerOutline_1.AbsolutePosition.Y
                    local MainUIStartingY = Options.MainUI.AbsolutePosition.Y
                    local StartingCanvasPosition = Options.Parent.Parent.CanvasPosition
                    -- separator
                    Library:Connection(ColorPickerOutline_1:GetPropertyChangedSignal("AbsolutePosition"), function()
                        local CurrentY = ColorPickerOutline_1.AbsolutePosition.Y
                        local MainUICurrentY = Options.MainUI.AbsolutePosition.Y
                        local CurrentCanvasPosition = Options.Parent.Parent.CanvasPosition
                        -- separator
                        if MainUICurrentY ~= MainUIStartingY then
                            MainUIStartingY = MainUICurrentY
                            StartingY = CurrentY
                            -- separator
                            return
                        end
                        -- separator
                        if CurrentCanvasPosition ~= StartingCanvasPosition then
                            StartingCanvasPosition = CurrentCanvasPosition
                            StartingY = CurrentY
                            -- separator
                            return
                        end
                        -- separator
                        if Library.UI.Resizing then
                            return
                        end
                        -- separator
                        if CurrentY ~= StartingY then
                            ColorPicker:RemoveFrame(true)
                        end
                        -- separator
                        StartingY = CurrentY
                    end)
                    -- separator
                    Library:Connection(Options.MainUI:GetPropertyChangedSignal("AbsoluteSize"), function()
                        if ColorPicker.Active then
                            ColorPickerOutline.Visible = Library:ScrollingCheck(Options.Parent.Parent, ColorPickerChecker)
                        end
                        -- separator
                        ColorPicker:UpdateSize()
                    end)
                    -- separator
                    if Options.Parent.Parent:IsA("ScrollingFrame") then
                        Library:Connection(Options.Parent.Parent:GetPropertyChangedSignal("CanvasPosition"), function()
                            ColorPicker:UpdateSize()
                            -- separator
                            if ColorPicker.Active then
                                ColorPickerOutline.Visible = Library:ScrollingCheck(Options.Parent.Parent, ColorPickerChecker)
                            end
                        end)
                    end
                    -- separator
                    Library:Connection(Options.MainUI:GetPropertyChangedSignal("Visible"), function()
                        if not Options.MainUI.Visible then
                            ColorPickerOutline.Visible = false
                        else
                            ColorPickerOutline.Visible = ColorPicker.Active
                        end
                    end)
                    -- separator
                    Library:Connection(Options.Parent.Parent:GetPropertyChangedSignal("Visible"), function()
                        if not Options.Parent.Parent.Visible then
                            ColorPickerOutline.Visible = false
                        else
                            ColorPickerOutline.Visible = ColorPicker.Active
                        end
                    end)
                    -- separator
                    function ColorPicker:Update()
                        ColorPicker.Color = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Saturation[1], ColorPicker.Saturation[2])
                        ColorPicker.SecondColor = Color3.fromRGB(math.max(math.floor(ColorPicker.Color.R * 255) - 23, 0), math.max(math.floor(ColorPicker.Color.G * 255) - 23, 0), math.max(math.floor(ColorPicker.Color.B * 255) - 23, 0))
                        -- separator
                        UIGradient_24.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorPicker.Color), ColorSequenceKeypoint.new(1, ColorPicker.SecondColor)}
                        UIGradient_20.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorPicker.Color), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))}
                        UIGradient_21.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ColorPicker.Color), ColorSequenceKeypoint.new(1, ColorPicker.Color)}
                        UIGradient_20.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromHSV(ColorPicker.Hue, 1, 1)), ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 255, 255))}
                        -- separator
                        local MaxSaturationX = math.max(0, MainPickerColor.AbsoluteSize.X - DraggingMainOutline.AbsoluteSize.X) / MainPickerColor.AbsoluteSize.X
                        local MaxSaturationY = math.max(0, MainPickerColor.AbsoluteSize.Y - DraggingMainOutline.AbsoluteSize.Y) / MainPickerColor.AbsoluteSize.Y
                        local MaxAlpha = math.max(0, SaturationColor.AbsoluteSize.X - DraggingSatOutline.AbsoluteSize.X) / SaturationColor.AbsoluteSize.X
                        local MaxHue = math.max(0, BackImage_2.AbsoluteSize.Y - DraggingHueOutline.AbsoluteSize.Y) / BackImage_2.AbsoluteSize.Y
                        -- separator
                        Library:TweenObject(DraggingMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromScale(math.clamp(ColorPicker.Saturation[1], 0, MaxSaturationX), math.clamp(1 - ColorPicker.Saturation[2], 0, MaxSaturationY))})
                        Library:TweenObject(DraggingSatOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(math.clamp(1 - ColorPicker.Alpha, 0, MaxAlpha), 0, 0, 0)})
                        Library:TweenObject(DraggingHueOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, math.clamp(ColorPicker.Hue, 0, MaxHue), 0)})
                        -- separator
                        DraggingMain.BackgroundColor3 = ColorPicker.Color
                        DraggingSatMain.BackgroundColor3 = ColorPicker.Color
                        DraggingHueMain.BackgroundColor3 = ColorPicker.Color
                        ColorPickerInline_1.BackgroundTransparency = ColorPicker.Alpha
                        UIGradient_21.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0.304 + (0.604 - 0.304) * ColorPicker.Alpha), NumberSequenceKeypoint.new(0.5, 0.7), NumberSequenceKeypoint.new(1, 1)}
                        -- separator
                        Options.Callback(ColorPicker.Color, ColorPicker.Alpha)
                        Library.Flags[Options.Flag] = ColorPicker
                    end
                    -- separator
                    function ColorPicker:Set(Color, Transparency)
                        if typeof(Color) == "table" then
                            ColorPicker.Color = Color3.fromHSV(Color[1], Color[2], Color[3])
                            ColorPicker.Alpha = Color[4]
                            ColorPicker.Hue = Color[1]
                            ColorPicker.Saturation[1] = Color[2]
                            ColorPicker.Saturation[2] = Color[3]
                            ColorPicker:Update()
                            Options.Callback(ColorPicker.Color, ColorPicker.Alpha)
                        elseif typeof(Color) == "Color3" then
                            local h, s, v = Color:ToHSV()
                            -- separator
                            ColorPicker.Color = Color3.fromHSV(h, s, v)
                            ColorPicker.Alpha = Transparency or 1
                            ColorPicker.Hue = h
                            ColorPicker.Saturation[1] = s
                            ColorPicker.Saturation[2] = v
                            ColorPicker:Update()
                            Options.Callback(ColorPicker.Color, ColorPicker.Alpha)
                        end
                    end
                    -- separator
                    function ColorPicker:Get()
                        return {Color = ColorPicker.Color, Transparency = ColorPicker.Alpha}
                    end
                    -- separator
                    function ColorPicker:UpdateHue(Percentage)
                        local Percentage = typeof(Percentage == "number") and math.clamp(Percentage, 0, 1) or 0
                        -- separator
                        ColorPicker.Hue = Percentage
                        -- separator
                        ColorPicker:Update()
                    end
                    -- separator
                    function ColorPicker:UpdateAlpha(Percentage)
                        local Percentage = typeof(Percentage == "number") and math.clamp(Percentage, 0, 1) or 0
                        -- separator
                        ColorPicker.Alpha = Percentage
                        -- separator
                        ColorPicker:Update()
                    end
                    -- separator
                    function ColorPicker:UpdateSaturation(PercentageX, PercentageY)
                        local PercentageX = typeof(PercentageX == "number") and math.clamp(PercentageX, 0, 1) or 0
                        local PercentageY = typeof(PercentageY == "number") and math.clamp(PercentageY, 0, 1) or 0
                        -- separator
                        ColorPicker.Saturation[1] = PercentageX
                        ColorPicker.Saturation[2] = 1 - PercentageY
                        -- separator
                        ColorPicker:Update()
                    end
                end
                -- separator
                do -- Connections
                    Library:Connection(Button_91.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Library.UI.DraggingGui = MainPickerColor
                            -- separator
                            local InputPosition = Vector2.new(Input.Position.X, Input.Position.Y)
                            local Percentage = (InputPosition - MainPickerColor.AbsolutePosition) / MainPickerColor.AbsoluteSize
                            -- separator
                            ColorPicker:UpdateSaturation(Percentage.X, Percentage.Y)
                        end
                    end)
                    -- separator
                    Library:Connection(Button_915241.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Library.UI.DraggingGui = SaturationColor
                            -- separator
                            local InputPosition = Vector2.new(Input.Position.X, Input.Position.Y)
                            local GuiPosition = SaturationColor.AbsolutePosition.X
                            local GuiSize = SaturationColor.AbsoluteSize.X
                            local Percentage = ((GuiPosition + GuiSize - InputPosition.X) / GuiSize)
                            -- separator
                            ColorPicker:UpdateAlpha(Percentage)
                        end
                    end)
                    -- separator
                    Library:Connection(Button_9141.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Library.UI.DraggingGui = BackImage_2
                            -- separator
                            local InputPosition = Vector2.new(Input.Position.X, Input.Position.Y)
                            local Percentage = (InputPosition - BackImage_2.AbsolutePosition) / BackImage_2.AbsoluteSize
                            -- separator
                            ColorPicker:UpdateHue(Percentage.Y)
                        end
                    end)
                    -- separator
                    Library:Connection(UserInputService.InputChanged, function(Input)
                        if (Library.UI.DraggingGui ~= SaturationColor and Library.UI.DraggingGui ~= MainPickerColor and Library.UI.DraggingGui ~= BackImage_2) then return end
                        -- separator
                        if not (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                            Library.UI.DraggingGui = nil
                            return
                        end
                        -- separator
                        local InputPosition = Vector2.new(Input.Position.X, Input.Position.Y)
                        -- separator
                        if (Input.UserInputType == Enum.UserInputType.MouseMovement) then
                            if Library.UI.DraggingGui == MainPickerColor then
                                local Percentage = (InputPosition - MainPickerColor.AbsolutePosition) / MainPickerColor.AbsoluteSize
                                -- separator
                                ColorPicker:UpdateSaturation(Percentage.X, Percentage.Y)
                            end
                            -- separator
                            if Library.UI.DraggingGui == SaturationColor then
                                local GuiPosition = SaturationColor.AbsolutePosition.X
                                local GuiSize = SaturationColor.AbsoluteSize.X
                                local Percentage = ((GuiPosition + GuiSize - InputPosition.X) / GuiSize)
                                -- separator
                                ColorPicker:UpdateAlpha(Percentage)
                            end
                            -- separator
                            if Library.UI.DraggingGui == BackImage_2 then
                                local Percentage = (InputPosition - BackImage_2.AbsolutePosition) / BackImage_2.AbsoluteSize
                                -- separator
                                ColorPicker:UpdateHue(Percentage.Y)
                            end
                        end
                    end)
                end
                -- separator
                ColorPicker:Update()
                Library:Fade(true, Library:GetObjectsTable(ColorPickerOutline, true), ColorPickerOutline, 0.1)
            end
            -- separator
            function ColorPicker:RemoveFrame(Fast)
                local Fast = Fast or false
                -- separator
                for Index, Value in Library.UI.ScreenGUI:GetChildren() do
                    if Value:IsA("Frame") and Value.Name == "ColorPickerFrame" .. Library.UI.TotalColorPickers then
                        if Fast then
                            Value:Destroy()
                        else
                            Library:Fade(false, Library:GetObjectsTable(Value, true), Value, 0.1)
                            -- separator
                            task.delay(Library.UI.TweenSpeed, function()
                                Value:Destroy()
                            end)
                        end
                    end
                end
            end
            -- separator
            function ColorPicker:FindFrame()
                for Index, Value in Library.UI.ScreenGUI:GetChildren() do
                    if Value:IsA("Frame") and Value.Name == "ColorPickerFrame" .. Library.UI.TotalColorPickers then
                        return true
                    end
                end
                -- separator
                return false
            end
            -- separator
            function ColorPicker:Toggle()
                if Library.UI.CurrentSelectedColorPicker and Library.UI.CurrentSelectedColorPicker.ColorPickerOutline.Name ~= ColorPickerOutline_1.Name then
                    Library.UI.CurrentSelectedColorPicker.ColorPicker:RemoveFrame()
                end
                -- separator
                if not ColorPicker:FindFrame() then
                    ColorPicker.Active = true
                    ColorPicker:AddFrame()
                else
                    ColorPicker.Active = false
                    ColorPicker:RemoveFrame()
                end
            end
            -- separator
            function ColorPicker:AddOtherFrame()
                Library.UI.CurrentSelectedColorPickerExtra = {ColorPicker = ColorPicker, ColorPickerObject = ColorPickerOutline_1, Parent = Options.Parent}
                -- separator
                local KeybindModePickerOutline = Library:CreateObject("Frame", {
                    Name = "ColorPickerOutline" .. Library.UI.TotalColorPickers,
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 100, 0, 55),
                    BorderSizePixel = 0,
                    ZIndex = 25,
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = Library.UI.ScreenGUI
                })
                -- separator
                local KeybindModePickerMain = Library:CreateObject("Frame", {
                    Name = "KeybindModePickerMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    ZIndex = 25,
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Parent = KeybindModePickerOutline
                })
                -- separator
                KeybindModePickerOutline.BackgroundTransparency = 1
                KeybindModePickerMain.BackgroundTransparency = 1
                -- separator
                local UIListLayout_9 = Library:CreateObject("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = KeybindModePickerMain
                })
                -- separator
                function ColorPicker:UpdateSize()
                    KeybindModePickerOutline.Position = UDim2.new(0, ColorPickerOutline_1.AbsolutePosition.X - 2, 0, ColorPickerOutline_1.AbsolutePosition.Y + ColorPickerOutline_1.AbsoluteSize.Y + KeybindModePickerOutline.AbsoluteSize.Y - 4)
                end
                -- separator
                ColorPicker:UpdateSize()
                -- separator
                Library:Connection(Options.MainUI:GetPropertyChangedSignal("AbsolutePosition"), ColorPicker.UpdateSize)
                -- separator
                local StartingY = ColorPickerOutline_1.AbsolutePosition.Y
                local MainUIStartingY = Options.MainUI.AbsolutePosition.Y
                local StartingCanvasPosition = Options.Parent.Parent.CanvasPosition
                -- separator
                Library:Connection(ColorPickerOutline_1:GetPropertyChangedSignal("AbsolutePosition"), function()
                    local CurrentY = ColorPickerOutline_1.AbsolutePosition.Y
                    local MainUICurrentY = Options.MainUI.AbsolutePosition.Y
                    local CurrentCanvasPosition = Options.Parent.Parent.CanvasPosition
                    -- separator
                    if MainUICurrentY ~= MainUIStartingY then
                        MainUIStartingY = MainUICurrentY
                        StartingY = CurrentY
                        -- separator
                        return
                    end
                    -- separator
                    if CurrentCanvasPosition ~= StartingCanvasPosition then
                        StartingCanvasPosition = CurrentCanvasPosition
                        StartingY = CurrentY
                        -- separator
                        return
                    end
                    -- separator
                    if Library.UI.Resizing then
                        return
                    end
                    -- separator
                    if CurrentY ~= StartingY then
                        ColorPicker:RemoveOtherFrame(true)
                    end
                    -- separator
                    StartingY = CurrentY
                end)
                -- separator
                Library:Connection(Options.MainUI:GetPropertyChangedSignal("AbsoluteSize"), function()
                    if ColorPicker.ActiveFrame then
                        KeybindModePickerOutline.Visible = Library:ScrollingCheck(Options.Parent.Parent, ColorPickerChecker)
                    end
                    -- separator
                    ColorPicker:UpdateSize()
                end)
                -- separator
                if Options.Parent.Parent:IsA("ScrollingFrame") then
                    Library:Connection(Options.Parent.Parent:GetPropertyChangedSignal("CanvasPosition"), function()
                        ColorPicker:UpdateSize()
                        -- separator
                        if ColorPicker.ActiveFrame then
                            KeybindModePickerOutline.Visible = Library:ScrollingCheck(Options.Parent.Parent, ColorPickerChecker)
                        end
                    end)
                end
                -- separator
                for Index, Value in {"Copy", "Paste", "Reset"} do
                    local ModeItem = {
                        Active = false,
                        Hovering = false,
                    }
                    -- separator
                    local Inactive = Library:CreateObject("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                        TextColor3 = Color3.fromRGB(208, 208, 208),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = Value,
                        Text = Value,
                        RichText = true,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Size = UDim2.new(1, 0, 0, 17),
                        BorderSizePixel = 0,
                        TextSize = Library.UI.FontSize,
                        ZIndex = 25,
                        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                        Parent = KeybindModePickerMain
                    })
                    -- separator
                    local Button_4 = Library:CreateObject("TextButton", {
                        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Button_4",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        TextTransparency = 1,
                        TextSize = Library.UI.FontSize,
                        ZIndex = 25,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = Inactive
                    })
                    -- separator
                    local UIPadding_48 = Library:CreateObject("UIPadding", {
                        PaddingLeft = UDim.new(0, 8),
                        Parent = Inactive
                    })
                    -- separator
                    Inactive.TextTransparency = 1
                    -- separator
                    do -- Functions
                        function ModeItem:Activate()
                            if not ModeItem.Active then
                                ModeItem.Active = true
                                -- separator
                                Inactive.Text = "<b>" .. Value .. "</b>"
                                Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Library.Theme.Default.Accent})
                                -- separator
                                if Value == "Copy" then
                                    Library.UI.LastCopiedColor = {Color = ColorPicker.Color, Alpha = ColorPicker.Alpha}
                                elseif Value == "Paste" then
                                    if Library.UI.LastCopiedColor then
                                        ColorPicker:Set(Library.UI.LastCopiedColor.Color, Library.UI.LastCopiedColor.Alpha)
                                    end
                                elseif Value == "Reset" then
                                    ColorPicker:Set(Options.Default, Options.Alpha)
                                end
                                -- separator
                                ColorPicker:RemoveOtherFrame()
                            end
                        end
                        -- separator
                        function ModeItem:Deactivate()
                            if ModeItem.Active then
                                ModeItem.Active = false
                                ModeItem.Hovering = false
                                Inactive.Text = Value
                                Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                            end
                        end
                    end
                    -- separator
                    do -- Connections
                        Library:Connection(Button_4.MouseButton1Click, function()
                            ModeItem:Activate()
                        end)
                        -- separator
                        Library:Connection(Inactive.MouseEnter, function()
                            Inactive.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                            -- separator
                            if ModeItem.Active then return end
                            -- separator
                            Inactive.Text = "<b>" .. Value .. "</b>"
                        end)
                        -- separator
                        Library:Connection(Inactive.MouseLeave, function()
                            Inactive.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            -- separator
                            if ModeItem.Active then return end
                            -- separator
                            Inactive.Text = Value
                            Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                        end)
                    end
                end
                -- separator
                Library:Fade(true, Library:GetObjectsTable(KeybindModePickerOutline, true), KeybindModePickerOutline, 0.1)
            end
            -- separator
            function ColorPicker:RemoveOtherFrame(Fast)
                local Fast = Fast or false
                -- separator
                for Index, Value in Library.UI.ScreenGUI:GetChildren() do
                    if Value:IsA("Frame") and Value.Name == "ColorPickerOutline" .. Library.UI.TotalColorPickers then
                        if Fast then
                            Value:Destroy()
                        else
                            Library:Fade(false, Library:GetObjectsTable(Value, true), Value, 0.1)
                            -- separator
                            task.delay(Library.UI.TweenSpeed, function()
                                Value:Destroy()
                            end)
                        end
                    end
                end
            end
            -- separator
            function ColorPicker:FindOtherFrame()
                for Index, Value in Library.UI.ScreenGUI:GetChildren() do
                    if Value:IsA("Frame") and Value.Name == "ColorPickerOutline" .. Library.UI.TotalColorPickers then
                        return true
                    end
                end
                -- separator
                return false
            end
            -- separator
            function ColorPicker:ToggleOtherFrame()
                if Library.UI.CurrentSelectedColorPickerExtra and Library.UI.CurrentSelectedColorPickerExtra.ColorPickerObject.Name ~= ColorPickerOutline_1.Name then
                    Library.UI.CurrentSelectedColorPickerExtra.ColorPicker:RemoveFrame()
                end
                -- separator
                if not ColorPicker:FindOtherFrame() then
                    ColorPicker.ActiveFrame = true
                    ColorPicker:AddOtherFrame()
                else
                    ColorPicker.ActiveFrame = false
                    ColorPicker:RemoveOtherFrame()
                end
            end
        end
        -- separator
        do -- Connections
            Library:Connection(Button_9.MouseButton2Click, function()
                ColorPicker:ToggleOtherFrame()
            end)
            -- separator
            Library:Connection(Button_9.MouseButton1Click, function()
                ColorPicker:Toggle()
            end)
        end
        -- separator
        ColorPicker:AddFrame()
        ColorPicker:Update()
        ColorPicker:RemoveFrame()
        -- separator
        return ColorPicker
    end
    -- separator
    function Library:Keybind(Options)
        Options = Library:Validate({
            Default = Enum.KeyCode.Backspace,
            Mode = "Toggle",
            UseMode = true,
            HideFromList = false,
            Blacklisted = {},
            Parent = nil,
            Toggle = nil,
            MainUI = nil,
            Hiding = false,
            ToggleState = false,
            Flag = Library.NewFlag(),
            Count = 1,
            ChangeToggle = false,
            Callback = function() end,
        }, Options or {})
        -- separator
        if Options.Toggle == nil then return end
        -- separator
        local Keybind = {
            Hover = false,
            ActiveFrame = false,
            Keybind = Options.Default,
            RegKeybind = nil,
            State = false,
            SelectingKeybind = false,
            Toggle = false,
            Connection = nil,
            Mode = Options.Mode,
            ConfigKeybind = nil,
            Current = {},
            CurrentMode = nil,
            Hiding = false,
        }
        -- separator
        Library.Flags[Options.Flag] = Keybind
        Library.UI.TotalKeybindModes += 1
        -- separator
        local KeybindObject = Library:CreateObject("TextLabel", {
            FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(117, 117, 117),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = "[-]",
            Name = "KeybindOutline" .. Library.UI.TotalKeybindModes,
            AnchorPoint = Vector2.new(1, 0),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 16, 0, 7),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 0 - (Options.Count - 1) * 22, 0, 0),
            TextXAlignment = Enum.TextXAlignment.Right,
            ZIndex = 3,
            TextStrokeTransparency = 0,
            TextSize = 9,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local KeybindChecker = Library:CreateObject("Frame", {
            Position = UDim2.new(0, 0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 0, 0, 1),
            Visible = false,
            BorderSizePixel = 0,
            Parent = KeybindObject
        })
        -- separator
        local Button_4 = Library:CreateObject("TextButton", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_4",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = KeybindObject
        })
        -- separator
        local UserInputTypeBinds = {"MouseButton1", "MouseButton2", "MouseButton3"}
        -- separator
        do -- Functions
            function Keybind:SetVisible(Bool)
                local OldValues = Library.Objects[KeybindObject]
                -- separator
                Keybind.Hiding = not Bool
                -- separator
                if Bool then
                    Library.Objects[KeybindObject] = {KeybindObject, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(KeybindObject), KeybindObject, 0.075)
                Library:TweenObject(KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and UDim2.new(1, 0, 0, 8) or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[KeybindObject] = {KeybindObject, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function Keybind:Set(Key)
                if Keybind.Hiding then return end
                if typeof(Key) == "boolean" then return end
                -- separator
                if typeof(Key) == "EnumItem" then
                    Keybind.RegKeybind = Key
                elseif typeof(Key) == "string" then
                    if table.find(UserInputTypeBinds, Key) then
                        Keybind.RegKeybind = Enum.UserInputType[Key]
                        Key = Enum.UserInputType[Key]
                    else
                        Keybind.RegKeybind = Enum.KeyCode[Key]
                        Key = Enum.KeyCode[Key]
                    end
                end
                -- separator
                if typeof(Key) == "string" then
                    if Key:find("KEY") then
                        Key = Enum.KeyCode[Key:gsub("KEY_", "")]
                    elseif Key:find("Input") then
                        Key = Enum.UserInputType[Key:gsub("Input_", "")]
                    end
                end
                -- separator
                local ValidKey = false
                local KeyString = ""
                -- separator
                if table.find(Options.Blacklisted, Key) then
                    Key = nil
                end
                -- separator
                if Key then
                    if ((Key.EnumType == Enum.KeyCode and UserInputService:GetStringForKeyCode(Key) ~= "") or Library.UI.Keys[Key]) then
                        ValidKey = true
                        KeyString = Library.UI.Keys[Key] or UserInputService:GetStringForKeyCode(Key)
                    end
                end
                -- separator
                if ValidKey then
                    Keybind.Keybind = KeyString
                    KeybindObject.Text = "[" .. KeyString:upper() .. "]"
                    -- separator
                    Options.Callback(Key)
                    Library.Flags[Options.Flag] = Keybind
                else
                    Keybind.Keybind = "[-]"
                    KeybindObject.Text = Keybind.Keybind
                end
                -- separator
                Library:TweenObject(KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(117, 117, 117)})
                KeybindObject.Size = UDim2.new(0, KeybindObject.TextBounds.X + 2, 0, 7)
            end
            -- separator
            function Keybind:Toggle(Bool)
                if Keybind.Hiding then return end
                -- separator
                if Bool == nil then
                    Keybind.State = not Keybind.State
                else
                    Keybind.State = Bool
                end
                -- separator
                if not Options.HideFromList then
                    if Keybind.State then
                        --Library:AddKeybindFrame(Keybind.Mode, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                    else
                        --Library:RemoveKeybindFrame(Options.Toggle:GetName(), Options.Toggle:GetSection())
                    end
                end
                -- separator
                if Options.Toggle.GetFlag then
                    Library.Flags[Options.Toggle:GetFlag()] = Keybind
                end
                -- separator
                if Options.ChangeToggle then
                    -- viuslaly toggle the UI element and update its state
                    Options.Toggle:Set(Keybind.State)
                else
                    Options.Toggle:GetCallback(Keybind.State)
                end
            end
            -- separator
            task.delay(1, function()
                Keybind:Set(Options.Default)
            end)
            -- separator
            function Keybind:Get()
                local KeyString = Keybind.RegKeybind.EnumType == Enum.KeyCode and tostring(Keybind.RegKeybind):match("^Enum%.KeyCode%.(.+)$") or tostring(Keybind.RegKeybind):match("^Enum%.UserInputType%.(.+)$")
                -- separator
                return KeyString
            end
            -- separator
            function Keybind:Active()
                return (Keybind.Keybind:lower() == "[-]" and true or Keybind.State)
            end
            -- separator
            if Options.Mode == "Always on" then
                Keybind:Toggle(true)
            end
            -- separator
            function Keybind:SetMode(Mode)
                Keybind.Mode = Mode
                -- separator
                if Mode == "Always on" then
                    if Mode == "Always on" then
                        Keybind:Toggle(true)
                    end
                    -- separator
                    if not Keybind.State then
                        Keybind.State = true
                        -- separator
                        --Library:AddKeybindFrame(Mode, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                    else
                        --Library:UpdateKeybindFrame(Mode, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                    end
                elseif Mode == "Toggle" then
                    if Keybind.State then
                        --Library:UpdateKeybindFrame(Mode, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                    end
                elseif Mode == "On hotkey" then
                    Keybind.State = false
                    -- separator
                    --Library:RemoveKeybindFrame(Options.Toggle:GetName(), Options.Toggle:GetSection())
                end
            end
            -- separator
            function Keybind:AddFrame()
                Library.UI.CurrentSelectedKeybindMode = {Keybind = Keybind, KeybindObject = KeybindObject, Parent = Options.Parent}
                -- separator
                local KeybindModePickerOutline = Library:CreateObject("Frame", {
                    Name = "KeybindModePickerOutline" .. Library.UI.TotalKeybindModes,
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(0, 100, 0, 55),
                    BorderSizePixel = 0,
                    ZIndex = 25,
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = Library.UI.ScreenGUI
                })
                -- separator
                local KeybindModePickerMain = Library:CreateObject("Frame", {
                    Name = "KeybindModePickerMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    ZIndex = 25,
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Parent = KeybindModePickerOutline
                })
                -- separator
                KeybindModePickerOutline.BackgroundTransparency = 1
                KeybindModePickerMain.BackgroundTransparency = 1
                -- separator
                local UIListLayout_9 = Library:CreateObject("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = KeybindModePickerMain
                })
                -- separator
                function Keybind:UpdateSize()
                    KeybindModePickerOutline.Position = UDim2.new(0, KeybindObject.AbsolutePosition.X , 0, KeybindObject.AbsolutePosition.Y + KeybindObject.AbsoluteSize.Y + KeybindModePickerOutline.AbsoluteSize.Y - 2)
                end
                -- separator
                Keybind:UpdateSize()
                -- separator
                Library:Connection(Options.MainUI:GetPropertyChangedSignal("AbsolutePosition"), Keybind.UpdateSize)
                -- separator
                local StartingY = KeybindObject.AbsolutePosition.Y
                local MainUIStartingY = Options.MainUI.AbsolutePosition.Y
                local StartingCanvasPosition = Options.Parent.Parent.CanvasPosition
                -- separator
                Library:Connection(KeybindObject:GetPropertyChangedSignal("AbsolutePosition"), function()
                    local CurrentY = KeybindObject.AbsolutePosition.Y
                    local MainUICurrentY = Options.MainUI.AbsolutePosition.Y
                    local CurrentCanvasPosition = Options.Parent.Parent.CanvasPosition
                    -- separator
                    if MainUICurrentY ~= MainUIStartingY then
                        MainUIStartingY = MainUICurrentY
                        StartingY = CurrentY
                        -- separator
                        return
                    end
                    -- separator
                    if CurrentCanvasPosition ~= StartingCanvasPosition then
                        StartingCanvasPosition = CurrentCanvasPosition
                        StartingY = CurrentY
                        -- separator
                        return
                    end
                    -- separator
                    if Library.UI.Resizing then
                        return
                    end
                    -- separator
                    if CurrentY ~= StartingY then
                        Keybind:RemoveFrame(true)
                    end
                    -- separator
                    StartingY = CurrentY
                end)
                -- separator
                Library:Connection(Options.MainUI:GetPropertyChangedSignal("AbsoluteSize"), function()
                    if Keybind.ActiveFrame then
                        KeybindModePickerOutline.Visible = Library:ScrollingCheck(Options.Parent.Parent, KeybindChecker)
                    end
                    -- separator
                    Keybind:UpdateSize()
                end)
                -- separator
                Library:Connection(KeybindObject:GetPropertyChangedSignal("AbsoluteSize"), function()
                    Keybind:UpdateSize()
                end)
                -- separator
                if Options.Parent.Parent:IsA("ScrollingFrame") then
                    Library:Connection(Options.Parent.Parent:GetPropertyChangedSignal("CanvasPosition"), function()
                        Keybind:UpdateSize()
                        -- separator
                        if Keybind.ActiveFrame then
                            KeybindModePickerOutline.Visible = Library:ScrollingCheck(Options.Parent.Parent, KeybindChecker)
                        end
                    end)
                end
                -- separator
                for Index, Value in {"Always on", "On hotkey", "Toggle"} do
                    local ModeItem = {
                        Active = false,
                        Hovering = false,
                    }
                    -- separator
                    local Inactive = Library:CreateObject("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                        TextColor3 = Color3.fromRGB(208, 208, 208),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = Value,
                        Text = Value,
                        RichText = true,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Size = UDim2.new(1, 0, 0, 17),
                        BorderSizePixel = 0,
                        TextSize = Library.UI.FontSize,
                        ZIndex = 25,
                        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                        Parent = KeybindModePickerMain
                    })
                    -- separator
                    local Button_4 = Library:CreateObject("TextButton", {
                        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Button_4",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        TextTransparency = 1,
                        TextSize = Library.UI.FontSize,
                        ZIndex = 25,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = Inactive
                    })
                    -- separator
                    local UIPadding_48 = Library:CreateObject("UIPadding", {
                        PaddingLeft = UDim.new(0, 8),
                        Parent = Inactive
                    })
                    -- separator
                    Inactive.TextTransparency = 1
                    -- separator
                    do -- Functions
                        function ModeItem:Activate()
                            if not ModeItem.Active then
                                if Keybind.CurrentMode ~= nil then
                                    Keybind.CurrentMode:Deactivate()
                                end
                                -- separator
                                ModeItem.Active = true
                                -- separator
                                Keybind.Mode = Value
                                Keybind.CurrentMode = ModeItem
                                -- separator
                                Inactive.Text = "<b>" .. Value .. "</b>"
                                Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Library.Theme.Default.Accent})
                                -- separator
                                if Value == "Always on" then
                                    if Keybind.Mode == "Always on" then
                                        Keybind:Toggle(true)
                                    end
                                    -- separator
                                    if not Keybind.State then
                                        Keybind.State = true
                                        -- separator
                                        --Library:AddKeybindFrame(Value, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                                    else
                                        --Library:UpdateKeybindFrame(Value, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                                    end
                                elseif Value == "Toggle" then
                                    if Keybind.State then
                                        --Library:UpdateKeybindFrame(Value, Options.Toggle:GetName(), Keybind.Keybind, Options.Toggle:GetSection())
                                    end
                                elseif Value == "On hotkey" then
                                    Keybind.State = false
                                    -- separator
                                    --Library:RemoveKeybindFrame(Options.Toggle:GetName(), Options.Toggle:GetSection())
                                end
                            end
                        end
                        -- separator
                        function ModeItem:Deactivate()
                            if ModeItem.Active then
                                ModeItem.Active = false
                                ModeItem.Hovering = false
                                Inactive.Text = Value
                                Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                            end
                        end
                    end
                    -- separator
                    do -- Connections
                        Library:Connection(Button_4.MouseButton1Click, function()
                            ModeItem:Activate()
                        end)
                        -- separator
                        Library:Connection(Inactive.MouseEnter, function()
                            Inactive.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                            -- separator
                            if ModeItem.Active then return end
                            -- separator
                            Inactive.Text = "<b>" .. Value .. "</b>"
                        end)
                        -- separator
                        Library:Connection(Inactive.MouseLeave, function()
                            Inactive.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            -- separator
                            if ModeItem.Active then return end
                            -- separator
                            Inactive.Text = Value
                            Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                        end)
                    end
                    -- separator
                    if Value == Keybind.Mode then
                        ModeItem:Activate()
                    end
                end
                -- separator
                Library:Fade(true, Library:GetObjectsTable(KeybindModePickerOutline, true), KeybindModePickerOutline, 0.1)
            end
            -- separator
            function Keybind:RemoveFrame(Fast)
                local Fast = Fast or false
                -- separator
                for Index, Value in Library.UI.ScreenGUI:GetChildren() do
                    if Value:IsA("Frame") and Value.Name == "KeybindModePickerOutline" .. Library.UI.TotalKeybindModes then
                        if Fast then
                            Value:Destroy()
                        else
                            Library:Fade(false, Library:GetObjectsTable(Value, true), Value, 0.1)
                            -- separator
                            task.delay(Library.UI.TweenSpeed, function()
                                Value:Destroy()
                            end)
                        end
                    end
                end
            end
            -- separator
            function Keybind:FindFrame()
                for Index, Value in Library.UI.ScreenGUI:GetChildren() do
                    if Value:IsA("Frame") and Value.Name == "KeybindModePickerOutline" .. Library.UI.TotalKeybindModes then
                        return true
                    end
                end
                -- separator
                return false
            end
            -- separator
            function Keybind:ToggleFrame()
                Library:TweenObject(KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(176, 176, 176)})
                -- separator
                if Library.UI.CurrentSelectedKeybindMode and Library.UI.CurrentSelectedKeybindMode.KeybindObject.Name ~= KeybindObject.Name then
                    Library.UI.CurrentSelectedKeybindMode.Keybind:RemoveFrame()
                    -- separator
                    Library:TweenObject(Library.UI.CurrentSelectedKeybindMode.KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(117, 117, 117)})
                end
                -- separator
                if not Keybind:FindFrame() then
                    Keybind.ActiveFrame = true
                    Keybind:AddFrame()
                else
                    Keybind.ActiveFrame = false
                    Keybind:RemoveFrame()
                end
            end
        end
        -- separator
        do -- Connections
            Library:Connection(KeybindObject.MouseEnter, function()
                if Keybind.SelectingKeybind then return end
                -- separator
                Library:TweenObject(KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(176, 176, 176)})
            end)
            -- separator
            Library:Connection(KeybindObject.MouseLeave, function()
                if Keybind.SelectingKeybind then return end
                -- separator
                Library:TweenObject(KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(117, 117, 117)})
            end)
            -- separator
            Library:Connection(Button_4.MouseButton2Click, function()
                if not Options.UseMode then return end
                -- separator
                Keybind:ToggleFrame()
            end)
            -- separator
            Library:Connection(Button_4.MouseButton1Click, function()
                if Keybind.Connection then
                    Keybind.Connection:Disconnect()
                end
                -- separator
                Keybind.SelectingKeybind = true
                -- separator
                Library:TweenObject(KeybindObject, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 0, 0)})
                -- separator
                Keybind.Connection = Library:Connection(UserInputService.InputBegan, function(Input)
                    Keybind:Set(Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or Input.UserInputType)
                    -- separator
                    if Keybind.Connection then
                        Keybind.Connection:Disconnect()
                        -- separator
                        task.delay(0.1, function()
                            Keybind.Connection = nil
                            Keybind.SelectingKeybind = false
                        end)
                    end
                end)
            end)
            -- separator
            Library:Connection(UserInputService.InputBegan, function(Input, Proccessed)
                if Proccessed then return end
                -- separator
                if (Input.UserInputType == Enum.UserInputType.Keyboard and Keybind.Keybind ~= "[-]" and Input.KeyCode == Keybind.RegKeybind) or (Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Keybind == "MB1") or (Input.UserInputType == Enum.UserInputType.MouseButton2 and Keybind.Keybind == "MB2") or (Input.UserInputType == Enum.UserInputType.MouseButton3 and Keybind.Keybind == "MMB") then
                    if Keybind.Mode == "Always on" then
                        Keybind:Toggle(true)
                    else
                        Keybind:Toggle()
                    end
                end
            end)
            -- separator
            Library:Connection(UserInputService.InputEnded, function(Input, Proccessed)
                if Proccessed then return end
                -- separator
                if Keybind.Mode == "On hotkey" then
                    if (Input.UserInputType == Enum.UserInputType.Keyboard and Keybind.Keybind ~= "[-]" and Input.KeyCode == Keybind.RegKeybind) or (Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Keybind == "MB1") or (Input.UserInputType == Enum.UserInputType.MouseButton2 and Keybind.Keybind == "MB2") or (Input.UserInputType == Enum.UserInputType.MouseButton3 and Keybind.Keybind == "MMB") then
                        Keybind:Toggle()
                    end
                end
            end)
        end
        -- separator
        if Options.Hiding then
            Keybind:SetVisible(false)
        end
        -- separator
        return Keybind
    end
    -- separator
    function Library:MultiBox(Options)
        Options = Library:Validate({
            Default = "None",
            Name = "Preview MultiBox",
            Content = {},
            Parent = nil,
            MainUI = nil,
            Hiding = false,
            TabUI = nil,
            Risky = false,
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        -- separator
        local MultiBox = {
            Open = false,
            Hover = false,
            Items = Options.Content,
            Scrollable = false,
            Value = {},
            SelectedOrder = {},
            AllItems = {},
        }
        -- separator
        Library.Flags[Options.Flag] = MultiBox
        Options.Callback(Options.Default)
        -- separator
        local PreviewMultiBox_5 = Library:CreateObject("Frame", {
            Name = "PreviewMultiBox_5",
            BackgroundTransparency = 1,
            Size = Options.Name == "" and UDim2.new(1, 0, 0, 20) or UDim2.new(1, 0, 0, 31),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local MultiBoxOutline_5 = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0, 1),
            Name = "MultiBoxOutline_5",
            Position = UDim2.new(0, -1, 1, 0),
            Size = UDim2.new(1, -19, 0, 20),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewMultiBox_5
        })
        -- separator
        local MultiBoxChecker = Library:CreateObject("Frame", {
            Name = "MultiBoxChecker",
            Position = UDim2.new(0, 0, 1, 0),
            Visible = false,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 0, 0, 1),
            BorderSizePixel = 0,
            Parent = MultiBoxOutline_5
        })
        -- separator
        local MultiBoxBack_5 = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "MultiBoxBack_5",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(220, 220, 220),
            Parent = MultiBoxOutline_5
        })
        -- separator
        local MultiBoxArrow = Library:CreateObject("ImageLabel", {
            ImageColor3 = Color3.fromRGB(151, 151, 151),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "MultiBoxArrow",
            Image = "rbxassetid://15556784588",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -11, 0, 6),
            Size = UDim2.new(0, 5, 0, 4),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = MultiBoxBack_5
        })
        -- separator
        local UIGradient_34 = Library:CreateObject("UIGradient", {
            Rotation = -90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 39, 39)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
            },
            Parent = MultiBoxBack_5
        })
        -- separator
        local MultiBoxValue_5 = Library:CreateObject("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(152, 152, 152),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = "None",
            Name = "MultiBoxValue_5",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 3,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = MultiBoxBack_5
        })
        -- separator
        local UIPadding_87 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 5),
            Parent = MultiBoxValue_5
        })
        -- separator
        local Button_44 = Library:CreateObject("TextButton", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_44",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = 14,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = MultiBoxOutline_5
        })
        -- separator
        local MultiBoxName_5 = Library:CreateObject("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Library.Theme.Default.TextColor,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Options.Name,
            Name = "MultiBoxName_5",
            ZIndex = 3,
            Size = UDim2.new(1, -19, 1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, -4),
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewMultiBox_5
        })
        -- separator
        local UIPadding_88 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = PreviewMultiBox_5
        })
        -- separator
        local MultiBoxMainOutline = Library:CreateObject("Frame", {
            Name = "MultiBoxMainOutline",
            Position = UDim2.new(0, 0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 10,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = Library.UI.ScreenGUI
        })
        -- separator
        local MultiBoxMain = Library:CreateObject("Frame", {
            Name = "MultiBoxMain",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            ZIndex = 10,
            ClipsDescendants = true,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Parent = MultiBoxMainOutline
        })
        -- separator
        MultiBoxMainOutline.BackgroundTransparency = 1
        MultiBoxMain.BackgroundTransparency = 1
        -- separator
        local UIListLayout_9 = Library:CreateObject("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = MultiBoxMain
        })
        -- separator
        do -- Functions
            function MultiBox:Set(Values)
                for Index, Item in MultiBox.AllItems do
                    if not table.find(Values, Index) then
                        MultiBox.Items[Index] = false
                    else
                        MultiBox.Items[Index] = true
                    end
                    -- separator
                    Item:Toggle()
                end
            end
            -- separator
            function MultiBox:Get()
                return MultiBox.Value
            end
            -- separator
            function MultiBox:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewMultiBox_5]
                -- separator
                MultiBox.Hiding = not Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewMultiBox_5] = {PreviewMultiBox_5, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewMultiBox_5), PreviewMultiBox_5, 0.075)
                Library:TweenObject(PreviewMultiBox_5, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and (Options.Name == "" and UDim2.new(1, 0, 0, 20) or UDim2.new(1, 0, 0, 31)) or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewMultiBox_5] = {PreviewMultiBox_5, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function MultiBox:AddValue(Value)
                local Item = {
                    Active = false,
                    Hovering = false,
                }
                -- separator
                MultiBox.Items[Value] = Item
                -- separator
                local Inactive = Library:CreateObject("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = Color3.fromRGB(208, 208, 208),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = Value,
                    Text = Value,
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = Library.UI.FontSize,
                    ZIndex = 10,
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Parent = MultiBoxMain
                })
                -- separator
                local Button_4 = Library:CreateObject("TextButton", {
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_4",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = Library.UI.FontSize,
                    ZIndex = 11,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = Inactive
                })
                -- separator
                local UIPadding_48 = Library:CreateObject("UIPadding", {
                    PaddingLeft = UDim.new(0, 8),
                    Parent = Inactive
                })
                -- separator
                Inactive.TextTransparency = 1
                -- separator
                do -- Functions
                    function Item:GetSelectedItems()
                        local SelectedItems = {}
                        -- separator
                        for _, Item in MultiBox.SelectedOrder do
                            if MultiBox.Items[Item] then
                                table.insert(SelectedItems, Item)
                            end
                        end
                        -- separator
                        return SelectedItems
                    end
                    -- separator
                    function MultiBox:UpdateValue()
                        MultiBox.Value = Item:GetSelectedItems()
                        -- separator
                        MultiBoxValue_5.Text = Library:ClampString(table.concat(MultiBox.Value, ", "), MultiBoxMain.AbsoluteSize.X - MultiBoxArrow.AbsoluteSize.X - 4)
                    end
                    -- separator
                    function Item:SelectItem(Item)
                        if not table.find(MultiBox.SelectedOrder, Item) then
                            table.insert(MultiBox.SelectedOrder, Item)
                        end
                        -- separator
                        MultiBox:UpdateValue()
                    end

                    function Item:DeselectItem(Item)
                        for Index, Value in MultiBox.SelectedOrder do
                            if Value == Item then
                                table.remove(MultiBox.SelectedOrder, Index)
                                -- separator
                                break
                            end
                        end
                        -- separator
                        MultiBox:UpdateValue()
                    end
                    -- separator
                    function Item:Activate()
                        if not Item.Active then
                            Item.Active = true
                            MultiBox.CurrentItem = Item
                            MultiBox.Items[Value] = true
                            Library.Flags[Options.Flag] = MultiBox
                            Item:SelectItem(Value)
                            Options.Callback(MultiBox.Value)
                            -- separator
                            Inactive.Text = "<b>" .. Value .. "</b>"
                            Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Library.Theme.Default.Accent})
                            Library:AddTheme(Inactive, {
                                TextColor3 = "Accent",
                            })
                        end
                    end
                    -- separator
                    function Item:Deactivate()
                        if Item.Active then
                            Item.Active = false
                            Item.Hovering = false
                            MultiBox.CurrentItem = nil
                            Library.Flags[Options.Flag] = MultiBox
                            MultiBox.Items[Value] = false
                            Item:DeselectItem(Value)
                            Options.Callback(MultiBox.Value)
                            -- separator
                            Inactive.Text = Value
                            Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                            Library:AddTheme(Inactive, {
                                TextColor3 = "TextColor",
                            })
                        end
                    end
                    -- separator
                    function Item:Toggle()
                        MultiBox.Items[Value] = not MultiBox.Items[Value]
                        -- separator
                        if MultiBox.Items[Value] then
                            Item:Activate()
                        else
                            Item:Deactivate()
                        end
                    end
                end
                -- separator
                do -- Connections
                    Library:Connection(Button_4.MouseButton1Click, function()
                        if MultiBox.Hiding then return end
                        -- separator
                        Item:Toggle()
                    end)
                    -- separator
                    Library:Connection(Inactive.MouseEnter, function()
                        Inactive.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                        -- separator
                        if Item.Active then return end
                        -- separator
                        Inactive.Text = "<b>" .. Value .. "</b>"
                    end)
                    -- separator
                    Library:Connection(Inactive.MouseLeave, function()
                        Inactive.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        -- separator
                        if Item.Active then return end
                        -- separator
                        Inactive.Text = Value
                        Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                    end)
                end
                -- separator
                if typeof(Options.Default) == "table" and table.find(Options.Default, Value) then
                    Item:Activate()
                    Item:SelectItem(Value)
                else
                    MultiBox.Items[Value] = false
                end
            end
            -- separator
            function MultiBox:Toggle(Fast)
                local Fast = Fast or false
                local OldValues = Library.Objects[MultiBoxMainOutline]
                -- separator
                if MultiBox.Open then
                    if Fast then
                        Library:Fade(false, Library:GetObjectsTable(MultiBoxMainOutline, true), MultiBoxMainOutline, 0)
                        MultiBoxMainOutline.Size = UDim2.new(0, MultiBoxOutline_5.AbsoluteSize.X, 0, 0)
                        Library.Objects[MultiBoxMainOutline] = {MultiBoxMainOutline, OldValues[2], true}
                    else
                        Library:Fade(false, Library:GetObjectsTable(MultiBoxMainOutline, true), MultiBoxMainOutline, 0.1)
                        Library:TweenObject(MultiBoxMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(0, MultiBoxOutline_5.AbsoluteSize.X, 0, 0)}, function()
                            Library.Objects[MultiBoxMainOutline] = {MultiBoxMainOutline, OldValues[2], true}
                        end)
                    end
                else
                    Library.Objects[MultiBoxMainOutline] = {MultiBoxMainOutline, OldValues[2], false}
                    -- separator
                    if Fast then
                        Library:Fade(true, Library:GetObjectsTable(MultiBoxMainOutline, true), MultiBoxMainOutline, 0)
                        MultiBoxMainOutline.Size = UDim2.new(0, MultiBoxOutline_5.AbsoluteSize.X, 0, (#Options.Content * 20) + 2)
                    else
                        Library:Fade(true, Library:GetObjectsTable(MultiBoxMainOutline, true), MultiBoxMainOutline, 0.1)
                        Library:TweenObject(MultiBoxMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(0, MultiBoxOutline_5.AbsoluteSize.X, 0, (#Options.Content * 20) + 2)})
                    end	
                end
                -- separator
                MultiBox.Open = not MultiBox.Open
            end
            -- separator
            function MultiBox:Update()
                MultiBoxMainOutline.Size = UDim2.new(0, MultiBoxOutline_5.AbsoluteSize.X, 0, MultiBoxMainOutline.AbsoluteSize.Y)
                MultiBoxMainOutline.Position = UDim2.new(0, MultiBoxOutline_5.AbsolutePosition.X, 0, ((MultiBoxOutline_5.AbsolutePosition.Y + MultiBoxOutline_5.AbsoluteSize.Y) + GuiService:GetGuiInset().Y + 2))
                -- separator
                if MultiBox.Open then
                    MultiBoxMainOutline.Visible = Library:ScrollingCheck(Options.Parent, MultiBoxChecker)
                end
            end
            -- separator
            MultiBox:Update()
            -- separator
            Library:Connection(MultiBoxOutline_5:GetPropertyChangedSignal("AbsolutePosition"), MultiBox.Update)
            Library:Connection(MultiBoxOutline_5:GetPropertyChangedSignal("AbsoluteSize"), MultiBox.Update)
            -- separator
            local StartingX = PreviewMultiBox_5.AbsolutePosition.X
            local StartingY = PreviewMultiBox_5.AbsolutePosition.Y
            local MainUIStartingX = Options.MainUI.AbsolutePosition.X
            local MainUIStartingY = Options.MainUI.AbsolutePosition.Y
            local StartingCanvasPosition = Options.Parent.CanvasPosition
            -- separator
            Library:Connection(PreviewMultiBox_5:GetPropertyChangedSignal("AbsolutePosition"), function()
                if not MultiBox.Open then return end
                -- separator
                local CurrentX = PreviewMultiBox_5.AbsolutePosition.X
                local CurrentY = PreviewMultiBox_5.AbsolutePosition.Y
                local MainUICurrentX = Options.MainUI.AbsolutePosition.X
                local MainUICurrentY = Options.MainUI.AbsolutePosition.Y
                local CurrentCanvasPosition = Options.Parent.CanvasPosition
                -- separator
                if MainUICurrentX ~= MainUIStartingX or MainUICurrentY ~= MainUIStartingY then
                    MainUIStartingX = MainUICurrentX
                    MainUIStartingY = MainUICurrentY
                    StartingX = CurrentX
                    StartingY = CurrentY
                    -- separator
                    return
                end
                -- separator
                if CurrentCanvasPosition ~= StartingCanvasPosition then
                    StartingCanvasPosition = CurrentCanvasPosition
                    StartingX = CurrentX
                    StartingY = CurrentY
                    -- separator
                    return
                end
                -- separator
                if Library.UI.Resizing then
                    return
                end
                -- separator
                if CurrentX ~= StartingX or CurrentY ~= StartingY then
                    MultiBox:Toggle(true)
                end
                -- separator
                StartingX = CurrentX
                StartingY = CurrentY
            end)
            -- separator
            if Options.Parent:IsA("ScrollingFrame") then
                Library:Connection(Options.Parent:GetPropertyChangedSignal("CanvasPosition"), function()
                    MultiBox:Update()
                end)
            end
        end
        -- separator
        do -- Connections
            Library:Connection(Button_44.MouseButton1Click, function()
                if MultiBox.Hiding then return end
                -- separator
                MultiBox:Toggle()
            end)
            -- separator
            Library:Connection(MultiBoxOutline_5.MouseEnter, function()
                if Library.UI.Faded then return end
                -- separator
                if not MultiBox.Open then
                    MultiBox.Hovering = true
                    Library:TweenObject(MultiBoxBack_5, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                end	
            end)
            -- separator
            Library:Connection(MultiBoxOutline_5.MouseLeave, function()
                if Library.UI.Faded then return end
                -- separator
                if not MultiBox.Open then
                    MultiBox.Hovering = false
                    Library:TweenObject(MultiBoxBack_5, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(220, 220, 220)})
                end	
            end)
        end
        -- separator
        for Index, Value in Options.Content do
            if typeof(Value) == "boolean" or typeof(Value) == "table" then continue end
            -- separator
            MultiBox:AddValue(Value)
        end
        -- separator
        Library:Fade(false, Library:GetObjectsTable(MultiBoxMainOutline, true), MultiBoxMainOutline, 0.1)
        -- separator
        if Options.Hiding then
            MultiBox:SetVisible(false)
        end
        -- separator
        MultiBox:Toggle(true)
        -- separator
        return MultiBox
    end
    -- separator
    function Library:Dropdown(Options)
        Options = Library:Validate({
            Default = "None",
            Name = "Preview Dropdown",
            Content = {},
            Parent = nil,
            MainUI = nil,
            Hiding = false,
            TabUI = nil,
            Risky = false,
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        -- separator
        local Dropdown = {
            Open = false,
            Active = false,
            Hovering = false,
            CurrentItem = nil,
            Scrollable = false,
            Hiding = false,
            Items = {},
            Value = Options.Default,
        }
        -- separator
        Library.Flags[Options.Flag] = Dropdown
        -- separator
        local PreviewDropdown_5 = Library:CreateObject("Frame", {
            Name = "PreviewDropdown_5",
            BackgroundTransparency = 1,
            Size = Options.Name == "" and UDim2.new(1, 0, 0, 20) or UDim2.new(1, 0, 0, 31),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local DropdownOutline_5 = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0, 1),
            Name = "DropdownOutline_5",
            Position = UDim2.new(0, -1, 1, 0),
            Size = UDim2.new(1, -19, 0, 20),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewDropdown_5
        })
        -- separator
        local DropdownChecker = Library:CreateObject("Frame", {
            Name = "DropdownChecker",
            Position = UDim2.new(0, 0, 1, 0),
            Visible = false,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 0, 0, 1),
            BorderSizePixel = 0,
            Parent = DropdownOutline_5
        })
        -- separator
        local DropdownBack_5 = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "DropdownBack_5",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(220, 220, 220),
            Parent = DropdownOutline_5
        })
        -- separator
        local DropdownArrow = Library:CreateObject("ImageLabel", {
            ImageColor3 = Color3.fromRGB(151, 151, 151),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "DropdownArrow",
            Image = "rbxassetid://15556784588",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -11, 0, 6),
            Size = UDim2.new(0, 5, 0, 4),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = DropdownBack_5
        })
        -- separator
        local UIGradient_34 = Library:CreateObject("UIGradient", {
            Rotation = -90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 39, 39)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
            },
            Parent = DropdownBack_5
        })
        -- separator
        local DropdownValue_5 = Library:CreateObject("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(152, 152, 152),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Options.Default ~= "None" and table.find(Options.Content, Options.Default) and Options.Default or "None",
            Name = "DropdownValue_5",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 3,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = DropdownBack_5
        })
        -- separator
        local UIPadding_87 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 5),
            Parent = DropdownValue_5
        })
        -- separator
        local Button_44 = Library:CreateObject("TextButton", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_44",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = 14,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = DropdownOutline_5
        })
        -- separator
        local DropdownName_5 = Library:CreateObject("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Library.Theme.Default.TextColor,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Options.Name,
            Name = "DropdownName_5",
            ZIndex = 3,
            Position = UDim2.new(0, 0, 0, -4),
            Size = UDim2.new(1, -19, 1, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewDropdown_5
        })
        -- separator
        local UIPadding_88 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = PreviewDropdown_5
        })
        -- separator
        local DropdownMainOutline = Library:CreateObject("Frame", {
            Name = "DropdownMainOutline",
            Position = UDim2.new(0, 0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 10,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = Library.UI.ScreenGUI
        })
        -- separator
        local DropdownMain = Library:CreateObject("Frame", {
            Name = "DropdownMain",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            ZIndex = 10,
            ClipsDescendants = true,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Parent = DropdownMainOutline
        })
        -- separator
        DropdownMainOutline.BackgroundTransparency = 1
        DropdownMain.BackgroundTransparency = 1
        -- separator
        local UIListLayout_9 = Library:CreateObject("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = DropdownMain
        })
        -- separator
        do -- Functions
            function Dropdown:Set(State)
                for Index, Value in Dropdown.Items do
                    if Index == State then
                        Value:Activate()
                    else
                        Value:Deactivate()
                    end
                end
            end
            -- separator
            function Dropdown:Get()
                return Dropdown.Value
            end
            -- separator
            function Dropdown:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewDropdown_5]
                -- separator
                Dropdown.Hiding = not Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewDropdown_5] = {PreviewDropdown_5, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewDropdown_5), PreviewDropdown_5, 0.075)
                Library:TweenObject(PreviewDropdown_5, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and (Options.Name == "" and UDim2.new(1, 0, 0, 20) or UDim2.new(1, 0, 0, 31)) or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewDropdown_5] = {PreviewDropdown_5, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function Dropdown:AddValue(Value)
                local Item = {
                    Active = false,
                    Hovering = false,
                }
                -- separator
                Dropdown.Items[Value] = Item
                -- separator
                local Inactive = Library:CreateObject("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = Color3.fromRGB(208, 208, 208),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = Value,
                    Text = Value,
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = Library.UI.FontSize,
                    ZIndex = 10,
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Parent = DropdownMain
                })
                -- separator
                local Button_4 = Library:CreateObject("TextButton", {
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_4",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = Library.UI.FontSize,
                    ZIndex = 10,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = Inactive
                })
                -- separator
                local UIPadding_48 = Library:CreateObject("UIPadding", {
                    PaddingLeft = UDim.new(0, 8),
                    Parent = Inactive
                })
                -- separator
                Inactive.TextTransparency = 1
                -- separator
                do -- Functions
                    function Item:Activate()
                        if not Item.Active then
                            if Dropdown.CurrentItem ~= nil then
                                Dropdown.CurrentItem:Deactivate()
                            end
                            -- separator
                            Item.Active = true
                            Dropdown.CurrentItem = Item
                            Dropdown.Value = Value
                            Library.Flags[Options.Flag] = Dropdown
                            Options.Callback(Value)
                            DropdownValue_5.Text = Value
                            -- separator
                            Inactive.Text = "<b>" .. Value .. "</b>"
                            Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Library.Theme.Default.Accent})
                            Library:AddTheme(Inactive, {
                                TextColor3 = "Accent",
                            })
                        end
                    end
                    -- separator
                    function Item:Deactivate()
                        if Item.Active then
                            Item.Active = false
                            Item.Hovering = false
                            Inactive.Text = Value
                            Inactive.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                            Library:AddTheme(Inactive, {
                                TextColor3 = "TextColor",
                            })
                        end
                    end
                end
                -- separator
                do -- Connections
                    Library:Connection(Button_4.MouseButton1Click, function()
                        if Dropdown.Hiding then return end
                        -- separator
                        Item:Activate()
                        Dropdown:Toggle()
                    end)
                    -- separator
                    Library:Connection(Inactive.MouseEnter, function()
                        Inactive.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                        -- separator
                        if Item.Active then return end
                        -- separator
                        Inactive.Text = "<b>" .. Value .. "</b>"
                    end)
                    -- separator
                    Library:Connection(Inactive.MouseLeave, function()
                        Inactive.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        -- separator
                        if Item.Active then return end
                        -- separator
                        Inactive.Text = Value
                        Library:TweenObject(Inactive, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(205, 205, 205)})
                    end)
                end
                -- separator
                if Value == Options.Default then
                    Item:Activate()
                end
            end
            -- separator
            function Dropdown:Toggle(Fast)
                local Fast = Fast or false
                local OldValues = Library.Objects[DropdownMainOutline]
                -- separator
                if Dropdown.Open then
                    if Fast then
                        Library:Fade(false, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0)
                        DropdownMainOutline.Size = UDim2.new(0, DropdownOutline_5.AbsoluteSize.X, 0, 0)
                        Library.Objects[DropdownMainOutline] = {DropdownMainOutline, OldValues[2], true}
                    else
                        Library:Fade(false, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0.1)
                        Library:TweenObject(DropdownMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(0, DropdownOutline_5.AbsoluteSize.X, 0, 0)}, function()
                            Library.Objects[DropdownMainOutline] = {DropdownMainOutline, OldValues[2], true}
                        end)
                    end
                else
                    Library.Objects[DropdownMainOutline] = {DropdownMainOutline, OldValues[2], false}
                    -- separator
                    if Fast then
                        Library:Fade(true, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0)
                        DropdownMainOutline.Size = UDim2.new(0, DropdownOutline_5.AbsoluteSize.X, 0, (#Options.Content * 20) + 2)
                    else
                        Library:Fade(true, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0.1)
                        Library:TweenObject(DropdownMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(0, DropdownOutline_5.AbsoluteSize.X, 0, (#Options.Content * 20) + 2)})
                    end	
                end
                -- separator
                Dropdown.Open = not Dropdown.Open
            end
            -- separator
            function Dropdown:Update()
                DropdownMainOutline.Size = UDim2.new(0, DropdownOutline_5.AbsoluteSize.X, 0, DropdownMainOutline.AbsoluteSize.Y)
                DropdownMainOutline.Position = UDim2.new(0, DropdownOutline_5.AbsolutePosition.X, 0, ((DropdownOutline_5.AbsolutePosition.Y + DropdownOutline_5.AbsoluteSize.Y) + GuiService:GetGuiInset().Y + 2))
                -- separator
                if Dropdown.Open then
                    DropdownMainOutline.Visible = Library:ScrollingCheck(Options.Parent, DropdownChecker)
                end
            end
            -- separator
            Dropdown:Update()
            -- separator
            Library:Connection(DropdownOutline_5:GetPropertyChangedSignal("AbsolutePosition"), Dropdown.Update)
            Library:Connection(DropdownOutline_5:GetPropertyChangedSignal("AbsoluteSize"), Dropdown.Update)
            -- separator
            local StartingX = PreviewDropdown_5.AbsolutePosition.X
            local StartingY = PreviewDropdown_5.AbsolutePosition.Y
            local MainUIStartingX = Options.MainUI.AbsolutePosition.X
            local MainUIStartingY = Options.MainUI.AbsolutePosition.Y
            local StartingCanvasPosition = Options.Parent.CanvasPosition
            -- separator
            Library:Connection(PreviewDropdown_5:GetPropertyChangedSignal("AbsolutePosition"), function()
                if not Dropdown.Open then return end
                -- separator
                local CurrentX = PreviewDropdown_5.AbsolutePosition.X
                local CurrentY = PreviewDropdown_5.AbsolutePosition.Y
                local MainUICurrentX = Options.MainUI.AbsolutePosition.X
                local MainUICurrentY = Options.MainUI.AbsolutePosition.Y
                local CurrentCanvasPosition = Options.Parent.CanvasPosition
                -- separator
                if MainUICurrentX ~= MainUIStartingX or MainUICurrentY ~= MainUIStartingY then
                    MainUIStartingX = MainUICurrentX
                    MainUIStartingY = MainUICurrentY
                    StartingX = CurrentX
                    StartingY = CurrentY
                    -- separator
                    return
                end
                -- separator
                if CurrentCanvasPosition ~= StartingCanvasPosition then
                    StartingCanvasPosition = CurrentCanvasPosition
                    StartingX = CurrentX
                    StartingY = CurrentY
                    -- separator
                    return
                end
                -- separator
                if Library.UI.Resizing then
                    return
                end
                -- separator
                if CurrentX ~= StartingX or CurrentY ~= StartingY then
                    Dropdown:Toggle(true)
                end
                -- separator
                StartingX = CurrentX
                StartingY = CurrentY
            end)
            -- separator
            if Options.Parent:IsA("ScrollingFrame") then
                Library:Connection(Options.Parent:GetPropertyChangedSignal("CanvasPosition"), function()
                    Dropdown:Update()
                end)
            end
        end
        -- separator
        do -- Connections
            Library:Connection(Button_44.MouseButton1Click, function()
                if Dropdown.Hiding then return end
                -- separator
                Dropdown:Toggle()
            end)
            -- separator
            Library:Connection(DropdownOutline_5.MouseEnter, function()
                if Library.UI.Faded then return end
                -- separator
                if not Dropdown.Open then
                    Dropdown.Hovering = true
                    Library:TweenObject(DropdownBack_5, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                end	
            end)
            -- separator
            Library:Connection(DropdownOutline_5.MouseLeave, function()
                if Library.UI.Faded then return end
                -- separator
                if not Dropdown.Open then
                    Dropdown.Hovering = false
                    Library:TweenObject(DropdownBack_5, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(220, 220, 220)})
                end	
            end)
        end
        -- separator
        for _, Value in Options.Content do
            Dropdown:AddValue(Value)
        end
        -- separator
        Library:Fade(false, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0.1)
        -- separator
        if Options.Hiding then
            Dropdown:SetVisible(false)
        end
        -- separator
        Dropdown:Toggle(true)
        -- separator
        return Dropdown
    end
    -- separator
    function Library:Slider(Options)
        Options = Library:Validate({
            Name = "Preview Slider",
            Min = 0,
            Max = 100,
            Default = 1,
            Decimal = 1,
            UseIcons = true,
            Ending = "",
            Disable = {},
            Hidden = false,
            Risky = false,
            Parent = nil,
            OverrideLimit = false, -- new parameter to allow values beyond max
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        -- separator
        local Slider = {
            MouseDown = false,
            Hiding = false,
            Hovering = false,
            Connection = nil,
            CurrentValue = -9999,
            LeftControlDown = false,
        }
        -- separator
        Library.Flags[Options.Flag] = Slider
        -- separator
        local PreviewSlider = Library:CreateObject("Frame", {
            Name = "PreviewSlider",
            BackgroundTransparency = 1,
            Size = Options.Name == "" and UDim2.new(1, 0, 0, 7) or UDim2.new(1, 0, 0, 20),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local SliderOutline = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0, 1),
            Name = "SliderOutline",
            Position = UDim2.new(0, -1, 1, 0),
            Size = UDim2.new(1, -19, 0, 7),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewSlider
        })
        -- separator
        local SliderBack = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "SliderBack",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(205, 205, 205),
            Parent = SliderOutline
        })
        -- separator
        local UIGradient_2 = Library:CreateObject("UIGradient", {
            Rotation = -90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(81, 81, 81)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 68, 68))
            },
            Parent = SliderBack
        })
        -- separator
        local SliderDrag = Library:CreateObject("Frame", {
            Name = "Slider",
            Size = UDim2.new(0.5, 0, 1, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = SliderBack
        })
        -- separator
        local UIGradient_3 = Library:CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Library.Theme.Default.Accent),
                ColorSequenceKeypoint.new(1, Library.Theme.Default.SecondAccent)
            },
            Parent = SliderDrag
        })
        -- separator
        Library:AddTheme(UIGradient_3, {
            Color = {"Accent", "SecondAccent"},
        })
        -- separator
        local Button_4 = Library:CreateObject("TextButton", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_4",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = SliderOutline
        })
        -- separator
        local SliderName = Library:CreateObject("TextLabel", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Options.Risky and Library.Theme.Default.Risky or Library.Theme.Default.TextColor,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Options.Name,
            Name = "SliderName",
            ZIndex = 3,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewSlider
        })
        -- separator
        if Options.Risky then
            Library:AddTheme(SliderName, {
                TextColor3 = "Risky",
            })
        end
        -- separator
        local UIPadding_3 = Library:CreateObject("UIPadding", {
            PaddingTop = UDim.new(0, -4),
            PaddingLeft = UDim.new(0, 20),
            Parent = PreviewSlider
        })
        -- separator
        local SliderValue = Library:CreateObject("TextBox", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(198, 198, 198),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Options.Default,
            Name = "SliderValue",
            ZIndex = 3,
            AnchorPoint = Vector2.new(1, 0),
            Size = UDim2.new(0, 10, 0, 10),
            Position = UDim2.new(0, 100, 0, 0),
            BackgroundTransparency = 1,
            RichText = true,
            BorderSizePixel = 0,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = Library.UI.FontSize,
            TextStrokeTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = SliderDrag
        })
        -- separator
        local AddButton = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(1, 1),
            Name = "AddButton",
            Position = UDim2.new(1, -13, 1, -3),
            Size = UDim2.new(0, 3, 0, 1),
            ZIndex = 3,
            BorderSizePixel = 0,
            Visible = Options.UseIcons,
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            Parent = PreviewSlider
        })
        -- separator
        local AddButton2 = Library:CreateObject("Frame", {
            Size = UDim2.new(0, 1, 0, 3),
            Name = "AddButton2",
            Position = UDim2.new(0, 1, 0, -1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            Visible = Options.UseIcons,
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            Parent = AddButton
        })
        -- separator
        local AddActualButton = Library:CreateObject("TextButton", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "AddActualButton",
            TextTransparency = 1,
            AnchorPoint = Vector2.new(1, 1),
            Size = UDim2.new(0, 11, 0, 7),
            Visible = Options.UseIcons,
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -9, 1, 1),
            BorderSizePixel = 0,
            ZIndex = 3,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewSlider
        })
        -- separator
        local MinusActualButton = Library:CreateObject("TextButton", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "MinusActualButton",
            TextTransparency = 1,
            Visible = Options.UseIcons,
            AnchorPoint = Vector2.new(0, 1),
            Size = UDim2.new(0, 11, 0, 7),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, -12, 1, 0),
            BorderSizePixel = 0,
            ZIndex = 3,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewSlider
        })
        -- separator
        local MinusButton = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0, 1),
            Name = "MinusButton",
            Visible = Options.UseIcons,
            Position = UDim2.new(0, -8, 1, -3),
            Size = UDim2.new(0, 3, 0, 1),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            Parent = PreviewSlider
        })
        -- separator
        local function GetValue(Value)
            return typeof(Value) == "string" and Value or ("%.14g"):format(Value)
        end
        -- separator
        local function SetValue(Value, IgnoreLimit)
            if (not Value) or Slider.Hiding then return end
            -- separator
            local OriginalValue = Value
            -- check if we should allow values beyond the max
            if Options.OverrideLimit and IgnoreLimit then
                -- allow any value (still enforce min and decimal rounding)
                Value = Value and math.max(Options.Decimal * math.round(tonumber(Value) / Options.Decimal), Options.Min) or 0
            else
                -- default behavior: clamp between min and max
                Value = Value and math.clamp(Options.Decimal * math.round(tonumber(Value) / Options.Decimal), Options.Min, Options.Max) or 0
            end
            
            local ValueText = Options.Disable[1] and ((Value <= Options.Disable[2] or Value >= Options.Disable[3]) and Options.Disable[1]) or tostring(GetValue(Value)) .. Options.Ending
            -- separator
            SliderValue.Text = "<b>" .. ValueText .. "</b>"
            -- separator
            if Value ~= Slider.CurrentValue then
                Slider.CurrentValue = Value
                -- separator
                -- always display the slider within bounds, even if the value is beyond max
                local DisplayValue = math.min(Value, Options.Max)
                Library:TweenObject(SliderDrag, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new((DisplayValue - Options.Min) / (Options.Max - Options.Min), 0, 1, 0)})
                -- separator
                SliderValue.Size = UDim2.fromOffset(SliderValue.TextBounds.X, SliderValue.TextBounds.Y)
                SliderValue.Position = UDim2.new(1, SliderValue.TextBounds.X / 2, 0, -4)
            end
            -- separator
            Library.Flags[Options.Flag] = Slider
            Options.Callback(tonumber(GetValue(Value)))
        end
        -- separator
        SetValue(Options.Default)
        -- separator
        function Slider:Get()
            return tonumber(GetValue(Slider.CurrentValue))
        end
        -- separator
        function Slider:Max()
            return Options.Max
        end
        -- separator
        function Slider:Min()
            return Options.Min
        end
        -- separator
        function Slider:Set(Value)
            if not Value then return end
            -- separator
            SetValue(Value, Options.OverrideLimit) -- allow overriding limits for api calls too
        end
        -- separator
        function Slider:GetName()
            return Options.Name
        end
        -- separator
        function Slider:SetVisible(Bool)
            local OldValues = Library.Objects[PreviewSlider]
            -- separator
            Slider.Hiding = not Bool
            SliderValue.Visible = Bool
            -- separator
            if Bool then
                Library.Objects[PreviewSlider] = {PreviewSlider, OldValues[2], true}
            end
            -- separator
            Library:Fade(Bool, Library:GetObjectsTable(PreviewSlider), PreviewSlider, 0.075)
            Library:TweenObject(PreviewSlider, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and (Options.Name == "" and UDim2.new(1, 0, 0, 7) or UDim2.new(1, 0, 0, 20)) or UDim2.new(1, 0, 0, -10)}, function()
                if not Bool then
                    Library.Objects[PreviewSlider] = {PreviewSlider, OldValues[2], false}
                end
            end)
        end
        -- separator
        local function SlideBar(Input)
            local SizeX = (Input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X
            local Value = math.clamp((Options.Max - Options.Min) * SizeX + Options.Min, Options.Min, Options.Max)
            -- separator
            SetValue(Value)
        end
        -- separator
        do -- Connections
            Library:Connection(SliderOutline.MouseEnter, function()
                if Library.UI.Faded then return end
                -- separator
                Library:TweenObject(SliderBack, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
            end)
            -- separator
            Library:Connection(SliderOutline.MouseLeave, function()
                if Library.UI.Faded then return end
                -- separator
                Library:TweenObject(SliderBack, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(205, 205, 205)})
            end)
            -- separator
            Library:Connection(MinusActualButton.MouseButton1Click, function()
                if Library.UI.Faded then return end
                -- separator
                Slider:Set(Slider.CurrentValue - Options.Decimal)
            end)
            -- separator
            Library:Connection(AddActualButton.MouseButton1Click, function()
                if Library.UI.Faded then return end
                -- separator
                Slider:Set(Slider.CurrentValue + Options.Decimal)
            end)
            -- separator
            Library:Connection(Button_4.MouseButton1Down, function()
                if Library.UI.Faded then return end
                -- separator
                Library.UI.DraggingGui = SliderDrag
                Slider.MouseDown = true
                SlideBar({Position = UserInputService:GetMouseLocation()})
            end)
            -- separator
            Library:Connection(SliderValue.FocusLost, function()
                local NewValue = tonumber(SliderValue.Text)
                -- separator
                if NewValue then
                    SetValue(NewValue, Options.OverrideLimit) -- pass true to allow exceeding max
                else
                    SetValue(Options.Min)
                end
            end)
            -- separator
            Library:Connection(UserInputService.InputChanged, function(Input)
                if Library.UI.Faded then return end
                -- separator
                if Library.UI.DraggingGui ~= SliderDrag and not (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                    return
                end
                -- separator
                if Slider.MouseDown and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    SlideBar(Input)
                end
            end)
            -- separator
            Library:Connection(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Slider.MouseDown = false
                end
            end)
        end
        -- separator
        if Options.Hidden then
            Slider:SetVisible(false)
        end
        -- separator
        return Slider
    end
    -- separator
    function Library:Toggle(Options)
        Options = Library:Validate({
            Default = false,
            Name = "Preview Toggle",
            Risky = false,
            SectionName = nil,
            Parent = nil,
            Hidden = false,
            AnchorPoint = Vector2.new(0, 0),
            MainUI = nil,
            Size = UDim2.new(1, 0, 0, 8),
            Position = UDim2.new(0, 0, 0, 0),
            UseToggleOutline = false,
            ZIndex = 2,
            Flag = Library:NewFlag(),
            Callback = function() end
        }, Options or {})
        -- separator
        local Toggle = {
            Active = false,
            Hovering = false,
            State = false,
            Hiding = false,
            MainUI = Options.MainUI,
            TabUI = Options.TabUI,
            ColorPickers = {},
            KeybindState = false,
        }
        -- separator
        Library.Flags[Options.Flag] = Toggle
        -- separator
        local PreviewToggle = Library:CreateObject("Frame", {
            Name = "PreviewToggle",
            BackgroundTransparency = 1,
            Size = Options.Size,
            Position = Options.Position,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Options.AnchorPoint,
            ZIndex = Options.ZIndex or 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local ToggleOutline = Library:CreateObject("Frame", {
            Name = "ToggleOutline",
            Size = UDim2.new(0, 8, 0, 8),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = Options.ZIndex or 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewToggle
        })
        -- separator
        if Options.UseToggleOutline then
            ToggleOutline.AnchorPoint = Options.AnchorPoint
            ToggleOutline.Position = Options.Position
        end
        -- separator
        local ToggleInline = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "ToggleInline",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = Options.ZIndex or 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(227, 227, 227),
            Parent = ToggleOutline
        })
        -- separator
        local UIGradient_3 = Library:CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 84, 84)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 74, 74))
            },
            Parent = ToggleInline
        })
        -- separator
        local ToggleMain = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "ToggleInline",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = Options.ZIndex or 2,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ToggleOutline
        })
        -- separator
        Library.Objects[ToggleMain] = {ToggleMain, {BackgroundTransparency = ToggleMain.BackgroundTransparency}, false}
        -- separator
        local UIGradient_32 = Library:CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Library.Theme.Default.Accent),
                ColorSequenceKeypoint.new(1, Library.Theme.Default.SecondAccent)
            },
            Parent = ToggleMain
        })
        -- separator
        Library:AddTheme(UIGradient_32, {
            Color = {"Accent", "SecondAccent"},
        })
        -- separator
        local ToggleName = Library:CreateObject("TextLabel", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "ToggleName",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = Options.ZIndex or 2,
            FontFace = Library.UI.NewFont,
            RichText = true,
            Text = Options.Name,
            TextColor3 = Options.Risky and Library.Theme.Default.Risky or Library.Theme.Default.TextColor,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewToggle
        })
        -- separator
        if Options.Risky then
            Library:AddTheme(ToggleName, {
                TextColor3 = "Risky",
            })
        end
        -- separator
        local UIPadding_7 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = ToggleName
        })
        -- separator
        local Button_9 = Library:CreateObject("TextButton", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_9",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewToggle
        })
        -- separator
        do -- Functions
            function Toggle:ToggleGUI(Bool)
                if Bool == nil then
                    Toggle.State = not Toggle.State
                else
                    Toggle.State = Bool
                end
                -- separator
                Library:TweenObject(ToggleMain, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = Toggle.State and 0 or 1})
                
                -- update the stored transparency value in the objects table, this is for the temp fix for the toggle out and toggle in 
                -- since this uses instant out and instant in instead of the normal fade in and fade out
                if Library.Objects[ToggleMain] then
                    Library.Objects[ToggleMain][2].BackgroundTransparency = Toggle.State and 0 or 1
                end
                
                -- separator
                Library.Flags[Options.Flag] = Toggle
                Options.Callback(Toggle.State)
            end
            -- separator
            function Toggle:GetName()
                return Options.Name
            end
            -- separator
            function Toggle:GetFlag()
                return Options.Flag
            end
            -- separator
            function Toggle:GetSection()
                return Options.SectionName
            end
            -- separator
            function Toggle:GetState()
                return Toggle.State
            end
            -- separator
            function Toggle:GetCallback(b)
                Options.Callback(b)
            end
            -- separator
            function Toggle:Set(Value)
                Toggle:ToggleGUI(Value)
            end
            -- separator
            function Toggle:SetName(Name)
                Options.Name = Name
                ToggleName.Text = Name
            end
            -- separator
            function Toggle:Get()
                return Toggle.State
            end
            -- separator
            function Toggle:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewToggle]
                -- separator
                Toggle.Hiding = not Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewToggle] = {PreviewToggle, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewToggle), PreviewToggle, 0.075)
                Library:TweenObject(PreviewToggle, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and UDim2.new(1, 0, 0, 8) or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewToggle] = {PreviewToggle, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function Toggle:ColorPicker(Options)
                Options = Library:Validate({
                    Name = "Preview Color Picker",
                    Default = Library.Theme.Default.Accent,
                    Flag = Library.NewFlag(),
                    Alpha = 0,
                    AlphaBar = true,
                    Callback = function() end,
                }, Options or {})
                -- separator
                local ColorPicker = {}
                -- separator
                Toggle.ColorPickers[#Toggle.ColorPickers + 1] = ColorPicker
                -- separator
                local ColorPickerFrame = Library:ColorPicker({
                    Name = Options.Name,
                    Default = Options.Default,
                    Flag = Options.Flag,
                    Alpha = Options.Alpha,
                    AlphaBar = Options.AlphaBar,
                    MainUI = Toggle.MainUI,
                    TabUI = Toggle.TabUI,
                    Callback = Options.Callback,
                    Parent = PreviewToggle,
                    Keybind = Toggle.KeybindState,
                    Count = #Toggle.ColorPickers,
                })
                -- separator
                return ColorPickerFrame
            end
            -- separator
            function Toggle:Keybind(Options)
                Options = Library:Validate({
                    Default = Enum.KeyCode.Backspace,
                    Mode = "Toggle",
                    UseMode = true,
                    HideFromList = false,
                    Blacklisted = {},
                    Hiding = false,
                    ChangeToggle = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end,
                }, Options or {})
                -- separator
                local Keybind = {}
                -- separator
                Toggle.KeybindState = true
                -- separator
                Library:Keybind({
                    Default = Options.Default,
                    Mode = Options.Mode,
                    HideFromList = Options.HideFromList,
                    Blacklisted = Options.Blacklisted,
                    Parent = PreviewToggle,
                    UseMode = Options.UseMode,
                    Toggle = Toggle,
                    MainUI = Toggle.MainUI,
                    TabUI = Toggle.TabUI,
                    Hiding = Options.Hiding,
                    ToggleState = Toggle.State,
                    ChangeToggle = Options.ChangeToggle,
                    Flag = Options.Flag,
                    Callback = Options.Callback,
                    Count = #Toggle.ColorPickers + 1,
                })
                -- separator
                return Keybind
            end
        end
        -- separator
        do -- Connections
            Library:Connection(PreviewToggle.MouseEnter, function()
                if Library.UI.Faded then return end
                -- separator
                Library:TweenObject(ToggleInline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
            end)
            -- separator
            Library:Connection(PreviewToggle.MouseLeave, function()
                if Library.UI.Faded then return end
                -- separator
                Library:TweenObject(ToggleInline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(227, 227, 227)})
            end)
            -- separator
            Library:Connection(Button_9.MouseButton1Click, function()
                if Library.UI.Faded then return end
                -- separator
                if Toggle.Hiding then return end
                -- separator
                Toggle:ToggleGUI()
            end)
        end
        -- separator
        Toggle:ToggleGUI(Options.Default)
        -- separator
        if Options.Hidden then
            Toggle:SetVisible(false)
        end
        -- separator
        return Toggle
    end
    -- separator
    function Library:Label(Options)
        Options = Library:Validate({
            Message = "Preview Label",
            Side = "Left",
            Risky = false,
            Parent = nil,
            MainUI = nil,
            SectionName = nil,
            Hidden = false,
            TabUI = nil,
            Callback = function() end
        }, Options or {})
        -- separator
        local Label = {
            ColorPickers = {},
            KeybindState = false,
            Hiding = false,
            MainUI = Options.MainUI,
            TabUI = Options.TabUI,
            State = true,
        }
        -- separator
        local PreviewLabel = Library:CreateObject("Frame", {
            Name = "PreviewLabel",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 7),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local LabelText = Library:CreateObject("TextLabel", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "ToggleName",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment[Options.Side],
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, -1),
            ZIndex = 2,
            FontFace = Library.UI.NewFont,
            RichText = true,
            Text = Options.Message,
            TextColor3 = Color3.fromRGB(198, 198, 198),
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PreviewLabel
        })
        -- separator
        local UIPadding_7 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = LabelText
        })
        -- separator
        do -- Functions
            function Label:GetName()
                return Options.Message
            end
            -- separator
            function Label:GetState()
                return Label.State
            end
            -- separator
            function Label:GetSection()
                return Options.SectionName
            end
            -- separator
            function Label:GetCallback(Bool)
                Options.Callback(Bool)
            end
            -- separator
            function Label:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewLabel]
                -- separator
                Label.Hiding = not Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewLabel] = {PreviewLabel, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewLabel), PreviewLabel, 0.075)
                Library:TweenObject(PreviewLabel, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and UDim2.new(1, 0, 0, 8) or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewLabel] = {PreviewLabel, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function Label:ColorPicker(Options)
                Options = Library:Validate({
                    Name = "Preview Color Picker",
                    Default = Library.Theme.Default.Accent,
                    Flag = Library.NewFlag(),
                    Alpha = 0,
                    AlphaBar = true,
                    MainUI = nil,
                    Callback = function() end,
                }, Options or {})
                -- separator
                local ColorPicker = {}
                -- separator
                Label.ColorPickers[#Label.ColorPickers + 1] = ColorPicker
                -- separator
                local ColorPickerFrame = Library:ColorPicker({
                    Name = Options.Name,
                    Default = Options.Default,
                    Flag = Options.Flag,
                    Alpha = Options.Alpha,
                    AlphaBar = Options.AlphaBar,
                    MainUI = Label.MainUI,
                    TabUI = Label.TabUI,
                    Callback = Options.Callback,
                    Parent = PreviewLabel,
                    Keybind = Label.KeybindState,
                    Count = #Label.ColorPickers,
                })
                -- separator
                return ColorPickerFrame
            end
            -- separator
            function Label:Keybind(Options)
                Options = Library:Validate({
                    Default = Enum.KeyCode.Backspace,
                    Mode = "Toggle",
                    UseMode = true,
                    HideFromList = false,
                    Blacklisted = {},
                    Hiding = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end,
                }, Options or {})
                -- separator
                local Keybind = {}
                -- separator
                Label.KeybindState = true
                -- separator
                Library:Keybind({
                    Default = Options.Default,
                    Mode = Options.Mode,
                    HideFromList = Options.HideFromList,
                    Blacklisted = Options.Blacklisted,
                    Parent = PreviewLabel,
                    Toggle = Label,
                    UseMode = Options.UseMode,
                    MainUI = Label.MainUI,
                    TabUI = Label.TabUI,
                    Hiding = Options.Hiding,
                    ToggleState = Label.State,
                    Flag = Options.Flag,
                    Callback = Options.Callback,
                    Count = #Label.ColorPickers + 1,
                })
                -- separator
                return Keybind
            end
            -- separator
            --[[function Label:Update()
                LabelText.Size = UDim2.new(LabelText.Size.X.Scale, LabelText.Size.X.Offset, 0, math.huge)
                LabelText.Size = UDim2.new(LabelText.Size.X.Scale, LabelText.Size.X.Offset, 0, LabelText.TextBounds.Y)
                PreviewLabel.Size = UDim2.new(PreviewLabel.Size.X.Scale, PreviewLabel.Size.X.Offset, 0, LabelName.TextBounds.Y + 6)
            end]]
        end
        -- separator
        --Label:Update()
        -- separator
        if Options.Hidden then
            Label:SetVisible(false)
        end
        -- separator
        return Label
    end
    -- separator
    function Library:TextBox(Options)
        Options = Library:Validate({
            Default = "",
            Name = "Preview TextBox",
            Max = 32,
            Parent = nil,
            Size = UDim2.new(1, 0, 0, 19),
            Position = UDim2.new(0, 0, 0, 0),
            NumbersOnly = false,
            ClearOnFocus = false,
            Hidden = false,
            TypedCheck = false,
            CheckIfPressedEnter = false,
            Risky = false,
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        -- separator
        local TextBox = {
            Focused = false,
            Hovering = false,
            Hiding = false,
        }
        -- separator
        Library.Flags[Options.Flag] = TextBox
        -- separator
        local PreviewTextBox = Library:CreateObject("Frame", {
            Name = "PreviewTextBox",
            BackgroundTransparency = 1,
            Size = Options.Size,
            Position = Options.Position,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local TextBoxOutline = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "TextBoxOutline",
            Position = UDim2.new(0, -1, 0, 0),
            Size = UDim2.new(1, -19, 0, 19),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewTextBox
        })
        -- separator
        local TextBoxInline = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "TextBoxInline",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            Parent = TextBoxOutline
        })
        -- separator
        local TextBoxMain = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "TextBoxMain",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(24, 24, 24),
            Parent = TextBoxInline
        })
        -- separator
        local TextBoxObject = Library:CreateObject("TextBox", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Library.Theme.Default.TextColor,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = "",
            ZIndex = 3,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            SelectionStart = 1,
            ClearTextOnFocus = Options.ClearOnFocus,
            PlaceholderColor3 = Library.Theme.Default.TextColor,
            TextXAlignment = Enum.TextXAlignment.Left,
            PlaceholderText = "_",
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = TextBoxMain
        })
        -- separator
        TextBox.Object = TextBoxObject
        -- separator
        local UIPadding_6 = Library:CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 5),
            Parent = TextBoxObject
        })
        -- separator
        local UIPadding_7 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = PreviewTextBox
        })
        -- separator
        do -- Functions
            function TextBox:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewTextBox]
                -- separator
                TextBox.Hiding = not Bool
                TextBoxObject.Visible = Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewTextBox] = {PreviewTextBox, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewTextBox), PreviewTextBox, 0.075)
                Library:TweenObject(PreviewTextBox, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and Options.Size or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewTextBox] = {PreviewTextBox, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function TextBox:Get()
                return TextBoxObject.Text
            end
        end
        -- separator
        do -- Connections
            Library:Connection(TextBoxObject:GetPropertyChangedSignal("Text"), function()
                TextBoxObject.Text = TextBoxObject.Text:sub(1, Options.Max)
                -- separator
                if Options.NumbersOnly then
                    TextBoxObject.Text = TextBoxObject.Text:gsub('[^%d%.%-]+', '')
                end
                -- separator
                if Options.TypedCheck then
                    Library.Flags[Options.Flag] = TextBox
                    Options.Callback(TextBoxObject.Text)
                end
                -- separator
                TextBox.Focused = true
            end)
            -- separator
            Library:Connection(TextBoxObject.Focused, function()
                if Library.UI.Faded then return end
                -- separator
                if TextBox.Hiding then
                    TextBoxObject:ReleaseFocus()
                    -- separator
                    return
                end
                -- separator
                TextBox.Focused = true
                -- separator
                TextBoxObject.TextColor3 = Library.Theme.Default.Accent
                -- separator
                Library:AddTheme(TextBoxObject, {
                    TextColor3 = "Accent",
                })
                -- separator
                TextBoxObject.PlaceholderText = ""
            end)
            -- separator
            Library:Connection(TextBoxObject.FocusLost, function(EnterPressed)
                if Options.CheckIfPressedEnter and not EnterPressed then return end
                -- separator
                TextBox.Focused = false
                TextBoxObject.PlaceholderText = "_"
                -- separator
                TextBoxObject.TextColor3 = Library.Theme.Default.TextColor
                -- separator
                Library:AddTheme(TextBoxObject, {
                    TextColor3 = "TextColor",
                })
                -- separator
                Library.Flags[Options.Flag] = TextBox
                Options.Callback(TextBoxObject.Text)
            end)
        end
        -- separator
        if Options.Hidden then
            TextBox:SetVisible(false)
        end
        -- separator
        return TextBox
    end
    -- separator
    function Library:List(Options)
        Options = Library:Validate({
            Size = 100,
            Hidden = false,
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        -- separator
        local List = {
            CurrentValue = nil,
            CurrentValueName = nil,
        }
        -- separator
        Library.Flags[Options.Flag] = List
        -- separator
        local PreviewList = Library:CreateObject("Frame", {
            Name = "PreviewList",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, Options.Size),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local UIPadding_11 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = PreviewList
        })
        -- separator
        local ListOutline = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -19, 1, -18),
            Name = "ListOutline",
            Position = UDim2.new(0, -1, 0, 18),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewList
        })
        -- separator
        local ListMain = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "ListMain",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 4,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Parent = ListOutline
        })
        -- separator
        local DownArrow = Library:CreateObject("ImageButton", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "DownArrow",
            Image = "rbxassetid://15540867448",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -10, 1, -9),
            Size = UDim2.new(0, 5, 0, 4),
            ZIndex = 7,
            Visible = false,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ListMain
        })
        -- separator
        local UpArrow = Library:CreateObject("ImageButton", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "UpArrow",
            Image = "rbxassetid://15540851994",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -10, 0, 5),
            Size = UDim2.new(0, 5, 0, 4),
            ZIndex = 7,
            Visible = false,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ListMain
        })
        -- separator
        local ListScrolling = Library:CreateObject("ScrollingFrame", {
            ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65),
            MidImage = "rbxassetid://158362264",
            Active = true,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ScrollBarThickness = 5,
            Name = "ListScrolling",
            ZIndex = 3,
            TopImage = "rbxassetid://158362264",
            Position = UDim2.new(0, 1, 0, 1),
            Size = UDim2.new(1, -2, 1, -2),
            BottomImage = "rbxassetid://158362264",
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            CanvasPosition = Vector2.new(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Parent = ListOutline
        })
        -- separator
        local UIListLayout_2 = Library:CreateObject("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = ListScrolling
        })
        -- separator
        local TextBox = Library:TextBox({Parent = PreviewList, TypedCheck = true, Size = UDim2.new(1, 20, 0, 19), Position = UDim2.new(0, -20, 0, 0), Callback = function(Text)
            List:UpdateSection()
            -- separator
            for _, Frame in ListScrolling:GetChildren() do
                if Frame:IsA("Frame") then
                    Frame.Visible = string.find(Frame.Name:lower(), Text:lower()) and true or false
                end
            end
        end})
        -- separator
        do -- Functions
            function List:Get()
                return List.CurrentValueName
            end
            -- separator
            function List:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewList]
                -- separator
                TextBox.Object.Visible = Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewList] = {PreviewList, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewList, false), PreviewList, 0.075)
                Library:TweenObject(PreviewList, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and UDim2.new(1, 0, 0, Options.Size) or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewList] = {PreviewList, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function List:AddValue(Value, Icon)
                if ListScrolling:FindFirstChild(Value) then return end
                -- separator
                local ListValue = {
                    Active = false,
                    Hovering = false,
                }
                -- separator
                local InactiveValue = Library:CreateObject("Frame", {
                    Name = Value .. "1",
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Parent = ListScrolling
                })
                -- separator
                local Button_912 = Library:CreateObject("TextButton", {
                    FontFace = Library.UI.NewFont,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_9",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = Library.UI.FontSize,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = InactiveValue
                })
                -- separator
                local ValueName_1 = Library:CreateObject("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = Color3.fromRGB(208, 208, 208),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "ValueName_1",
                    BorderSizePixel = 0,
                    Text = Value,
                    RichText = true,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 5,
                    TextSize = Library.UI.FontSize,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = InactiveValue
                })
                -- separator
                if Icon then
                    local Color = Icon.Color or Color3.fromRGB(255, 255, 255)
                    -- separator
                    local IconImage = Library:CreateObject("ImageLabel", {
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Image = Icon.Image,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = Icon.Position or UDim2.new(0, 7, 0.5, 0),
                        BackgroundTransparency = 1,
                        Name = "BackImage",
                        Size = Icon.Size or UDim2.new(0, 13, 0, 13),
                        ZIndex = 5,
                        BorderSizePixel = 0,
                        ImageColor3 = Color,
                        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                        Parent = InactiveValue
                    })
                    -- separator
                    local UIPadding_135 = Library:CreateObject("UIPadding", {
                        PaddingLeft = UDim.new(0, 10),
                        Parent = IconImage
                    })
                end
                -- separator
                ValueName_1.Text = Library:ClampString(Value, ValueName_1.AbsoluteSize.X - 25)
                -- separator
                local UIPadding_13 = Library:CreateObject("UIPadding", {
                    PaddingLeft = UDim.new(0, (Icon and 25 or 10)),
                    Parent = ValueName_1
                })
                -- separator
                do -- Functions
                    function ListValue:Activate()
                        if not ListValue.Active then
                            -- separator
                            if List.CurrentValue then
                                List.CurrentValue:Deactivate()
                            end
                            -- separator
                            ListValue.Active = true
                            -- separator
                            ValueName_1.TextColor3 = Library.Theme.Default.Accent
                            ValueName_1.Text = "<b>" .. Value .. "</b>"
                            -- separator
                            Library:AddTheme(ValueName_1, {
                                TextColor3 = "Accent",
                            })
                            -- separator
                            List.CurrentValue = ListValue
                            List.CurrentValueName = Value
                            Library.Flags[Options.Flag] = List
                            Options.Callback(Value)
                        end
                    end
                    -- separator
                    function ListValue:Deactivate()
                        if ListValue.Active then
                            ListValue.Active = false
                            ListValue.Hovering = false
                            ValueName_1.TextColor3 = Library.Theme.Default.TextColor
                            -- separator
                            Library:AddTheme(ValueName_1, {
                                TextColor3 = "TextColor",
                            })
                        end
                    end
                end
                -- separator
                do -- Connections
                    local OldText = ValueName_1.Text
                    -- separator
                    Library:Connection(PreviewList:GetPropertyChangedSignal("AbsoluteSize"), function()
                        ValueName_1.Text = Library:ClampString(Value, ValueName_1.AbsoluteSize.X - 25)
                    end)
                    -- separator
                    Library:Connection(InactiveValue.MouseEnter, function()
                        if Library.UI.Faded then return end
                        -- separator
                        InactiveValue.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                        OldText = ValueName_1.Text
                        -- separator
                        if not ListValue.Active then
                            ValueName_1.Text = "<b>" .. OldText .. "</b>"
                        end
                    end)
                    -- separator
                    Library:Connection(InactiveValue.MouseLeave, function()
                        if Library.UI.Faded then return end
                        -- separator
                        InactiveValue.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        -- separator
                        if not ListValue.Active then
                            ValueName_1.Text = OldText
                        end
                    end)
                    -- separator
                    Library:Connection(Button_912.MouseButton1Click, function()
                        if Library.UI.Faded then return end
                        -- separator
                        ListValue:Activate()
                    end)
                end
            end
            -- separator
            function List:RemoveValue(Value)
                for _, Object in ListScrolling:GetChildren() do
                    if Object.Name == Value .. "1" then
                        Object:Destroy()
                    end
                end
            end
            -- separator
            function List:UpdateSection()
                local CanvasSize = ListScrolling.AbsoluteCanvasSize.Y
                local AbsoluteSize = ListMain.AbsoluteSize.Y
                -- separator
                if CanvasSize > AbsoluteSize then
                    ListMain.Size = UDim2.new(1, -8, 1, -2)
                    UpArrow.Visible = not List:CheckArrows("Up")
                    DownArrow.Visible = not List:CheckArrows("Down")
                elseif CanvasSize == AbsoluteSize then
                    ListMain.Size = UDim2.new(1, -2, 1, -2)
                    UpArrow.Visible = false
                    DownArrow.Visible = false
                end
            end
            -- separator
            function List:CheckArrows(Type)
                if Type == "Up" then
                    return ListScrolling.CanvasPosition == Vector2.new(0, 0)
                elseif Type == "Down" then
                    return ListScrolling.CanvasPosition == Vector2.new(0, ListScrolling.AbsoluteCanvasSize.Y - ListScrolling.AbsoluteSize.Y)
                else
                    return false
                end
            end
        end
        -- separator
        List:UpdateSection()
        -- separator
        do -- Connections
            Library:Connection(ListScrolling.ChildAdded, function()
                List:UpdateSection()
            end)
            -- separator
            Library:Connection(ListScrolling.ChildRemoved, function()
                List:UpdateSection()
            end)
            -- separator
            Library:Connection(ListOutline:GetPropertyChangedSignal("AbsoluteSize"), function()
                List:UpdateSection()
            end)
            -- separator
            Library:Connection(ListScrolling:GetPropertyChangedSignal("AbsoluteSize"), function()
                List:UpdateSection()
            end)
            -- separator
            Library:Connection(ListScrolling:GetPropertyChangedSignal("CanvasPosition"), function()
                List:UpdateSection()
            end)
            -- separator
            Library:Connection(UpArrow.MouseButton1Click, function()
                if Library.UI.Faded then return end
                -- separator
                if not UpArrow.Visible then return end
                -- separator
                Library:TweenObject(ListScrolling, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, 0)})
            end)
            -- separator
            Library:Connection(DownArrow.MouseButton1Click, function()
                if Library.UI.Faded then return end
                -- separator
                if not DownArrow.Visible then return end
                -- separator
                Library:TweenObject(ListScrolling, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, ListScrolling.AbsoluteCanvasSize.Y - ListScrolling.AbsoluteSize.Y)})
            end)
        end
        -- separator
        if Options.Hidden then
            List:SetVisible(false)
        end
        -- separator
        return List
    end
    -- separator
    function Library:Button(Options)
        Options = Library:Validate({
            Name = "Preview Button",
            Confirmation = false,
            Parent = nil,
            Hidden = false,
            Size = UDim2.new(1, 0, 0, 25),
            Position = UDim2.new(0, 0, 0, 0),
            Risky = false,
            Callback = function() end
        }, Options or {})
        -- separator
        local Button = {
            MouseDown = false,
            Hovering = false,
            WaitingForConfirm = false,
            Hiding = false,
            ConfirmationTime = 0,
            ConfirmationConnection = nil,
        }
        -- separator
        local PreviewButton = Library:CreateObject("Frame", {
            Name = "PreviewButton",
            BackgroundTransparency = 1,
            Size = Options.Size,
            Position = Options.Position,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Options.Parent
        })
        -- separator
        local ButtonOutline = Library:CreateObject("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "ButtonOutline",
            Position = UDim2.new(0, -1, 0, 0),
            Size = UDim2.new(1, -19, 0, 25),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = PreviewButton
        })
        -- separator
        local ButtonInline = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "ButtonInline",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            Parent = ButtonOutline
        })
        -- separator
        local ButtonMain_1 = Library:CreateObject("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Name = "ButtonMain_1",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(220, 220, 220),
            Parent = ButtonInline
        })
        -- separator
        local UIGradient_4 = Library:CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 39, 39)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
            },
            Parent = ButtonMain_1
        })
        -- separator
        local Button_6 = Library:CreateObject("TextButton", {
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = Options.Risky and Library.Theme.Default.Risky or Library.Theme.Default.TextColor,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button_6",
            RichText = true,
            Text = "<b>" .. Options.Name .. "</b>",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 3,
            TextSize = Library.UI.FontSize,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = ButtonOutline
        })
        -- separator
        if Options.Risky then
            Library:AddTheme(Button_6, {
                TextColor3 = "Risky",
            })
        end
        -- separator
        local UIPadding_8 = Library:CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 20),
            Parent = PreviewButton
        })
        -- separator
        do -- Functions
            function Button:UpdateSize(Size)
                ButtonOutline.Size = Size
            end
            -- separator
            function Button:UpdatePosition(Position)
                PreviewButton.Position = Position
            end
            -- separator
            function Button:SetVisible(Bool)
                local OldValues = Library.Objects[PreviewButton]
                -- separator
                Button.Hiding = not Bool
                -- separator
                if Bool then
                    Library.Objects[PreviewButton] = {PreviewButton, OldValues[2], true}
                end
                -- separator
                Library:Fade(Bool, Library:GetObjectsTable(PreviewButton), PreviewButton, 0.075)
                Library:TweenObject(PreviewButton, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = Bool and Options.Size or UDim2.new(1, 0, 0, -10)}, function()
                    if not Bool then
                        Library.Objects[PreviewButton] = {PreviewButton, OldValues[2], false}
                    end
                end)
            end
            -- separator
            function Button:ConfirmationStart()
                Button.MouseDown = true
                Button.WaitingForConfirm = true
                Button.ConfirmationTime = 3
                Button_6.Text = "<b>Are you sure?</b>"
                -- separator
                if Button.ConfirmationConnection then
                    coroutine.close(Button.ConfirmationConnection)
                    Button.ConfirmationConnection = nil
                end
                -- separator
                Button.ConfirmationConnection = coroutine.create(function()
                    for i = 1, 3 do 
                        task.wait(1)
                        -- separator
                        Button.ConfirmationTime = Button.ConfirmationTime - 1
                        -- separator
                        if Button.ConfirmationTime <= 0 then
                            Button_6.Text = "<b>" .. Options.Name .. "</b>"
                            -- separator
                            if Button.MouseDown then
                                Library:TweenObject(Button_6, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextColor3 = Library.Theme.Default.TextColor})
                                -- separator
                                Button.MouseDown = false
                                Button.WaitingForConfirm = false
                            end
                            -- separator
                            break
                        end
                    end
                end)
                -- separator
                coroutine.resume(Button.ConfirmationConnection)
            end
        end
        -- separator
        do -- Connections
            Library:Connection(Button_6.MouseButton1Down, function()
                if Library.UI.Faded then return end
                -- separator
                if Button.Hiding then return end
                -- separator
                Library:TweenObject(ButtonMain_1, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(180, 180, 180)})
                -- separator
                if Options.Confirmation then
                    if not Button.WaitingForConfirm then
                        Button:ConfirmationStart()
                    else
                        if Button.ConfirmationConnection then
                            coroutine.close(Button.ConfirmationConnection)
                            Button.ConfirmationConnection = nil
                        end
                        -- separator
                        Options.Callback()
                        Button.MouseDown = true
                        Button.Hovering = false
                        Button.WaitingForConfirm = false
                        -- separator
                        Library:TweenObject(ButtonMain_1, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(180, 180, 180)})
                        -- separator
                        Button_6.Text = "<b>" .. Options.Name .. "</b>"
                    end
                else
                    Options.Callback()
                    Button.MouseDown = true
                end
            end)
            -- separator
            Library:Connection(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and Button.MouseDown and not Button.WaitingForConfirm then
                    Button.Hovering = false
                    Button.MouseDown = false
                end
                -- separator
                Library:TweenObject(ButtonMain_1, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(220, 220, 220)})
            end)
            -- separator
            Library:Connection(ButtonOutline.MouseEnter, function()
                if Library.UI.Faded then return end
                -- separator
                if not Button.MouseDown then
                    Button.Hovering = true
                    Library:TweenObject(ButtonMain_1, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                end	
            end)
            -- separator
            Library:Connection(ButtonOutline.MouseLeave, function()
                if Library.UI.Faded then return end
                -- separator
                if not Button.MouseDown then
                    Button.Hovering = false
                    Library:TweenObject(ButtonMain_1, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(220, 220, 220)})
                end	
            end)
        end
        -- separator
        if Options.Hidden then
            Button:SetVisible(false)
        end
        -- separator
        return Button
    end
    -- separator
    function Library:Window(Options)
        Options = Library:Validate({
            Name = "gamesense",
            Size = UDim2.new(0, 700, 0, 612),
            MinResize = UDim2.new(0, 500, 0, 400),
            MaxResize = UDim2.new(0, 10000, 0, 10000),
            CloseBind = Enum.KeyCode.Insert,
        }, Options or {})
        -- separator
        local Window = {
            Visible = true,
            CurrentTab = nil,
            Tabs = {},
        }
        -- separator
        local MainUI = Library:CreateObject("ScreenGui", {
            ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
            DisplayOrder = 1000,
            ResetOnSpawn = false,
            IgnoreGuiInset = true,
            Name = "\0",
            Parent = gethui()
        })
        -- separator
        Library.UI.ScreenGUI = MainUI
        -- separator
        local Outline = Library:CreateObject("Frame", {
            Name = "Outline",
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = Options.Size,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            Parent = MainUI
        })
        -- separator
        Outline:SetAttribute("g", Window.CurrentTab)
        Library.UI.MainUI = Outline
        -- separator
        Outline.Position = UDim2.fromOffset((Viewport.X / 2) - (Outline.Size.X.Offset / 2), (Viewport.Y / 2) - (Outline.Size.Y.Offset / 2))
        Outline.Active = true
        Outline.Draggable = true
        -- separator
        local Inline = Library:CreateObject("Frame", {
            Name = "Inline",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Parent = Outline
        })
        -- separator
        local Inner = Library:CreateObject("Frame", {
            Name = "Inner",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Parent = Inline
        })
        -- separator
        local Outline_1 = Library:CreateObject("Frame", {
            Name = "Outline_1",
            Position = UDim2.new(0, 3, 0, 3),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -6, 1, -6),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Parent = Inner
        })
        -- separator
        local PatternHolder = Library:CreateObject("Frame", {
            Name = "PatternHolder",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            Parent = Outline_1
        })
        -- separator
        local Pattern = Library:CreateObject("ImageLabel", {
            ImageColor3 = Color3.fromRGB(12, 12, 12),
            ScaleType = Enum.ScaleType.Tile,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Image = "rbxassetid://8547666218",
            BackgroundTransparency = 1,
            Name = "Pattern",
            Size = UDim2.new(1, 0, 1, 0),
            TileSize = UDim2.new(0, 8, 0, 8),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = PatternHolder
        })
        -- separator
        local TopBarGradientHolder = Library:CreateObject("Frame", {
            Name = "TopBarGradientHolder",
            Position = UDim2.new(0, 1, 0, 1),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, -2, 0, 4),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Outline_1
        })
        -- separator
        local GradientBar = Library:CreateObject("ImageLabel", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Image = "rbxassetid://8508019876",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 1, 0, 1),
            Name = "GradientBar",
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = TopBarGradientHolder
        })
        -- separator
        local UIGradient = Library:CreateObject("UIGradient", {
            Rotation = 90,
            Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 0.550000011920929)
            },
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 12)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
            },
            Parent = TopBarGradientHolder
        })
        -- separator
        local SideBarMain = Library:CreateObject("Frame", {
            Name = "SideBarMain",
            Position = UDim2.new(0, 1, 0, 5),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(0, 75, 1, -6),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            ClipsDescendants = true,
            Parent = Outline_1
        })
        -- separator
        local Outline_2 = Library:CreateObject("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            Name = "Outline_2",
            Position = UDim2.new(1, 0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(0, 1, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Parent = SideBarMain
        })
        -- separator
        local Holder = Library:CreateObject("Frame", {
            BackgroundTransparency = 1,
            Name = "Holder",
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = SideBarMain
        })
        -- separator
        local UIListLayout = Library:CreateObject("UIListLayout", {
            Padding = UDim.new(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Holder
        })
        -- separator
        local UIPadding = Library:CreateObject("UIPadding", {
            PaddingTop = UDim.new(0, 10),
            Parent = Holder
        })
        -- separator
        local Inline_4 = Library:CreateObject("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            Name = "Inline_4",
            Position = UDim2.new(1, -1, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(0, 1, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Parent = SideBarMain
        })
        -- separator
        local ResizeButton = Library:CreateObject("TextButton", {
            FontFace = Library.UI.NewFont,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Button",
            AnchorPoint = Vector2.new(1, 1),
            Size = UDim2.new(0, 20, 0, 20),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = Library.UI.FontSize,
            ZIndex = 5,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Outline
        })
        -- separator
        do -- Functions
            function Window:SetTab(Number)
                for Index, Tab in Window.Tabs do
                    if Index == Number then
                        if Window.CurrentTab ~= nil then
                            Window.CurrentTab:Deactivate()
                        end
                        -- separator
                        Tab:Activate()
                    end
                end
            end
        end
        -- separator
        do -- Connections
            Library:Connection(UserInputService.InputBegan, function(Input)
                if Input.KeyCode == Library.UI.CloseBind then
                    Window.Visible = not Window.Visible
                    -- separator
                    Library:Fade(Window.Visible, Library.Objects, Outline, 0.2)
                end
            end)
            -- separator
            Library:Resizable(Outline, ResizeButton, Options.MinResize, Options.MaxResize)
        end
        -- separator
        function Window:CreateTab(Options)
            Options = Library:Validate({
                Icon = "rbxassetid://8547236654",
            }, Options or {})
            -- separator
            local Tab = {
                Hovering = false,
                Active = false,
                Index = Library.UI.TabIndex + 1,
                SubSectionEnabled = false,
                DropdownSectionEnabled = false,
                Position = "Bottom",
                Sides = {
                    Left = {
                        Sections = {},
                        Sizes = 0,
                    },
                    Right = {
                        Sections = {},
                        Sizes = 0,
                    }
                }
            }
            -- separator
            Library.UI.TabIndex = Tab.Index
            -- separator
            local TabActive = Library:CreateObject("Frame", {
                BackgroundTransparency = 1,
                Name = "TabActive",
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, -2, 0, 64),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = Holder
            })
            -- separator
            local Outline_3 = Library:CreateObject("Frame", {
                Name = "Outline_3",
                Size = UDim2.new(1, 0, 1, 0),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                Visible = false,
                Parent = TabActive
            })
            -- separator
            local Inline_1 = Library:CreateObject("Frame", {
                Size = UDim2.new(1, 1, 1, -2),
                Name = "Inline_1",
                Position = UDim2.new(0, 0, 0, 1),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                Parent = Outline_3
            })
            -- separator
            local Main = Library:CreateObject("Frame", {
                Size = UDim2.new(1, 1, 1, -2),
                Name = "Main",
                Position = UDim2.new(0, 0, 0, 1),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                Parent = Inline_1
            })
            -- separator
            local Pattern_1 = Library:CreateObject("ImageLabel", {
                ImageColor3 = Color3.fromRGB(12, 12, 12),
                ScaleType = Enum.ScaleType.Tile,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Name = "Pattern_1",
                Image = "rbxassetid://8547666218",
                BackgroundTransparency = 1,
                TileSize = UDim2.new(0, 8, 0, 8),
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                Parent = Main
            })
            -- separator
            local Button = Library:CreateObject("TextButton", {
                FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Name = "Button",
                Text = Options.Icon,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                TextColor3 = Color3.fromRGB(90, 90, 90),
                BorderSizePixel = 0,
                TextTransparency = 1,
                TextSize = Library.UI.FontSize,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = TabActive
            })
            -- separator
            local Icon = Library:CreateObject("ImageLabel", {
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Name = "Button",
                Image = Options.Icon,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                ImageColor3 = Color3.fromRGB(109, 109, 109),
                BorderSizePixel = 0,
                ZIndex = 3,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = TabActive
            })
            -- separator
            local SectionsHolder = Library:CreateObject("Frame", {
                Name = "SectionsHolder",
                BackgroundTransparency = 1,
                Visible = true,
                Position = UDim2.new(0, 76, 0, 5),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, -78, 1, -6),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                ClipsDescendants = true,
                Parent = Outline_1
            })
            -- separator
            local Left = Library:CreateObject("Frame", {
                BackgroundTransparency = 1,
                Name = "Left",
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0, 1, 0, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                ClipsDescendants = true,
                Parent = SectionsHolder
            })
            -- separator
            local UIPadding_1 = Library:CreateObject("UIPadding", {
                PaddingTop = UDim.new(0, 19),
                PaddingBottom = UDim.new(0, 19),
                PaddingRight = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 21),
                Parent = Left
            })
            -- separator
            local UIListLayout12 = Library:CreateObject("UIListLayout", {
                Padding = UDim.new(0, 19),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = Left
            })
            -- separator
            local Right = Library:CreateObject("Frame", {
                Name = "Right",
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 1, 0, 0),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(0.5, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                ClipsDescendants = true,
                Parent = SectionsHolder
            })
            -- separator
            local UIPadding_2 = Library:CreateObject("UIPadding", {
                PaddingTop = UDim.new(0, 19),
                PaddingBottom = UDim.new(0, 19),
                PaddingRight = UDim.new(0, 19),
                PaddingLeft = UDim.new(0, 10),
                Parent = Right
            })
            -- separator
            local UIListLayout52 = Library:CreateObject("UIListLayout", {
                Padding = UDim.new(0, 19),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = Right
            })
            -- separator
            local SectionsHolder2 = Library:CreateObject("Frame", {
                Name = "SectionsHolder",
                BackgroundTransparency = 1,
                Visible = true,
                Position = UDim2.new(0, 76, 0, 5),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, -78, 1, -6),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                ClipsDescendants = true,
                Parent = Outline_1
            })
            -- separator
            local SubSectionHolder = Library:CreateObject("Frame", {
                Name = "SubSectionHolder",
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, -39, 0, 61),
                BorderSizePixel = 0,
                ZIndex = 1,
                Visible = false,
                BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                Parent = SectionsHolder2
            })
            -- separator
            Left.Position = UDim2.new(0, 0, 0, Left.AbsoluteSize.Y)
            Right.Position = UDim2.new(0.5, 1, 0, Right.AbsoluteSize.Y)
            SubSectionHolder.Position = UDim2.new(0, 21, 0, SectionsHolder2.AbsoluteSize.Y + SubSectionHolder.AbsoluteSize.Y)
            -- separator
            do -- Functions
                function Tab:MoveSides(State)
                    task.spawn(function()
                        if State then
                            if Tab.Position == "Bottom" then
                                Left.Position = UDim2.new(0, 0, 0, Left.AbsoluteSize.Y)
                                Right.Position = UDim2.new(0.5, 1, 0, Right.AbsoluteSize.Y)
                                SubSectionHolder.Position = UDim2.new(0, 21, 0, SectionsHolder2.AbsoluteSize.Y + SubSectionHolder.AbsoluteSize.Y)
                            else
                                Left.Position = UDim2.new(0, 0, 0, -Left.AbsoluteSize.Y)
                                Right.Position = UDim2.new(0.5, 1, 0, -Right.AbsoluteSize.Y)
                                SubSectionHolder.Position = UDim2.new(0, 21, 0, -(SectionsHolder2.AbsoluteSize.Y + SubSectionHolder.AbsoluteSize.Y))
                            end
                            -- separator
                            Library:TweenObject(SubSectionHolder, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 21, 0, 19)})
                            Library:TweenObject(Left, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)})
                            Library:TweenObject(Right, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 1, 0, 0)})
                        else
                            task.wait(0.001)
                            -- separator
                            local SubSectionPosition = Tab.Position == "Bottom" and SectionsHolder2.AbsoluteSize.Y + 10 or -SectionsHolder2.AbsoluteSize.Y
                            local LeftPosition = Tab.Position == "Bottom" and Left.AbsoluteSize.Y + 10 or -Left.AbsoluteSize.Y
                            local RightPosition = Tab.Position == "Bottom" and Right.AbsoluteSize.Y + 10 or -Right.AbsoluteSize.Y
                            -- separator
                            Library:TweenObject(SubSectionHolder, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 21, 0, SubSectionPosition)})
                            Library:TweenObject(Left, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, LeftPosition)})
                            Library:TweenObject(Right, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 1, 0, RightPosition)})
                        end
                    end)
                end
                -- separator
                function Tab:Activate()
                    if not Tab.Active then
                        -- separator
                        if Window.CurrentTab ~= nil then
                            Window.CurrentTab:Deactivate()
                        end
                        -- separator
                        Tab.Active = true
                        Tab:MoveSides(true)
                        -- separator
                        Library:TweenObject(Icon, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(210, 210, 210)})
                        Outline_3.Visible = true
                        -- separator
                        Window.CurrentTab = Tab
                        Outline:SetAttribute("g", table.find(Window.Tabs, Tab))
                    end
                end
                -- separator
                function Tab:Deactivate()
                    if Tab.Active then
                        Tab.Active = false
                        Tab.Hovering = false
                        Outline_3.Visible = false
                        Library:TweenObject(Icon, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(90, 90, 90)})
                        -- separator
                        Tab:MoveSides(false)
                    end
                end
            end
            -- separator
            do -- Connections
                Library:Connection(Outline:GetAttributeChangedSignal("g"), function()
                    if Outline:GetAttribute("g") > Tab.Index then
                        Tab.Position = "Top"
                    elseif Outline:GetAttribute("g") < Tab.Index then
                        Tab.Position = "Bottom"
                    end
                end)
                -- separator
                Library:Connection(Outline:GetPropertyChangedSignal("AbsoluteSize"), function()
                    if not Tab.Active then
                        SubSectionHolder.Position = UDim2.new(0, 21, 0, SectionsHolder2.AbsoluteSize.Y + SubSectionHolder.AbsoluteSize.Y)
                        Left.Position = UDim2.new(0, 0, 0, Left.AbsoluteSize.Y)
                        Right.Position = UDim2.new(0.5, 1, 0, Right.AbsoluteSize.Y)
                    else
                        Left.Position = UDim2.new(0, 0, 0, 0)
                        Right.Position = UDim2.new(0.5, 1, 0, 0)
                    end
                end)
                -- separator
                Library:Connection(Button.MouseButton1Click, function()
                    Tab:Activate()
                end)
                -- separator
                Library:Connection(TabActive.MouseEnter, function()
                    if not Tab.Active then
                        Tab.Hovering = true
                        Library:TweenObject(Icon, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(168, 168, 168)})
                    end
                end)
                -- separator
                Library:Connection(TabActive.MouseLeave, function()
                    if not Tab.Active then
                        Tab.Hovering = false
                        Library:TweenObject(Icon, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(90, 90, 90)})
                    end
                end)
            end
            -- separator
            Window.Tabs[#Window.Tabs + 1] = Tab
            -- separator
            function Tab:Section(Options)
                Options = Library:Validate({
                    Name = "Preview Section",
                    Side = "Left",
                    Fill = false,
                    Size = UDim2.new(1, 0, 0, 40),
                    ParentOptions = {},
                    Icon = nil,
                    Parent = nil,
                }, Options or {})
                -- separator
                local Section = {
                    Elements = {},
                    SizeButton = nil,
                    Hovering = false,
                    DragConnection = nil,
                    Left = {
                        Order = 1,
                    },
                    Right = {
                        Order = 1,
                    },
                }
                -- separator
                local Parent = Options.Side == "Left" and Left or Right
                -- separator
                local SectionOutline = Library:CreateObject("Frame", {
                    Name = "SectionOutline",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, Options.Size),
                    AutomaticSize = Options.Fill and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
                    BorderSizePixel = 0,
                    ZIndex = 1,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = Options.Parent or Parent
                })
                -- separator
                table.insert(Tab.Sides[Options.Side].Sections, SectionOutline)
                -- separator
                task.delay(0.01, function()
                    if Options.Fill == false then
                        Tab.Sides[Options.Side].Sizes += SectionOutline.AbsoluteSize.Y + 19
                    end
                    -- separator
                    if Options.Fill then
                        SectionOutline.Size = UDim2.new(1, 0, 1, -(Tab.Sides[Options.Side].Sizes))
                    else
                        SectionOutline.Size = UDim2.new(1, 0, 0, Options.Size)
                    end
                end)
                -- separator
                local SectionInline = Library:CreateObject("Frame", {
                    Name = "SectionInline",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    Parent = SectionOutline
                })
                -- separator
                local SectionScrolling = Library:CreateObject("ScrollingFrame", {
                    ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65),
                    MidImage = "rbxassetid://158362264",
                    Active = true,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ScrollBarThickness = 5,
                    Size = UDim2.new(1, -2, 1, -2),
                    TopImage = "rbxassetid://158362264",
                    Position = UDim2.new(0, 1, 0, 1),
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    CanvasPosition = Vector2.new(0, 0),
                    BottomImage = "rbxassetid://158362264",
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    Parent = SectionInline
                })
                -- separator
                local UIListLayout_3 = Library:CreateObject("UIListLayout", {
                    Padding = UDim.new(0, 10),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = SectionScrolling
                })
                -- separator
                local UIPadding_8 = Library:CreateObject("UIPadding", {
                    PaddingTop = UDim.new(0, 19),
                    PaddingBottom = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 18),
                    PaddingLeft = UDim.new(0, 18),
                    Parent = SectionScrolling
                })
                -- separator
                local SectionMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "SectionMain_1",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 1,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(23, 23, 23),
                    Parent = SectionInline
                })
                -- separator
                local SectionFader = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, 0, 0, 20),
                    AnchorPoint = Vector2.new(0, 1),
                    Name = "SectionFader",
                    Position = UDim2.new(0, 0, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(23, 23, 23),
                    Parent = SectionMain
                })
                -- separator
                local DownArrow = Library:CreateObject("ImageButton", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "DownArrow",
                    Image = "rbxassetid://15540867448",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -10, 1, -9),
                    Size = UDim2.new(0, 5, 0, 4),
                    ZIndex = 4,
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = SectionMain
                })
                -- separator
                local UpArrow = Library:CreateObject("ImageButton", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "UpArrow",
                    Image = "rbxassetid://15540851994",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -10, 0, 5),
                    Size = UDim2.new(0, 5, 0, 4),
                    ZIndex = 4,
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = SectionMain
                })
                -- separator
                local UIGradient = Library:CreateObject("UIGradient", {
                    Rotation = -90,
                    Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    },
                    Parent = SectionFader
                })
                -- separator
                local SectionFader2 = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, 0, 0, 20),
                    Name = "SectionFader",
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(23, 23, 23),
                    Parent = SectionMain
                })
                -- separator
                local UIGradient = Library:CreateObject("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    },
                    Parent = SectionFader2
                })
                -- separator
                local TitleInline = Library:CreateObject("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "TitleInline",
                    BorderSizePixel = 0,
                    Parent = SectionOutline,
                    Position = UDim2.new(0, 9, 0, 0),
                    Size = UDim2.new(0, 0, 0, 2),
                    ZIndex = 5
                })
                -- separator
                local UIGradient2 = Library:CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 19, 19)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 24, 24))
                    },
                    Parent = TitleInline
                })
                -- separator
                local Title = Library:CreateObject("TextButton", {
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    Parent = SectionOutline,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -26, 0, 15),
                    ZIndex = 5,
                    FontFace = Library.UI.NewFont,
                    RichText = true,
                    Text = "<b>" .. Options.Name .. "</b>",
                    TextColor3 = Color3.fromRGB(198, 198, 198),
                    TextSize = Library.UI.FontSize,
                    TextStrokeTransparency = 1,
                    TextXAlignment = "Left"
                })
                -- separator
                local ResizableButton_6 = Library:CreateObject("ImageButton", {
                    ImageColor3 = Color3.fromRGB(40, 40, 40),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(1, 1),
                    Image = "http://www.roblox.com/asset/?id=127012144286347",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -2, 1, -2),
                    Name = "ResizableButton_6",
                    Size = UDim2.new(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    ZIndex = 5,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = SectionOutline
                })
                -- separator
                Section.Elements = {
                    Name = Title,
                    ContentHolder = SectionScrolling,
                }
                -- separator
                Title.Size = UDim2.fromOffset(Title.TextBounds.X, 15)
                TitleInline.Size = UDim2.new(0, Title.TextBounds.X + 6, 0, 2)
                -- separator
                do -- Functions
                    function Section:UpdateSection()
                        local CanvasSizeFloored = math.floor(SectionScrolling.AbsoluteCanvasSize.Y)
                        local AbsoluteSizeFloored = math.floor(SectionMain.AbsoluteSize.Y)
                        -- separator
                        if CanvasSizeFloored > AbsoluteSizeFloored then
                            SectionMain.Size = UDim2.new(1, -8, 1, -2)
                            UpArrow.Visible = not Section:CheckArrows("Up")
                            DownArrow.Visible = not Section:CheckArrows("Down")
                        elseif CanvasSizeFloored == AbsoluteSizeFloored then
                            SectionMain.Size = UDim2.new(1, -2, 1, -2)
                            UpArrow.Visible = false
                            DownArrow.Visible = false
                        end
                    end
                    -- separator
                    function Section:CheckArrows(Type)
                        if Type == "Up" then
                            return SectionScrolling.CanvasPosition == Vector2.new(0, 0)
                        elseif Type == "Down" then
                            return SectionScrolling.CanvasPosition == Vector2.new(0, SectionScrolling.AbsoluteCanvasSize.Y - SectionScrolling.AbsoluteSize.Y)
                        else
                            return false
                        end
                    end
                    -- separator
                    function Section:CalculateHeight(Section, Container)
                        local Padding = 10
                        local Height = 0
                        -- separator
                        for _, Child in Container:GetChildren() do
                            if Child:IsA("GuiObject") and Child.Visible then
                                Height = Height + Child.AbsoluteSize.Y + Padding
                            end
                        end
                        -- separator
                        Section.Size = UDim2.new(Section.Size.X.Scale, Section.Size.X.Offset, 0, math.clamp(Height + 31, 50, SectionOutline.Parent.AbsoluteSize.Y))
                    end
                    -- separator
                    function Section:CalculateButton(Position)
                        if Section.SizeButton then return end
                        -- separator
                        local ButtonOutline = Library:CreateObject("Frame", {
                            Name = "SectionOutline",
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Size = UDim2.new(0, 30, 0, 25),
                            BorderSizePixel = 0,
                            Position = Position,
                            ZIndex = 5,
                            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                            Parent = Library.UI.ScreenGUI
                        })
                        -- separator
                        local ButtonMain = Library:CreateObject("Frame", {
                            Size = UDim2.new(1, -2, 1, -2),
                            Name = "SectionMain_1",
                            Position = UDim2.new(0, 1, 0, 1),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            ZIndex = 5,
                            BorderSizePixel = 0,
                            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                            Parent = ButtonOutline
                        })
                        -- separator
                        local ButtonText = Library:CreateObject("TextLabel", {
                            AnchorPoint = Vector2.new(0, 0.5),
                            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                            BackgroundTransparency = 1,
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            Parent = ButtonOutline,
                            Position = UDim2.new(0, 0, 0.5, -1),
                            Size = UDim2.new(1, 0, 1, 0),
                            ZIndex = 5,
                            FontFace = Library.UI.NewFont,
                            RichText = true,
                            Text = "Calculate height",
                            TextColor3 = Color3.fromRGB(198, 198, 198),
                            TextSize = Library.UI.FontSize,
                            TextStrokeTransparency = 1,
                            TextXAlignment = "Left"
                        })
                        -- separator
                        local UIPadding_82 = Library:CreateObject("UIPadding", {
                            PaddingLeft = UDim.new(0, 8),
                            Parent = ButtonText
                        })
                        -- separator
                        local Button_945 = Library:CreateObject("TextButton", {
                            FontFace = Library.UI.NewFont,
                            TextColor3 = Color3.fromRGB(0, 0, 0),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            Name = "Button_9",
                            BackgroundTransparency = 1,
                            ZIndex = 5,
                            Size = UDim2.new(1, 0, 1, 0),
                            BorderSizePixel = 0,
                            TextTransparency = 1,
                            TextSize = Library.UI.FontSize,
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Parent = ButtonOutline
                        })
                        -- separator
                        Section.SizeButton = ButtonOutline
                        ButtonOutline.Size = UDim2.fromOffset(ButtonText.TextBounds.X + 16, 25)
                        ButtonOutline.BackgroundTransparency = 1
                        ButtonMain.BackgroundTransparency = 1
                        ButtonText.TextTransparency = 1
                        Button_945.TextTransparency = 1
                        -- separator
                        do -- Connections
                            Library:Connection(Button_945.MouseEnter, function()
                                Section.Hovering = true
                            end)
                            -- separator
                            Library:Connection(Button_945.MouseLeave, function()
                                Section.Hovering = false
                            end)
                            -- separator
                            Library:Connection(Button_945.MouseButton1Click, function()
                                Section:CalculateHeight(SectionOutline, SectionScrolling)
                                Library:Fade(false, Library:GetObjectsTable(ButtonOutline, true), ButtonOutline, 0.1)
                                -- separator
                                task.delay(Library.UI.TweenSpeed, function()
                                    for _, Value in ButtonOutline:GetDescendants() do
                                        Value:Destroy()
                                    end
                                    -- separator
                                    ButtonOutline:Destroy()
                                    Section.SizeButton = nil
                                end)
                            end)
                        end
                        -- separator
                        Library:Fade(true, Library:GetObjectsTable(ButtonOutline, true), ButtonOutline, 0.1)
                    end
                end
                -- separator
                do -- Connections
                    Library:Connection(SectionScrolling.ChildAdded, function()
                        Section:UpdateSection()
                    end)
                    -- separator
                    Library:Connection(SectionScrolling.ChildRemoved, function()
                        Section:UpdateSection()
                    end)
                    -- separator
                    Library:Connection(SectionOutline:GetPropertyChangedSignal("AbsoluteSize"), function()
                        Section:UpdateSection()
                    end)
                    -- separator
                    Library:Connection(RunService.PreRender, function() -- fastest option
                        if SectionOutline.AbsoluteSize.Y >= ((SectionOutline.Parent.AbsoluteSize.Y - Tab.Sides[Options.Side].Sizes) - 38) then
                            if Tab.SubSectionEnabled then
                                if #Tab.Sides[Options.Side].Sections <= 3 then
                                    SectionOutline.Size = UDim2.new(1, 0, 1, -Tab.Sides[Options.Side].Sizes)
                                end
                            else
                                SectionOutline.Size = UDim2.new(1, 0, 1, -Tab.Sides[Options.Side].Sizes)
                            end
                        end
                        -- separator
                        for _, Child in SectionOutline.Parent:GetChildren() do
                            if Child:IsA("Frame") and Child ~= SectionOutline then
                                if Library:CheckFrameFirst(SectionOutline, Child) then
                                    if Child.AbsoluteSize.Y >= ((Child.Parent.AbsoluteSize.Y - Tab.Sides[Options.Side].Sizes) - 38) then
                                        Child.Size = UDim2.new(Child.Size.X.Scale, Child.Size.X.Offset, 0, math.max(50, (SectionOutline.Parent.AbsoluteSize.Y - SectionOutline.AbsoluteSize.Y) - 57))
                                    end
                                    -- separator
                                    if Child.AbsoluteSize.Y == 50 and (SectionOutline.AbsoluteSize.Y == SectionOutline.Parent.AbsoluteSize.Y - 107) then
                                        SectionOutline.Size = UDim2.new(SectionOutline.Size.X.Scale, SectionOutline.Size.X.Offset, 0, SectionOutline.Parent.AbsoluteSize.Y - 107)
                                    end
                                end
                            end
                        end
                    end)
                    -- separator
                    Library:Connection(SectionScrolling:GetPropertyChangedSignal("AbsoluteCanvasSize"), function()
                        Section:UpdateSection()
                    end)
                    -- separator
                    Library:Connection(SectionScrolling:GetPropertyChangedSignal("CanvasPosition"), function()
                        UpArrow.Visible = not Section:CheckArrows("Up")
                        DownArrow.Visible = not Section:CheckArrows("Down")
                    end)
                    -- separator
                    Library:Connection(UpArrow.MouseButton1Click, function()
                        if not UpArrow.Visible then return end
                        -- separator
                        Library:TweenObject(SectionScrolling, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, 0)})
                    end)
                    -- separator
                    Library:Connection(DownArrow.MouseButton1Click, function()
                        if not DownArrow.Visible then return end
                        -- separator
                        Library:TweenObject(SectionScrolling, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, SectionScrolling.AbsoluteCanvasSize.Y - SectionScrolling.AbsoluteSize.Y)})
                    end)
                    -- separator
                    do -- Dragging
                        Library:Connection(Title.MouseButton1Down, function()
                            Title.TextColor3 = Library.Theme.Default.Accent
                            -- separator
                            Section.DragConnection = Library:Connection(UserInputService.InputChanged, function(Input)
                                if Input.UserInputType == Enum.UserInputType.MouseMovement then
                                    local SelectedOptions = {["SubSection"] = Options.ParentOptions, ["Other"] = {Left, Right}}
                                    local Selected = Tab.SubSectionEnabled and "SubSection" or "Other"
                                    local NewLeft, NewRight = SelectedOptions[Selected][1], SelectedOptions[Selected][2]
                                    local Parent2 = Library:SectionDragging(NewLeft) and NewLeft or Library:SectionDragging(NewRight) and NewRight
                                    local ParentName = Parent2 == NewLeft and "Left" or "Right"
                                    local TopHalf = Parent2 and Input.Position.Y < Parent2.AbsoluteSize.Y / 2
                                    -- separator
                                    if not Parent2 then return end
                                    -- separator
                                    SectionOutline.Parent = Parent2
                                    -- separator
                                    for _, SectionChild in Parent2:GetChildren() do
                                        if SectionChild:IsA("Frame") and SectionChild.Visible then
                                            if SectionChild == SectionOutline then
                                                if TopHalf then
                                                    SectionChild.LayoutOrder = (Tab.DropdownSectionEnabled and Parent2 == NewLeft and 2) or 1
                                                else
                                                    SectionChild.LayoutOrder = Section[ParentName].Order + 1
                                                end
                                            else
                                                if SectionChild.Name == "DropdownSection1" then
                                                    SectionChild.LayoutOrder = 1
                                                else
                                                    SectionChild.LayoutOrder = Section[ParentName].Order
                                                    Section[ParentName].Order = 3
                                                end
                                            end
                                        end
                                    end
                                end
                            end)
                        end)
                    end
                    -- separator
                    do -- Resizing
                        Library:Connection(ResizableButton_6.MouseButton2Click, function()
                            Section:CalculateButton(UDim2.fromOffset(ResizableButton_6.AbsolutePosition.X + ResizableButton_6.AbsoluteSize.X + 4, ResizableButton_6.AbsolutePosition.Y + ResizableButton_6.AbsoluteSize.Y + GuiService:GetGuiInset().Y))
                        end)
                        -- separator
                        Library:Connection(ResizableButton_6.MouseButton1Down, function()
                            ResizableButton_6.ImageColor3 = Library.Theme.Default.Accent
                            SectionInline.BackgroundColor3 = Library.Theme.Default.Accent
                            -- separator
                            SectionOutline.Size = UDim2.new(SectionOutline.Size.X.Scale, SectionOutline.Size.X.Offset, 0, SectionOutline.AbsoluteSize.Y)
                        end)
                        -- separator
                        Library:Connection(UserInputService.InputBegan, function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 and Section.SizeButton and not Section.Hovering then
                                Library:Fade(false, Library:GetObjectsTable(Section.SizeButton, true), Section.SizeButton, 0.1)
                                -- separator
                                task.delay(Library.UI.TweenSpeed, function()
                                    for _, Value in Section.SizeButton:GetDescendants() do
                                        Value:Destroy()
                                    end
                                    -- separator
                                    Section.SizeButton:Destroy()
                                    Section.SizeButton = nil
                                end)
                            end
                        end)
                        -- separator
                        Library:Resizable(SectionOutline, ResizableButton_6, UDim2.fromOffset(200, 50), UDim2.fromOffset(SectionOutline.Parent.AbsoluteSize.X - 29, SectionOutline.Parent.AbsoluteSize.Y - 38), Library.UI.SectionResizeIncrements, false, true, 0.01)
                    end
                    -- separator
                    Library:Connection(UserInputService.InputEnded, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if Section.DragConnection then Section.DragConnection:Disconnect() Section.DragConnection = nil end
                            Section.Left.Order = 1
                            Section.Right.Order = 1
                            Title.TextColor3 = Color3.fromRGB(198, 198, 198)
                            -- separator
                            ResizableButton_6.ImageColor3 = Color3.fromRGB(40, 40, 40)
                            SectionInline.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        end
                    end)
                end
                -- separator
                return setmetatable(Section, Library.Sections)
            end
            -- separator
            function Tab:SubSection(Options)
                Options = Library:Validate({
                    Name = "Preview Sub Section",
                    Options = {},
                    Flag = Library:NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local SubSection = {
                    CurrentSection = nil,
                    Sections = {},
                    List = {},
                    Elements = {},
                }
                -- separator
                SubSectionHolder.Visible = true
                Tab.SubSectionEnabled = true
                Tab.Sides.Right.Sizes = 0
                Tab.Sides.Left.Sizes = 0
                -- separator
                local SectionOutline = Library:CreateObject("Frame", {
                    Name = "SectionOutline",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    ZIndex = 1,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = SubSectionHolder
                })
                -- separator
                SectionOutline:SetAttribute("g", 0)
                -- separator
                local SectionInline = Library:CreateObject("Frame", {
                    Name = "SectionInline",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    Parent = SectionOutline
                })
                -- separator
                local SectionMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "SectionMain_1",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(23, 23, 23),
                    Parent = SectionInline
                })
                -- separator
                local UIPadding_81 = Library:CreateObject("UIPadding", {
                    PaddingRight = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 10),
                    Parent = SectionMain
                })
                -- separator
                local UIListLayout52 = Library:CreateObject("UIListLayout", {
                    Padding = UDim.new(0, -0),
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    Parent = SectionMain
                })
                -- separator
                local TitleInline = Library:CreateObject("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "TitleInline",
                    BorderSizePixel = 0,
                    Parent = SectionOutline,
                    Position = UDim2.new(0, 9, 0, 0),
                    Size = UDim2.new(0, 0, 0, 2),
                    ZIndex = 5
                })
                -- separator
                local UIGradient2 = Library:CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 19, 19)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 24, 24))
                    },
                    Parent = TitleInline
                })
                -- separator
                local Title = Library:CreateObject("TextLabel", {
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    Parent = SectionOutline,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -26, 0, 15),
                    ZIndex = 5,
                    FontFace = Library.UI.NewFont,
                    RichText = true,
                    Text = "<b>" .. Options.Name .. "</b>",
                    TextColor3 = Color3.fromRGB(198, 198, 198),
                    TextSize = Library.UI.FontSize,
                    TextStrokeTransparency = 1,
                    TextXAlignment = "Left"
                })
                -- separator
                for Index, Value in Options.Options do
                    local SectionItem = {
                        Active = false,
                        Hovering = false,
                        Position = "Bottom",
                        Elements = {},
                    }
                    -- separator
                    local SectionsHolder2 = Library:CreateObject("Frame", {
                        Name = "SectionsHolder",
                        BackgroundTransparency = 1,
                        Visible = false,
                        Position = UDim2.new(0, 97, 0, 33),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(1, -112, 1, -34),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        ClipsDescendants = true,
                        Parent = Outline_1
                    })
                    -- separator
                    local UIPadding_141 = Library:CreateObject("UIPadding", {
                        PaddingTop = UDim.new(0, 52),
                        Parent = SectionsHolder2
                    })
                    -- separator
                    local Left2 = Library:CreateObject("Frame", {
                        BackgroundTransparency = 1,
                        Name = "Left2",
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0.5, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = SectionsHolder2
                    })
                    -- separator
                    local UIPadding_11 = Library:CreateObject("UIPadding", {
                        PaddingTop = UDim.new(0, 19),
                        PaddingBottom = UDim.new(0, 19),
                        PaddingRight = UDim.new(0, 12),
                        Parent = Left2
                    })
                    -- separator
                    local UIListLayout12 = Library:CreateObject("UIListLayout", {
                        Padding = UDim.new(0, 19),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Parent = Left2
                    })
                    -- separator
                    local Right2 = Library:CreateObject("Frame", {
                        Name = "Right2",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 0, 0, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0.5, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = SectionsHolder2
                    })
                    -- separator
                    local UIPadding_21 = Library:CreateObject("UIPadding", {
                        PaddingTop = UDim.new(0, 19),
                        PaddingBottom = UDim.new(0, 19),
                        PaddingRight = UDim.new(0, 6),
                        PaddingLeft = UDim.new(0, 6),
                        Parent = Right2
                    })
                    -- separator
                    local UIListLayout521 = Library:CreateObject("UIListLayout", {
                        Padding = UDim.new(0, 19),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Parent = Right2
                    })
                    -- separator
                    local Icon = Library:CreateObject("ImageButton", {
                        ImageColor3 = Color3.fromRGB(100, 100, 100),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Icon",
                        Image = Value,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 75, 0, 57),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = SectionMain
                    })
                    -- separator
                    Left2.Position = UDim2.new(0, -(Left2.AbsoluteSize.X * 2), 0, 0)
                    Right2.Position = UDim2.new(0.5, -(Right2.AbsoluteSize.X * 2), 0, 0)
                    -- separator
                    do -- Functions
                        function SectionItem:MoveSides(State)
                            task.spawn(function()
                                if State then
                                    if SectionItem.Position == "Bottom" then
                                        Left2.Position = UDim2.new(0, (Left2.AbsoluteSize.X * 2), 0, 0)
                                        Right2.Position = UDim2.new(0.5, (Right2.AbsoluteSize.X * 2), 0, 0)
                                    else
                                        Left2.Position = UDim2.new(0, -(Left2.AbsoluteSize.X * 2), 0, 0)
                                        Right2.Position = UDim2.new(0.5, -(Right2.AbsoluteSize.X * 2), 0, 0)
                                    end
                                    -- separator
                                    SectionsHolder2.Visible = Outline:GetAttribute("g") == table.find(Window.Tabs, Tab)
                                    Library:TweenObject(Left2, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 1, 0, 0)})
                                    Library:TweenObject(Right2, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 1, 0, 0)})
                                else
                                    task.wait(0.001)
                                    -- separator
                                    local LeftPosition = SectionItem.Position == "Bottom" and (Left2.AbsoluteSize.X * 2) + 10 or -(Left2.AbsoluteSize.X * 2)
                                    local RightPosition = SectionItem.Position == "Bottom" and (Right2.AbsoluteSize.X * 2) + 10 or -(Right2.AbsoluteSize.X * 2)
                                    -- separator
                                    Library:TweenObject(Left2, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, LeftPosition, 0, 0)})
                                    Library:TweenObject(Right2, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, RightPosition, 0, 0)})
                                end
                            end)
                        end
                        -- separator
                        function SectionItem:Activate()
                            if not SectionItem.Active then
                                if SubSection.CurrentSection ~= nil then
                                    SubSection.CurrentSection:Deactivate()
                                end
                                -- separator
                                SectionItem.Active = true
                                -- separator
                                SectionItem:MoveSides(true)
                                Icon.ImageColor3 = Color3.fromRGB(188, 188, 188)
                                -- separator
                                SubSection.CurrentSection = SectionItem
                                SectionOutline:SetAttribute("g", Index)
                            end
                        end
                        -- separator
                        function SectionItem:Deactivate()
                            if SectionItem.Active then
                                SectionItem.Active = false
                                SectionItem.Hovering = false
                                -- separator
                                SectionItem:MoveSides(false)
                                Icon.ImageColor3 = Color3.fromRGB(93, 93, 93)
                            end
                        end
                        -- separator
                        function SectionItem:Section(Options)
                            Options = Library:Validate({
                                Name = "Preview Section",
                                Side = "Left",
                                Size = 40,
                            }, Options or {})
                            -- separator
                            local Section = Tab:Section({
                                Name = Options.Name,
                                Side = Options.Side,
                                Fill = Options.Fill,
                                Size = Options.Size,
                                Parent = Options.Side == "Left" and Left2 or Right2,
                                ParentOptions = {Left2, Right2},
                                Icon = Icon,
                            })
                            -- separator
                            return Section
                        end
                    end
                    -- separator
                    do -- Connections
                        Library:Connection(Outline:GetPropertyChangedSignal("AbsoluteSize"), function()
                            if not SectionItem.Active then
                                Left2.Position = UDim2.new(0, Left2.AbsoluteSize.X * 2, 0, 0)
                                Right2.Position = UDim2.new(0.5, Right2.AbsoluteSize.X * 2, 0, 0)
                            end
                        end)
                        -- separator
                        Library:Connection(Outline:GetAttributeChangedSignal("g"), function()
                            if Outline:GetAttribute("g") == table.find(Window.Tabs, Tab) then
                                SectionsHolder2.Visible = true
                            end
                        end)
                        -- separator
                        Library:Connection(SectionOutline:GetAttributeChangedSignal("g"), function()
                            if SectionOutline:GetAttribute("g") > Index then
                                SectionItem.Position = "Top"
                            elseif SectionOutline:GetAttribute("g") < Index then
                                SectionItem.Position = "Bottom"
                            end
                        end)
                        -- separator
                        Library:Connection(Left:GetPropertyChangedSignal("AbsolutePosition"), function()
                            if SectionItem.Active then
                                Left2.Position = Left.Position
                            end
                        end)
                        -- separator
                        Library:Connection(Right:GetPropertyChangedSignal("AbsolutePosition"), function()
                            if SectionItem.Active then
                                Right2.Position = Right.Position
                            end
                        end)
                        -- separator
                        Library:Connection(Icon.MouseButton1Click, function()
                            SectionItem:Activate()
                        end)
                        -- separator
                        Library:Connection(Icon.MouseEnter, function()
                            if not SectionItem.Active then
                                SectionItem.Hovering = true
                                Icon.ImageColor3 = Color3.fromRGB(124, 124, 124)
                            end
                        end)
                        -- separator
                        Library:Connection(Icon.MouseLeave, function()
                            if not SectionItem.Active then
                                SectionItem.Hovering = false
                                Icon.ImageColor3 = Color3.fromRGB(93, 93, 93)
                            end
                        end)
                    end
                    -- separator
                    if SubSection.CurrentSection == nil then
                        SectionItem:Activate()
                    end
                    -- separator
                    SubSection.Sections[#SubSection.Sections + 1] = setmetatable(SectionItem, Library.Sections)
                end
                -- separator
                SubSection.Elements = {
                    Name = Title,
                    ContentHolder = SectionMain,
                }
                -- separator
                TitleInline.Size = UDim2.new(0, Title.TextBounds.X + 6, 0, 2)
                -- separator
                return table.unpack(SubSection.Sections)
            end
            -- separator
            function Tab:ImageDropdown(Options)
                Options = Library:Validate({
                    Name = "Weapon Type",
                    Options = {},
                    Default = nil,
                    Flag = Library:NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local ImageDropdown = {
                    Open = false,
                    Active = false,
                    Hovering = false,
                    CurrentItem = nil,
                    Scrollable = false,
                    Hiding = false,
                    ContentLength = Library:GetTableLength(Options.Options),
                }
                -- separator
                Tab.DropdownSectionEnabled = true
                Tab.Sides.Left.Sizes = 70
                -- separator
                local DropdownImageOutline = Library:CreateObject("Frame", {
                    Name = "DropdownSection1",
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 51),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = Left
                })
                -- separator
                local DropdownChecker = Library:CreateObject("Frame", {
                    Name = "DropdownChecker",
                    Position = UDim2.new(0, 0, 1, 0),
                    Visible = false,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    Parent = DropdownImageOutline
                })
                -- separator
                local DropdownImageInline = Library:CreateObject("Frame", {
                    Name = "DropdownImageInline",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    Parent = DropdownImageOutline
                })
                -- separator
                local DropdownImageMain = Library:CreateObject("Frame", {
                    Size = UDim2.new(1, -2, 1, -2),
                    Name = "DropdownImageMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(23, 23, 23),
                    Parent = DropdownImageInline
                })
                -- separator
                local Button_92 = Library:CreateObject("TextButton", {
                    FontFace = Library.UI.NewFont,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Button_9",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = Library.UI.FontSize,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = DropdownImageMain
                })
                -- separator
                local DownArrow = Library:CreateObject("ImageLabel", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "DownArrow",
                    Size = UDim2.new(0, 5, 0, 4),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://15540867448",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -6, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    ImageColor3 = Color3.fromRGB(210, 210, 210),
                    Parent = DropdownImageMain
                })
                -- separator
                local Icon = Library:CreateObject("ImageLabel", {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "Icon",
                    Size = UDim2.new(0, 50, 1, -6),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://18657040454",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -14, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    ImageColor3 = Color3.fromRGB(210, 210, 210),
                    Parent = DropdownImageMain
                })
                -- separator
                local ToggleHolder = Library:CreateObject("Frame", {
                    Name = "ToggleHolder",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 100, 1, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = DropdownImageMain
                })
                -- separator
                local ActualToggleButton = Library:Toggle({
                    Default = false,
                    Name = "Global",
                    SectionName = "ToggleHolder",
                    Parent = ToggleHolder,
                    Risky = false,
                    MainUI = Outline,
                    ZIndex = 2,
                    TabUI = SideBarMain,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    UseToggleOutline = true,
                    Hidden = false,
                    Flag = Options.Flag .. "Extra",
                    Callback = function(State)
                        if ImageDropdown.CurrentItem then
                            ImageDropdown.CurrentItem:SetValue(State)
                            Library.Flags[Options.Flag] = ImageDropdown.CurrentItem
                            Options.Callback(ImageDropdown.CurrentItem.Name, ImageDropdown.CurrentItem.CurrentValue)
                        end
                    end,
                })
                -- separator
                local UIPadding = Library:CreateObject("UIPadding", {
                    PaddingLeft = UDim.new(0, 18),
                    Parent = ToggleHolder
                })
                -- separator
                local TitleInline = Library:CreateObject("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Name = "TitleInline",
                    BorderSizePixel = 0,
                    Parent = DropdownImageOutline,
                    Position = UDim2.new(0, 9, 0, 0),
                    Size = UDim2.new(0, 0, 0, 2),
                    ZIndex = 5
                })
                -- separator
                local UIGradient2 = Library:CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 19, 19)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 24, 24))
                    },
                    Parent = TitleInline
                })
                -- separator
                local Title = Library:CreateObject("TextButton", {
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    Parent = DropdownImageOutline,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -26, 0, 15),
                    ZIndex = 5,
                    FontFace = Library.UI.NewFont,
                    RichText = true,
                    Text = "<b>" .. Options.Name .. "</b>",
                    TextColor3 = Color3.fromRGB(198, 198, 198),
                    TextSize = Library.UI.FontSize,
                    TextStrokeTransparency = 1,
                    TextXAlignment = "Left"
                })
                -- separator
                local DropdownMainOutline = Library:CreateObject("Frame", {
                    Name = "DropdownMainOutline",
                    Position = UDim2.new(0, 0, 0, 0),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 50,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                    Parent = Library.UI.ScreenGUI
                })
                -- separator
                local DropdownMain = Library:CreateObject("Frame", {
                    Name = "DropdownMain",
                    Position = UDim2.new(0, 1, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    ZIndex = 50,
                    ClipsDescendants = true,
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Parent = DropdownMainOutline
                })
                -- separator
                DropdownMainOutline.BackgroundTransparency = 1
                DropdownMain.BackgroundTransparency = 1
                -- separator
                local UIListLayout_9 = Library:CreateObject("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = DropdownMain
                })
                -- separator
                Title.Size = UDim2.fromOffset(Title.TextBounds.X, 15)
                TitleInline.Size = UDim2.new(0, Title.TextBounds.X + 6, 0, 2)
                -- separator
                for Index, Value in Options.Options do
                    local DropdownOption = {
                        Hovering = false,
                        Active = false,
                        CurrentValue = false,
                        Name = Index,
                    }
                    -- separator
                    local ButtonMain = Library:CreateObject("Frame", {
                        Name = "DropdownMain",
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(1, 0, 0, 30),
                        BorderSizePixel = 0,
                        ZIndex = 50,
                        ClipsDescendants = true,
                        LayoutOrder = Value.Order,
                        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                        Parent = DropdownMain
                    })
                    -- separator
                    local Button_925 = Library:CreateObject("TextButton", {
                        FontFace = Library.UI.NewFont,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Button_9",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        ZIndex = 50,
                        TextTransparency = 1,
                        TextSize = Library.UI.FontSize,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = ButtonMain
                    })
                    -- separator
                    ButtonMain.BackgroundTransparency = 1
                    -- separator
                    local ToggleButton = Library:Toggle({
                        Default = false,
                        Name = Index,
                        SectionName = "ImageDropdown",
                        Parent = ButtonMain,
                        Risky = false,
                        MainUI = Outline,
                        ZIndex = 50,
                        TabUI = SideBarMain,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 15, 0.5, 0),
                        Hidden = false,
                        Callback = function(State)

                        end,
                    })
                    -- separator
                    local IconButton = Library:CreateObject("ImageLabel", {
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Icon",
                        Size = UDim2.new(0, 35, 1, 0),
                        AnchorPoint = Vector2.new(1, 0.5),
                        Image = Value.Icon,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -10, 0.5, 0),
                        ZIndex = 50,
                        BorderSizePixel = 0,
                        ImageColor3 = Color3.fromRGB(124, 124, 124),
                        Parent = ButtonMain
                    })
                    -- separator
                    do -- Functions
                        function DropdownOption:Activate()
                            if not DropdownOption.Active then
                                if ImageDropdown.CurrentItem ~= nil then
                                    ImageDropdown.CurrentItem:Deactivate()
                                end
                                -- separator
                                DropdownOption.Active = true
                                ImageDropdown.CurrentItem = DropdownOption
                                -- separator
                                IconButton.ImageColor3 = Color3.fromRGB(210, 210, 210)
                                Icon.Image = Value.Icon
                                ActualToggleButton:SetName(Index)
                            end
                        end
                        -- separator
                        function DropdownOption:Deactivate()
                            if DropdownOption.Active then
                                DropdownOption.Active = false
                                DropdownOption.Hovering = false
                                ImageDropdown.CurrentItem = nil
                                -- separator
                                ButtonMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                                IconButton.ImageColor3 = Color3.fromRGB(124, 124, 124)
                            end
                        end
                        -- separator
                        function DropdownOption:SetValue(Value)
                            ToggleButton:Set(Value)
                            DropdownOption.CurrentValue = Value
                        end
                        -- separator
                        function DropdownOption:Get()
                            return {Name = DropdownOption.Name, Value = DropdownOption.CurrentValue}
                        end
                    end
                    -- separator
                    do -- Connections
                        Library:Connection(ButtonMain.MouseEnter, function()
                            ButtonMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                            IconButton.ImageColor3 = Color3.fromRGB(210, 210, 210)
                        end)
                        -- separator
                        Library:Connection(ButtonMain.MouseLeave, function()
                            ButtonMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            -- separator
                            if DropdownOption.Active then return end
                            -- separator
                            IconButton.ImageColor3 = Color3.fromRGB(124, 124, 124)
                        end)
                        -- separator
                        Library:Connection(Button_925.MouseButton1Click, function()
                            DropdownOption:Activate()
                            ActualToggleButton:Set(DropdownOption.CurrentValue)
                        end)
                    end
                    -- separator
                    if Options.Default == Index then
                        DropdownOption:Activate()
                    end
                    -- separator
                    Library:Fade(false, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0.1)
                end
                -- separator
                do -- Functions
                    function ImageDropdown:Toggle(Fast)
                        local Fast = Fast or false
                        local OldValues = Library.Objects[DropdownMainOutline]
                        -- separator
                        if ImageDropdown.Open then
                            if Fast then
                                Library:Fade(false, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0)
                                DropdownMainOutline.Size = UDim2.new(0, DropdownImageOutline.AbsoluteSize.X, 0, 0)
                                Library.Objects[DropdownMainOutline] = {DropdownMainOutline, OldValues[2], true}
                            else
                                Library:Fade(false, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0.1)
                                Library:TweenObject(DropdownMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(0, DropdownImageOutline.AbsoluteSize.X, 0, 0)}, function()
                                    Library.Objects[DropdownMainOutline] = {DropdownMainOutline, OldValues[2], true}
                                end)
                            end
                        else
                            Library.Objects[DropdownMainOutline] = {DropdownMainOutline, OldValues[2], false}
                            -- separator
                            if Fast then
                                Library:Fade(true, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0)
                                DropdownMainOutline.Size = UDim2.new(0, DropdownImageOutline.AbsoluteSize.X, 0, (ImageDropdown.ContentLength * 30) + 2)
                            else
                                Library:Fade(true, Library:GetObjectsTable(DropdownMainOutline, true), DropdownMainOutline, 0.1)
                                Library:TweenObject(DropdownMainOutline, TweenInfo.new(Library.UI.TweenSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(0, DropdownImageOutline.AbsoluteSize.X, 0, (ImageDropdown.ContentLength * 30) + 2)})
                            end	
                        end
                        -- separator
                        ImageDropdown.Open = not ImageDropdown.Open
                    end
                    -- separator
                    function ImageDropdown:Update()
                        DropdownMainOutline.Size = UDim2.new(0, DropdownImageOutline.AbsoluteSize.X, 0, DropdownMainOutline.AbsoluteSize.Y)
                        DropdownMainOutline.Position = UDim2.new(0, DropdownImageOutline.AbsolutePosition.X, 0, ((DropdownImageOutline.AbsolutePosition.Y + DropdownImageOutline.AbsoluteSize.Y) + GuiService:GetGuiInset().Y + 2))
                    end
                end
                -- separator
                do -- Dropdown Connections
                    ImageDropdown:Update()
                    -- separator
                    Library:Connection(DropdownImageOutline:GetPropertyChangedSignal("AbsolutePosition"), ImageDropdown.Update)
                    Library:Connection(DropdownImageOutline:GetPropertyChangedSignal("AbsoluteSize"), ImageDropdown.Update)
                    -- separator
                    local StartingY = DropdownImageOutline.AbsolutePosition.Y
                    local MainUIStartingY = Outline.AbsolutePosition.Y
                    -- separator
                    Library:Connection(DropdownImageOutline:GetPropertyChangedSignal("AbsolutePosition"), function()
                        if not ImageDropdown.Open then return end
                        -- separator
                        local CurrentY = DropdownImageOutline.AbsolutePosition.Y
                        local MainUICurrentY = Outline.AbsolutePosition.Y
                        -- separator
                        if MainUICurrentY ~= MainUIStartingY then
                            MainUIStartingY = MainUICurrentY
                            StartingY = CurrentY
                            -- separator
                            return
                        end
                        -- separator
                        if Library.UI.Resizing then
                            return
                        end
                        -- separator
                        if CurrentY ~= StartingY then
                            ImageDropdown:Toggle(true)
                        end
                        -- separator
                        StartingY = CurrentY
                    end)
                end
                -- separator
                do -- Connections
                    Library:Connection(Button_92.MouseButton1Click, function()
                        ImageDropdown:Toggle()
                    end)
                end
            end
            -- separator
            function Sections:Dropdown(Options)
                Options = Library:Validate({
                    Default = "None",
                    Name = "Preview Dropdown",
                    Content = {},
                    Hiding = false,
                    Risky = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local Dropdown = Library:Dropdown({
                    Default = Options.Default,
                    Name = Options.Name,
                    Content = Options.Content,
                    MainUI = Outline,
                    TabUI = SideBarMain,
                    Hiding = Options.Hiding,
                    Risky = Options.Risky,
                    Flag = Options.Flag,
                    Callback = Options.Callback,
                    Parent = self.Elements.ContentHolder
                })
                -- separator
                return Dropdown
            end
            -- separator
            function Sections:MultiBox(Options)
                Options = Library:Validate({
                    Default = {},
                    Name = "Preview MultiBox",
                    Content = {},
                    Hiding = false,
                    Risky = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local Dropdown = Library:MultiBox({
                    Default = Options.Default,
                    Name = Options.Name,
                    Content = Options.Content,
                    MainUI = Outline,
                    TabUI = SideBarMain,
                    Hiding = Options.Hiding,
                    Risky = Options.Risky,
                    Flag = Options.Flag,
                    Callback = Options.Callback,
                    Parent = self.Elements.ContentHolder
                })
                -- separator
                return Dropdown
            end
            -- separator
            function Sections:Toggle(Options)
                Options = Library:Validate({
                    Default = false,
                    Name = "Preview Toggle",
                    Risky = false,
                    Hidden = false,
                    Flag = Library:NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local Toggle = Library:Toggle({
                    Default = Options.Default,
                    Name = Options.Name,
                    SectionName = self.Elements.Name,
                    Parent = self.Elements.ContentHolder,
                    Risky = Options.Risky,
                    MainUI = Outline,
                    TabUI = SideBarMain,
                    Hidden = Options.Hidden,
                    Flag = Options.Flag,
                    Callback = Options.Callback
                })
                -- separator
                return Toggle
            end
            -- separator
            function Sections:Slider(Options)
                Options = Library:Validate({
                    Name = "Preview Slider",
                    Min = 0,
                    Max = 100,
                    Default = 1,
                    Decimal = 1,
                    Ending = "",
                    Hidden = false,
                    UseIcons = true,
                    Disable = {},
                    Risky = false,
                    OverrideLimit = false, -- new parameter to allow values beyond max
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local Slider = Library:Slider({
                    Name = Options.Name,
                    Min = Options.Min,
                    Max = Options.Max,
                    Default = Options.Default,
                    Decimal = Options.Decimal,
                    Ending = Options.Ending,
                    Hidden = Options.Hidden,
                    Parent = self.Elements.ContentHolder,
                    Risky = Options.Risky,
                    Disable = Options.Disable,
                    OverrideLimit = Options.OverrideLimit, -- pass the parameter
                    Flag = Options.Flag,
                    UseIcons = Options.UseIcons,
                    Callback = Options.Callback
                })
                -- separator
                return Slider
            end
            -- separator
            function Sections:Label(Options)
                Options = Library:Validate({
                    Message = "Preview Label",
                    Risky = false,
                    Side = "Left",
                    Hidden = false,
                }, Options or {})
                -- separator
                local Label = Library:Label({
                    Message = Options.Message,
                    Side = Options.Side,
                    Risky = Options.Risky,
                    MainUI = Outline,
                    Hidden = Options.Hidden,
                    TabUI = SideBarMain,
                    SectionName = self.Elements.Name,
                    Callback = Options.Callback,
                    Parent = self.Elements.ContentHolder
                })
                -- separator
                return Label
            end
            -- separator
            function Sections:TextBox(Options)
                Options = Library:Validate({
                    Default = "",
                    Name = "Preview TextBox",
                    Max = 32,
                    NumbersOnly = false,
                    ClearOnFocus = false,
                    CheckIfPressedEnter = false,
                    Risky = false,
                    Hidden = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local TextBox = Library:TextBox({
                    Default = Options.Default,
                    Name = Options.Name,
                    Max = Options.Max,
                    NumbersOnly = Options.NumbersOnly,
                    ClearOnFocus = Options.ClearOnFocus,
                    CheckIfPressedEnter = Options.CheckIfPressedEnter,
                    Risky = Options.Risky,
                    Hidden = Options.Hidden,
                    Parent = self.Elements.ContentHolder,
                    Flag = Options.Flag,
                    Callback = Options.Callback
                })
                -- separator
                return TextBox
            end
            -- separator
            function Sections:List(Options)
                Options = Library:Validate({
                    Size = 100,
                    Hidden = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                -- separator
                local TextBox = Library:List({
                    Size = Options.Size,
                    Hidden = Options.Hidden,
                    Parent = self.Elements.ContentHolder,
                    Flag = Options.Flag,
                    Callback = Options.Callback
                })
                -- separator
                return TextBox
            end
            -- separator
            function Sections:Button(Options)
                Options = Library:Validate({
                    Name = "Preview Button",
                    Confirmation = false,
                    Risky = false,
                    Hidden = false,
                    Callback = function() end
                }, Options or {})
                -- separator
                local Button = Library:Button({
                    Name = Options.Name,
                    Confirmation = Options.Confirmation,
                    Risky = Options.Risky,
                    Hidden = Options.Hidden,
                    Parent = self.Elements.ContentHolder,
                    Callback = Options.Callback
                })
                -- separator
                return Button
            end
            -- separator
            return Tab
        end
        -- separator
        function Library:CreateWatermark()
            local Watermark = {
                CanUse = true,
                Tick = tick(),
                RefreshTick = tick(),
            }
            -- separator
            local MainWatermark = Library:CreateObject("Frame", {
                Name = "Watermark",
                Position = UDim2.new(0, 0, 0, 0),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(0, 400, 0, 20),
                BorderSizePixel = 0,
                ZIndex = 10000,
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                Parent = Library.UI.ScreenGUI
            }, true)
            -- separator
            local UIGradient = Library:CreateObject("UIGradient", {
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.25, 0.6119999885559082),
                    NumberSequenceKeypoint.new(0.5, 0.625),
                    NumberSequenceKeypoint.new(0.75, 0.625),
                    NumberSequenceKeypoint.new(1, 1)
                },
                Parent = MainWatermark
            }, true)
            -- separator
            local UIStroke = Library:CreateObject("UIStroke", {
                Parent = MainWatermark
            }, true)
            -- separator
            local UIGradient_1 = Library:CreateObject("UIGradient", {
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.232, 0.4000000059604645),
                    NumberSequenceKeypoint.new(0.5, 0.4000000059604645),
                    NumberSequenceKeypoint.new(0.75, 0.4000000059604645),
                    NumberSequenceKeypoint.new(1, 1)
                },
                Parent = UIStroke
            }, true)
            -- separator
            local WatermarkText = Library:CreateObject("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                TextColor3 = Color3.fromRGB(208, 208, 208),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Text = "gamesense",
                Name = "Text",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ZIndex = 10000,
                RichText = true,
                TextSize = 14,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = MainWatermark
            }, true)
            -- separator
            local Stroke = Library:CreateObject("UIStroke", {
                Parent = WatermarkText,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Color = Color3.fromRGB(50, 50, 50),
            }, true)
            -- separator
            local UIPadding = Library:CreateObject("UIPadding", {
                PaddingRight = UDim.new(0, 22),
                PaddingLeft = UDim.new(0, 22),
                Parent = WatermarkText
            }, true)
            -- separator
            do -- Functions
                function Library:ToggleWatermark(State)
                    Watermark.CanUse = State
                    MainWatermark.Visible = State
                end
                -- separator
                function Library:UpdateWatermark(Text)
                    if Watermark.CanUse and not MainWatermark.Visible then MainWatermark.Visible = true end
                    -- separator
                    WatermarkText.Text = tostring(Text)
                    MainWatermark.Size = UDim2.new(0, WatermarkText.TextBounds.X + 44, 0, MainWatermark.Size.Y.Offset)
                    MainWatermark.Position = UDim2.new(1, -(MainWatermark.Size.X.Offset) - 5, 0, 5)
                end
            end
            -- separator
            local R, G, B = Library.Theme.Default.Accent.R * 255, Library.Theme.Default.Accent.G * 255, Library.Theme.Default.Accent.B * 255
            -- separator
            Library:UpdateWatermark(("game<font color='rgb(%d, %d, %d)'>sense</font>  <font color='rgb(%d, %d, %d)'>%s</font> <font size='10'>FPS</font>  %s"):format(R, G, B, R, G, B, "60", os.date("%X")))
            -- separator
            Library:Notify({
                Message = ("You are using <font color='rgb(%d, %d, %d)'>gamesense</font>. Join <font color='rgb(%d, %d, %d)'>@</font> discord.gg/3E82u6ecyW"):format(R, G, B, R, G, B),
                Position = "Top Left",
                Delay = 15
            })
            -- separator
            do -- Connections
                Library:Connection(RunService.PostSimulation, function()
                    if Library.UI.Initialized and MainWatermark.Visible then
                        local R, G, B = Library.Theme.Default.Accent.R * 255, Library.Theme.Default.Accent.G * 255, Library.Theme.Default.Accent.B * 255
                        local FPS = math.floor(1 / math.abs(Watermark.Tick - tick()))
                        -- separator
                        Watermark.Tick = tick()
                        -- separator
                        if (tick() - Watermark.RefreshTick) > Library.UI.WatermarkRefreshRate then
                            Library:UpdateWatermark(("game<font color='rgb(%d, %d, %d)'>sense</font>  <font color='rgb(%d, %d, %d)'>%s</font> <font size='10'>FPS</font>  %s"):format(R, G, B, R, G, B, FPS, os.date("%X")))
                            -- separator
                            Watermark.RefreshTick = tick()
                        end
                    end
                end)
            end
        end
        -- separator
        function Library:Notify(Options)
            Options = Library:Validate({
                Message = "Notification",
                Delay = 3,
                Position = "Top Left",
            }, Options or {})
            -- separator
            local Notification = {}
            local Path = Options.Position == "Top Left" and Library.UI.Notifications.TopLeft or Library.UI.Notifications.Middle
            -- separator
            local NotificationFrameObject = Library:CreateObject("Frame", {
                Name = "Watermark",
                Position = UDim2.new(0, 0, 0, 0),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(0, 400, 0, 20),
                BorderSizePixel = 0,
                ZIndex = 10000,
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                Parent = Library.UI.ScreenGUI
            }, true)
            -- separator
            NotificationFrameObject.BackgroundTransparency = 1
            -- separator
            local UIGradient = Library:CreateObject("UIGradient", {
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.25, 0.6119999885559082),
                    NumberSequenceKeypoint.new(0.5, 0.625),
                    NumberSequenceKeypoint.new(0.75, 0.625),
                    NumberSequenceKeypoint.new(1, 1)
                },
                Parent = NotificationFrameObject
            }, true)
            -- separator
            local UIStroke = Library:CreateObject("UIStroke", {
                Parent = NotificationFrameObject
            }, true)
            -- separator
            UIStroke.Transparency = 1
            -- separator
            local UIGradient_1 = Library:CreateObject("UIGradient", {
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.232, 0.4000000059604645),
                    NumberSequenceKeypoint.new(0.5, 0.4000000059604645),
                    NumberSequenceKeypoint.new(0.75, 0.4000000059604645),
                    NumberSequenceKeypoint.new(1, 1)
                },
                Parent = UIStroke
            }, true)
            -- separator
            local NotificationText = Library:CreateObject("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                TextColor3 = Color3.fromRGB(208, 208, 208),
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Text = Options.Message,
                Name = "Text",
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 10000,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                RichText = true,
                TextSize = 14,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = NotificationFrameObject
            }, true)
            -- separator
            local Stroke = Library:CreateObject("UIStroke", {
                Parent = NotificationText,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Color = Color3.fromRGB(50, 50, 50),
            }, true)
            -- separator
            Stroke.Transparency = 1
            -- separator
            NotificationText.TextTransparency = 1
            -- separator
            local UIPadding = Library:CreateObject("UIPadding", {
                PaddingRight = UDim.new(0, 22),
                PaddingLeft = UDim.new(0, 22),
                Parent = NotificationText
            }, true)
            -- separator
            local NotificationFrame = {
                Class = "Notification",
                Object = NotificationFrameObject,
                Text = NotificationText,
            }
            -- separator
            NotificationFrameObject.Position = Options.Position == "Top Left" and UDim2.new(0, -70, 0, 80 + (#Path * 24)) or UDim2.new(0, Viewport.X / 2 - (NotificationText.TextBounds.X + 4) / 2, 1, -150)
            -- separator
            do -- Functions
                function Notification:UpdatePositions()
                    local TotalHeight = 80
                    local Padding = 6
                    -- separator
                    for Index = #Path, 1, -1 do
                        local Value = Path[Index]
                        local NewPosition
                        -- separator
                        if Options.Position == "Top Left" then
                            NewPosition = UDim2.new(0, 5, 0, TotalHeight)
                            TotalHeight = TotalHeight + Value.Object.AbsoluteSize.Y + Padding
                        else
                            NewPosition = UDim2.new(0, Viewport.X / 2 - (Value.Text.TextBounds.X + 4) / 2, 1, -150 - (Index * 24))
                        end
                        -- separator
                        Library:TweenObject(Value.Object, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = NewPosition})
                    end
                end
                -- separator
                function Notification:RemoveFrame()
                    Library:TweenObject(NotificationFrameObject, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
					Library:TweenObject(NotificationText, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = 1})
					Library:TweenObject(UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 1})
					Library:TweenObject(Stroke, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 1})
                    -- separator
                    task.delay(0.25, function()
                        NotificationFrameObject:Destroy()

                        table.remove(Path, table.find(Path, NotificationFrame))

                        Notification:UpdatePositions()
                    end)
                end
                -- separator
                function Notification:UpdateText(Text)
                    NotificationText.Text = Text
                    NotificationFrameObject.Size = UDim2.new(NotificationFrameObject.Size.X.Scale, NotificationText.TextBounds.X + 44, 0, NotificationText.TextBounds.Y + 4)
                end
                -- separator
                function Notification:Update()
                    local TotalHeight = 50
                    local Padding = 6
                    -- separator
					Library:TweenObject(NotificationFrameObject, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
					Library:TweenObject(NotificationText, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = 0})
					Library:TweenObject(UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 0})
					Library:TweenObject(Stroke, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 0})
                    NotificationFrameObject.Size = UDim2.new(NotificationFrameObject.Size.X.Scale, NotificationText.TextBounds.X + 44, 0, NotificationText.TextBounds.Y + 4)
                    -- separator
                    for _, Value in Path do
                        TotalHeight = TotalHeight + Value.Object.AbsoluteSize.Y + Padding
                    end
                    -- separator
                    local NewPosition = Options.Position == "Top Left" and UDim2.new(0, 5, 0, TotalHeight) or UDim2.new(0, Viewport.X / 2 - (NotificationText.TextBounds.X + 4) / 2, 1, -150)
                    -- separator
                    Library:TweenObject(NotificationFrameObject, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = NewPosition}, function()
                        if Options.Delay ~= math.huge then
                            task.delay(Options.Delay, Notification.RemoveFrame)
                        end
                    end)
                end
            end
            -- separator
            Notification:Update()
            -- separator
            table.insert(Path, 1, NotificationFrame)
            -- separator
            Notification:UpdatePositions()
            -- separator
            return Notification
        end
        -- separator
        function Library:Init()
            Library.UI.Initialized = true
            -- separator
            Library:CreateWatermark()
            -- separator
            Library:Connection(Camera:GetPropertyChangedSignal("ViewportSize"), function()
                Viewport = Camera.ViewportSize
                -- separator
                Outline.Position = UDim2.fromOffset((Viewport.X / 2) - (Outline.Size.X.Offset / 2), (Viewport.Y / 2) - (Outline.Size.Y.Offset / 2))
            end)
        end
        -- separator
        function Library:Unload()
            Camera.CameraSubject = Client.Character.Humanoid
            -- separator
            for Index, Value in Library.Connections do
                Value:Disconnect()
            end
            -- separator
            for _, Objects in Library.Objects do
                Objects[1]:Destroy()
            end
            -- separator
            MainUI:Destroy()
        end
        -- separator
        function Library:Disable()
            for Index, Value in Library.Flags do
                if Value.Set then
                    Value:Set(false)
                end
            end
        end
        -- separator
        return setmetatable(Window, Library)
    end
end
-- separator
local Window = Library:Window({CloseBind = Enum.KeyCode.Insert})
local Rage = Window:CreateTab({Icon = "rbxassetid://18248771514"})
local AntiAim = Window:CreateTab({Icon = "rbxassetid://15453313321"})
local Aimbot = Window:CreateTab({Icon = "rbxassetid://15453335745"})
local Visuals = Window:CreateTab({Icon = "rbxassetid://15453344494"})
local Settings = Window:CreateTab({Icon = "rbxassetid://15453349637"})
local Weapons = Window:CreateTab({Icon = "rbxassetid://15453354931"})
local PlayerList = Window:CreateTab({Icon = "rbxassetid://15453359751"})
local Configs = Window:CreateTab({Icon = "rbxassetid://15453364412"})
local Lua = Window:CreateTab({Icon = "rbxassetid://18240049800"})
local ActualPlayerList
-- separator
Window:SetTab(8)
AntiAim:Section({Fill = true})
AntiAim:Section({Fill = true, Side = "Right"})
-- separator
do -- Rage
    Rage:ImageDropdown({Name = "Weapon type", Flag = "RageWeaponType", Options = {["Global"] = {Icon = "rbxassetid://18657040454", Order = 1}, ["Double Barrel SG"] = {Icon = "rbxassetid://18205706952", Order = 2}, ["Revolver"] = {Icon = "rbxassetid://18205704829", Order = 3}, ["LMG"] = {Icon = "rbxassetid://18205822505", Order = 4}}, Default = "Global"})
    -- separator
	Rage:Section({Fill = true, Side = "Right"})
	local RageSection = Rage:Section({Fill = true})
	local Toggle1, Toggle2, Toggle3 = nil, nil, nil
	local Test = nil
	-- separator
	local g = RageSection:Toggle({Callback = function(State)
		if not Toggle1 then return end
		-- separator
		Toggle1:SetVisible(State)
		Toggle2:SetVisible(State)
		Toggle3:SetVisible(State)
	end})
	g:ColorPicker()
	g:ColorPicker()
	g:Keybind()
	-- separator
	Toggle1 = RageSection:Toggle({Hidden = true, Callback = function(State)
		if not Test then return end
		-- separator
		Test:SetVisible(State)
	end})
	Toggle1:Keybind({Default = Enum.KeyCode.Q, Mode = "On hotkey"})
	Test = RageSection:Slider({Name = "", Hidden = true, Default = 50})
	Toggle2 = RageSection:List({Hidden = true})
	Toggle3 = RageSection:Button({Confirmation = true, Hidden = true})
	-- separator
	RageSection:Dropdown({Content = {"Option 1", "Option 2"}})
	RageSection:Label()
	RageSection:MultiBox({Content = {"Option 1", "Option 2"}})
end
-- separator
do -- Visuals
	local VisualsSubSection, VisualsSubSection2, VisualsSubSection3, VisualsSubSection4 = Visuals:SubSection({Name = "Category", Options = {"rbxassetid://18334627891", "rbxassetid://18334630306", "rbxassetid://18334626899", "rbxassetid://18334625304"}})
	VisualsSubSection2:Section({Side = "Right", Fill = true})
	VisualsSubSection2:Section({Fill = true})
	VisualsSubSection4:Section({Side = "Right", Fill = true})
	VisualsSubSection4:Section({Fill = true})


	local PreviewVisualSection = VisualsSubSection:Section({Side = "Right", Size = 150})
	local PreviewExtraSection1 = VisualsSubSection:Section({Side = "Right", Fill = true})
	local PreviewExtraSection2 = VisualsSubSection:Section({Fill = true})
	local Slider1, Slider2 = nil, nil
	-- separator
	PreviewVisualSection:Dropdown({Content = {"test2", "Test3"}})
	PreviewVisualSection:MultiBox({Content = {"test2", "Test3"}})
	PreviewVisualSection:Toggle({Risky = true, Callback = function(State)
		if not (Slider1 and Slider2) then return end
		-- separator
		Slider1:SetVisible(State)
		Slider2:SetVisible(State)
	end})
	-- separator
	Slider1 = PreviewVisualSection:Slider({Hidden = true, UseIcons = false})
	Slider2 = PreviewVisualSection:Slider({Name = "FOV", Hidden = true, Min = 0, Max = 11, Default = 5, Decimal = 1, Ending = "°", Disable = {"Disabled", 0, 11}})
end
-- separator
do -- Settings
	local SettingsSection = Settings:Section({Name = "Settings", Side = "Right", Fill = true})
	-- separator
	do -- Settings
		SettingsSection:Label({Message = "Menu key"}):Keybind({Default = Enum.KeyCode.Insert, UseMode = false, Callback = function(Key) Library.UI.CloseBind = Key end})
		SettingsSection:Label({Message = "Menu color"}):ColorPicker({Default = Library.Theme.Default.Accent, Callback = function(Color)
			Library:UpdateColor("Accent", Color)
			Library:UpdateColor("SecondAccent", Color3.fromRGB(math.max(math.floor(Color.R * 255) - 12, 0), math.max(math.floor(Color.G * 255) - 12, 0), math.max(math.floor(Color.B * 255) - 12, 0)))
		end})
		SettingsSection:Slider({Name = "Menu animation speed", Min = 0, Max = 150, Default = 100, Ending = "%", Disable = {"Off", 0, 150}, Callback = function(Value)
			local MinSource, MaxSource = 1, 150
			local MinTarget, MaxTarget = 0.8, 0.1
			local NewValue = MinTarget + ((Value - MinSource) * (MaxTarget - MinTarget)) / (MaxSource - MinSource)
			-- separator
			Library.UI.TweenSpeed = Value == (0 or 150) and 0 or NewValue
		end})
		SettingsSection:Button({Name = "Unload", Callback = Library.Unload})
		SettingsSection:Button({Name = "Disable all", Callback = Library.Disable})
	end
end
-- separator
do -- Weapons
	local SkinsSection = Weapons:Section({Name = "Skins", Fill = true})
	local SkinList = SkinsSection:List({Size = 200})
	-- separator
	SkinList:AddValue("Test Skin 1", {Image = "http://www.roblox.com/asset/?id=12206409737", Color = Color3.fromRGB(232, 0, 0), Size = UDim2.fromOffset(5, 5), Position = UDim2.new(0, 11, 0.5, 0)})
	SkinList:AddValue("Test Skin 2", {Image = "http://www.roblox.com/asset/?id=12206409737", Color = Color3.fromRGB(2, 144, 232), Size = UDim2.fromOffset(5, 5), Position = UDim2.new(0, 11, 0.5, 0)})
	SkinList:AddValue("Test Skin 3", {Image = "http://www.roblox.com/asset/?id=12206409737", Color = Color3.fromRGB(198, 7, 232), Size = UDim2.fromOffset(5, 5), Position = UDim2.new(0, 11, 0.5, 0)})
	SkinList:AddValue("Test Skin 4", {Image = "http://www.roblox.com/asset/?id=12206409737", Color = Color3.fromRGB(36, 232, 1), Size = UDim2.fromOffset(5, 5), Position = UDim2.new(0, 11, 0.5, 0)})
end
-- separator
do -- Aimbot
	local AimbotSubSection, AimbotSubSection2 = Aimbot:SubSection({Name = "Category", Options = {"rbxassetid://18686402989", "rbxassetid://18657040454", "rbxassetid://18205704829", "rbxassetid://18205706952", "rbxassetid://18205822505"}})
end
-- separator
do -- PlayerList
	local PlayerSection = PlayerList:Section({Name = "Players", Fill = true})
	local PlayerAdjustments = PlayerList:Section({Name = "Adjustments", Fill = true, Side = "Right"})
	-- separator
	do -- Player Section
		ActualPlayerList = PlayerSection:List({Flag = "PlayerListCurrentPlayer", Size = 300})
		-- separator
		PlayerSection:Button({Name = "View player", Callback = function()
			local Player = Players:FindFirstChild(Library.Flags["PlayerListCurrentPlayer"]:Get())
			-- separator
			if Player then
				Library:ViewPlayer(Player)
			end
		end})
		-- separator
		for _, Player in Players:GetPlayers() do
			ActualPlayerList:AddValue(Player.Name, {Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)})
		end
	end
	-- separator
	do -- Adjustments
		PlayerAdjustments:Toggle({Name = "Whitelisted"})
	end
end
-- separator
do -- Configs
	local ConfigSection = Configs:Section({Name = "Configs", Fill = true})
	local LuaSection = Configs:Section({Name = "LUA", Side = "Right", Fill = true})
	-- separator
	do -- Configs
		local ConfigList = ConfigSection:List({Size = 200, Flag = "CurrentConfig"})
		-- separator
		Library:UpdateConfigList(ConfigList, "Add")
		-- separator
		ConfigSection:Button({Name = "Update config", Callback = function()
			if Library.Flags["CurrentConfig"]:Get() then
				writefile("LuckyHub/Configs/" .. Library.Flags["CurrentConfig"]:Get() .. ".cfg", Library:GetConfig())
			end
		end})
		ConfigSection:Button({Name = "Load config", Callback = function()
			if Library.Flags["CurrentConfig"]:Get() then
				Library:LoadConfig(readfile("LuckyHub/Configs/" .. Library.Flags["CurrentConfig"]:Get() .. ".cfg"))
			end
		end})
		ConfigSection:TextBox({Flag = "ConfigName"})
		ConfigSection:Button({Name = "Create config", Callback = function()
			local ConfigName = Library.Flags["ConfigName"]:Get()
			-- separator
			if Library.Flags["ConfigName"]:Get() ~= "" and not isfile("LuckyHub/Configs/" .. ConfigName .. ".cfg") then
			    writefile("LuckyHub/Configs/" .. ConfigName .. ".cfg", Library:GetConfig())
			    -- separator
			    ConfigList:AddValue(ConfigName)
			end
		end})
		ConfigSection:Button({Name = "Refresh list", Callback = function()
			Library:UpdateConfigList(ConfigList, "Remove")
			Library:UpdateConfigList(ConfigList, "Add")
		end})
	end
	-- separator
	do -- LUA
		local LuaList = LuaSection:List({Size = 75})
		-- separator
		LuaSection:Button({Name = "Load script"})
		LuaSection:Button({Name = "Unload script"})
		LuaSection:Button({Name = "Refresh list"})
	end
end
do -- Connections
	Library:Connection(Players.PlayerAdded, function(Player)
		if not ActualPlayerList then return end
		-- separator
		ActualPlayerList:AddValue(Player.Name, {Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)})
	end)
	-- separator
	Library:Connection(Players.PlayerRemoving, function(Player)
		if not ActualPlayerList then return end
		-- separator
		ActualPlayerList:AddValue(Player.Name, {Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)})
	end)
end
-- separator
Library:Init()
-- separator
local Position = "Top Left"
-- separator
for i = 1, 10 do
	local R, G, B = Library.Theme.Default.Accent.R * 255, Library.Theme.Default.Accent.G * 255, Library.Theme.Default.Accent.B * 255
	-- separator
	Library:Notify({Message = ("hit <font color='rgb(%d, %d, %d)'>awesomegamer5</font> in the <font color='rgb(%d, %d, %d)'>head</font> for <font color='rgb(%d, %d, %d)'>100</font> damage (0 health remaining)"):format(R, G, B, R, G, B, R, G, B), Position = Position, Delay = 3})
	-- separator
	Position = Position == "Top Left" and "Middle" or "Top Left"
	-- separator
	task.wait(0.5)
end
