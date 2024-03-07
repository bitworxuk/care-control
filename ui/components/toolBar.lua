local toolbar = {}

local utils = require("ui.shared.utils")

local requiredParams = {
    "width",
    "height",
    "leading",
    "trailing",
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

    --Left and right side components
    local edgeMargin = 10
    local componentSpacing = 10
    local rollingX = 0

    --Leading components
    local leadingGroup = display.newGroup()
    leadingGroup.anchorChildren = true
    leadingGroup.anchorX = 0
    leadingGroup.x = edgeMargin
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
    trailingGroup.x = config.width - edgeMargin
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
