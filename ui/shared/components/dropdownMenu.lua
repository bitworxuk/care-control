local dropdownMenu = {}

local colorScheme = require("ui.shared.colorScheme")

local requiredParams = {
    "width",
    "height",
    "label",
    "items",
    "onItemSelected"
}

function dropdownMenu:new(config)
    local parent = display.newGroup()
    parent.anchorChildren = true

    local labelPad = 5
    local cornerRounding = 5

    local buttonGroup = display.newGroup()
    parent:insert(buttonGroup)

    local background = display.newRoundedRect(buttonGroup, 0, 0, config.width, config.height, cornerRounding)
    background.anchorX = 0
    background.strokeWidth = 1
    background.stroke = colorScheme.greyShade2
    background:setFillColor(unpack(colorScheme.greyShade1))

    local label = display.newText({
        x = labelPad,
        parent = buttonGroup,
        text = config.label,
        fontSize = 10,
        fontWeight = native.systemFontBold
    })
    label.anchorX = 0
    label:setFillColor(unpack(colorScheme.greyShade3))

    local labelOffset = label.x + label.width + labelPad

    local dropdownSectionBackground = display.newRect(buttonGroup, labelOffset, 0, config.width - labelOffset - 5,
        config.height - 2)
    dropdownSectionBackground.anchorX = 0

    local selectedLabel = display.newText({
        x = dropdownSectionBackground.x + labelPad,
        parent = buttonGroup,
        text = config.items[1],
        fontSize = 10,
        fontWeight = native.systemFontBold
    })
    selectedLabel.anchorX = 0
    selectedLabel:setFillColor(unpack(colorScheme.greyShade3))

    local trailingGroup = display.newGroup()
    trailingGroup.anchorChildren = true
    trailingGroup.anchorX = 0
    trailingGroup.x = config.width - 40
    trailingGroup.y = 0
    buttonGroup:insert(trailingGroup)

    local dropdownEndBackground = display.newRoundedRect(trailingGroup,
        0, 0, 40, config.height - 2, cornerRounding)

    local dropDownIcon = display.newRect(trailingGroup, 0, 0, 20, 20)
    dropDownIcon:setFillColor(unpack(colorScheme.greyShade2))

    local menuGroup = display.newGroup()
    parent:insert(menuGroup)
    menuGroup.isVisible = false

    local menuItems = {}
    local function sortMenuItems(visible)
        for i = 1, #menuItems do
            local menuItem = menuItems[i]
            if (visible) then
                menuItem.x = config.width * .5
                menuItem.y = (config.height * .5) + (config.height * (i - 1))
            else
                menuItem.x = config.width * .5
                menuItem.y = -config.height * .5
            end
        end
    end

    for i = 1, #config.items do
        local menuItem = display.newGroup()
        menuItem.anchorChildren = true
        menuItem.anchorY = 0
        menuItem.y = -config.height * .5
        menuItem.x = config.width * .5
        menuGroup:insert(menuItem)
        menuItems[#menuItems + 1] = menuItem

        local menuItemBackground = display.newRect(menuItem, 0, 0, config.width * .95, config.height)
        local menuItemDivider = display.newRect(menuItem, 0, config.height * .5, config.width * .95, 1)
        menuItemDivider:setFillColor(unpack(colorScheme.greyShade2))

        local menuItemLabel = display.newText({
            parent = menuItem,
            text = config.items[i],
            fontSize = 10,
            fontWeight = native.systemFontBold
        })
        menuItemLabel:setFillColor(unpack(colorScheme.greyShade3))

        function menuItem:touch(e)
            if (e.phase == "ended") then
                local visible = not menuGroup.isVisible
                sortMenuItems(visible)
                menuGroup.isVisible = visible
                selectedLabel.text = menuItemLabel.text
                config.onItemSelected(menuItemLabel.text)
            end
        end

        menuItem:addEventListener("touch")
    end

    function trailingGroup:touch(e)
        if (e.phase == "ended") then
            local visible = not menuGroup.isVisible
            sortMenuItems(visible)
            menuGroup.isVisible = visible
        end
    end

    trailingGroup:addEventListener("touch")

    return parent
end

return dropdownMenu
