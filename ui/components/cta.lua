local cta = {}

local colorScheme = require("ui.shared.colorScheme")
local utils = require("ui.shared.utils")
local constants = require("ui.shared.constants")

local requiredParams = {
    "width",
    "height",
    "label",
    "iconPath",
    "style",
    "onTap"
}

function cta:new(config)
    utils.verifyConfig(requiredParams, config, "CTA")

    local parent = display.newGroup()
    parent.anchorChildren = true

    local rect = display.newRoundedRect(parent, 0, 0, config.width, config.height, 5)
    if (config.style == constants.stylePrimary) then
        rect:setFillColor(unpack(colorScheme.buttonPrimary))
    elseif (config.style == constants.styleSecondary) then
        rect:setFillColor(unpack(colorScheme.buttonSecondary))
    else
        rect:setFillColor(unpack(colorScheme.buttonTertiary))
        rect.strokeWidth = 1
        rect.stroke = colorScheme.buttonSecondary
    end

    local overlay = display.newGroup()
    overlay.anchorChildren = true
    parent:insert(overlay)

    local icon = display.newRect(overlay, 0, 0, 5, 5)
    icon.anchorX = 0

    local label = display.newText({
        parent = overlay,
        x = icon.width + 6,
        fontSize = 6,
        text = config.label,
    })
    label.anchorX = 0

    if (config.style == constants.styleTertiary) then
        icon:setFillColor(unpack(colorScheme.buttonSecondary))
        label:setFillColor(unpack(colorScheme.buttonSecondary))
    end

    --Touch listener
    function parent:touch(e)
        if (e.phase == "ended") then
            config.onTap()
        end
    end

    parent:addEventListener("touch")

    return parent
end

return cta
