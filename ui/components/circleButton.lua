local circleButton = {}

local colorScheme = require("ui.shared.colorScheme")
local utils = require("ui.shared.utils")
local constants = require("ui.shared.constants")

local requiredParams = {
    "radius",
    "style",
    "onTap"
}

function circleButton:new(config)
    utils.verifyConfig(requiredParams, config, "CIRCLE_BUTTON"
    )
    local parent = display.newGroup()
    parent.anchorChildren = true

    local buttonBody = display.newCircle(parent, 0, 0, config.radius)
    if (config.style == constants.stylePrimary) then
        buttonBody:setFillColor(unpack(colorScheme.buttonPrimary))
    else
        buttonBody:setFillColor(unpack(colorScheme.buttonSecondary))
    end

    --TODO - Add icon
    local icon = display.newRect(parent, 0, 0, 5, 5)

    function parent:touch(e)
        if (e.phase == "ended") then
            config.onTap()
        end
    end

    parent:addEventListener("touch")

    return parent
end

return circleButton
