local sortButton = {}

local colorScheme = require("ui.shared.colorScheme")
local utils = require("ui.shared.utils")
local sortOrder = require("data.shared.sortOrder")

local requiredParams = {
    "width",
    "height",
    "items",
    "onSortChanged"
}

function sortButton:new(config)
    utils.verifyConfig(requiredParams, config, "SORT_BUTTON")

    local parent = display.newGroup()
    parent.anchorChildren = true

    local labelPad = 5
    local cornerRounding = 5

    local buttonGroup = display.newGroup()
    parent:insert(buttonGroup)

    local background = display.newRoundedRect(buttonGroup, 0, 0, config.width, config.height, cornerRounding)
    background.anchorX = 0
    background:setFillColor(unpack(colorScheme.blueShade1))

    local sortIcon = display.newRect(buttonGroup, 5, 0, 20, 20)
    sortIcon.anchorX = 0

    local order = config.defaultSortOrder

    local selectedLabel = display.newText({
        x = sortIcon.x + sortIcon.width + labelPad,
        parent = buttonGroup,
        text = config.items[1] .. " " .. order,
        fontSize = 10,
        fontWeight = native.systemFontBold
    })
    selectedLabel.anchorX = 0
    selectedLabel:setFillColor(unpack(colorScheme.primary))

    function buttonGroup:touch(e)
        if (e.phase == "ended") then
            if (order == sortOrder.desc) then
                order = sortOrder.asc
            else
                order = sortOrder.desc
            end
            selectedLabel.text = config.items[1] .. " " .. order
            config.onSortChanged(order)
        end
        return true
    end

    buttonGroup:addEventListener("touch")

    return parent
end

return sortButton
