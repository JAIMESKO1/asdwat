---@type table

local SettingsButton = {
    Rectangle = {
        Y = 0,
        Width = 430,
        Height = 35
    },
    Text = {
        X = 100,
        Y = 0,
        Scale = 0.4
    }
}

---@type table
local SettingsTitle = {
    Text = {
        X = 70,
        Y = 170,
        Scale = 0.25
    }
}



function RageUI.Separator(Label)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    -- Adjust text rendering for separator
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, 
                        20 + CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 
                        0, SettingsButton.Text.Scale - 0.05, 
                        245, 245, 245, 255, 1)
                end
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end

function RageUI.Title(Label)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if (Label ~= nil) then
                local x = CurrentMenu.X + SettingsTitle.Text.X
                local y = CurrentMenu.Y + SettingsTitle.Text.Y + CurrentMenu.SubtitleHeight
                -- Adjust text rendering for title
                RenderText(Label, x, y, 0, SettingsTitle.Text.Scale, 255, 255, 255, 255, 1)
            end
        end
    end
end
