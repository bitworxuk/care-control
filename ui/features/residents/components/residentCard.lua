local residentCard = {
    alertStatus = {
        none = "none",
        warning = "warning",
        danger = "danger"
    }
}

local utils = require("ui.shared.utils")
local colorScheme = require("ui.shared.colorScheme")

local requiredParams = {
    "width",
    "height",
    "title",
    "subtitle",
    "imagePath",
    "alertStatus",
    "alertCount"
}

function residentCard:new(config)
    utils.verifyConfig(requiredParams, config)

    local cornerRounding = 5
    local shadowSpread = 15

    local parent = display.newGroup()
    parent.anchorChildren = true

    local shadow = display.newRoundedRect(parent, 0, 0, config.width, config.height,
        cornerRounding)
    shadow.stroke = {
        type = "gradient",
        color2 = { 1, 1, 1, 0 },
        color1 = { 0, 0, 0, 0.1 },
    }
    shadow.strokeWidth = shadowSpread


    local background = display.newRoundedRect(parent, 0, 0, config.width, config.height,
        cornerRounding)

    local contentGroup = display.newGroup()
    contentGroup.anchorChildren = true
    contentGroup.anchorX = 0
    contentGroup.x = 10 - background.width * .5
    parent:insert(contentGroup)

    local image = display.newCircle(contentGroup, 0, 0, config.height * .3)
    image:setFillColor(unpack(colorScheme.greyShade1))
    image.anchorX = 0
    image.strokeWidth = 2
    image.stroke = colorScheme.buttonSecondary

    local titleText = config.title
    local stringLimit = 16
    if (#titleText > stringLimit) then
        titleText = titleText:sub(1, stringLimit) .. "..."
    end

    local title = display.newText(
        {
            parent = contentGroup,
            x = image.width + 10,
            y = -8,
            text = titleText,
            font = native.systemFontBold,
            fontSize = 12,
        })
    title.anchorX = 0
    title:setFillColor(unpack(colorScheme.textPrimary))

    local subtitle = display.newText(
        {
            parent = contentGroup,
            x = image.width + 10,
            y = 8,
            text = config.subtitle,
            fontSize = 10
        })
    subtitle.anchorX = 0
    subtitle:setFillColor(unpack(colorScheme.textPrimary))

    --Todo - make component
    local warning = display.newGroup()
    warning.anchorChildren = true
    warning.anchorX = 1
    warning.anchorY = 0
    warning.x = config.width * .5 - 5
    warning.y = -config.height * .5 + 5
    parent:insert(warning)

    warning.isVisible = config.alertStatus ~= self.alertStatus.none

    local warningBackground = display.newRoundedRect(warning, 0, 0, 40, 20, 5)

    local icon = display.newCircle(warning, 0, 0, 8)
    icon.x = -8

    local counter = display.newText({
        parent = warning,
        x = 8,
        y = 0,
        text = config.alertCount,
        fontSize = 10
    })

    if (warning.isVisible) then
        local color = colorScheme.warningColor
        if (config.alertStatus == self.alertStatus.danger) then
            color = colorScheme.dangerColor
        end
        local bgColor = setmetatable(color, {})
        warningBackground:setFillColor(bgColor[1], bgColor[2], bgColor[3], .3)
        icon:setFillColor(unpack(color))
        counter:setFillColor(unpack(color))
        image.stroke = color
    end

    return parent
end

return residentCard
