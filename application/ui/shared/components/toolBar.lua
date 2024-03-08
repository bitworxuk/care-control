local toolbar = {}

local utils = require("application.ui.shared.utils")
local colorScheme = require("application.ui.shared.colorScheme")

local requiredParams = {
    "width",
    "height",
    "leading",
    "trailing",
    "leftPad",
    "rightPad",
    "componentSpacing",
    "backgroundColor"
}

function toolbar:new(config)
    utils.verifyConfig(requiredParams, config, "TOOLBAR")

    local parent = display.newGroup()
    parent.anchorChildren = true
    parent.anchorX = 0
    parent.anchorY = 0

    local background = display.newRect(parent, 0, 0, config.width, config.height)
    background.anchorX = 0
    background.anchorY = 0
    background:setFillColor(unpack(config.backgroundColor))

    local divider = display.newRect(parent, 0, background.height, config.width, 1)
    divider.anchorX = 0
    divider.anchorY = 0
    divider:setFillColor(unpack(colorScheme.greyShade2))

    --Left and right side components
    local edgeMargin = 20
    local componentSpacing = config.componentSpacing
    local rollingX = 0

    --Leading components
    local leadingGroup = display.newGroup()
    leadingGroup.anchorChildren = true
    leadingGroup.anchorX = 0
    leadingGroup.x = edgeMargin + config.leftPad
    leadingGroup.y = config.height * 0.5
    parent:insert(leadingGroup)

    for i = 1, #config.leading do
        local component = config.leading[i]
        leadingGroup:insert(component)
        component.anchorX = 0
        component.x = rollingX
        rollingX = rollingX + component.width + componentSpacing
    end

    --Trailing components
    local trailingGroup = display.newGroup()
    trailingGroup.anchorChildren = true
    trailingGroup.anchorX = 1
    trailingGroup.x = config.width - edgeMargin - config.rightPad
    trailingGroup.y = config.height * 0.5
    parent:insert(trailingGroup)

    rollingX = 0
    for i = 1, #config.trailing do
        local component = config.trailing[i]
        trailingGroup:insert(component)
        component.anchorX = 0
        component.x = rollingX
        component.y = config.height * 0.5
        rollingX = rollingX + component.width + componentSpacing
    end

    return parent
end

return toolbar
