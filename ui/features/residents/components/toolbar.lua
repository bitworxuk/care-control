local toolbar = {}

local colorScheme = require("ui.shared.colorScheme")
local constants = require("ui.shared.constants")
local productLogoComponent = require("ui.shared.components.productLogo")
local toolbarComponent = require("ui.shared.components.toolbar")
local circleButtonComponent = require("ui.shared.components.circleButton")
local ctaComponent = require('ui.shared.components.cta')
local utils = require("ui.shared.utils")

local requiredParams = {
    "onHelp",
    "onFinish",
    "onHome",
}

function toolbar:new(params)
    utils.verifyConfig(requiredParams, params, "RESIDENTS_TOOLBAR")

    local buttonWidth = 100
    local buttonHeight = 30

    return toolbarComponent:new({
        width = WIDTH,
        height = 70,
        backgroundColor = colorScheme.primary,
        componentSpacing = 20,
        leading = {
            circleButtonComponent:new({
                radius = 15,
                style = constants.stylePrimary,
                onTap = function()
                    native.showAlert("Back", "Back touched", { "ok" })
                end
            }),
            productLogoComponent:new({
                width = 160
            })
        },
        trailing = {
            ctaComponent:new({
                width = buttonWidth,
                height = buttonHeight,
                label = "Get help",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = function()
                    native.showAlert("Help", "Help", { "OK" })
                end
            }),
            ctaComponent:new({
                width = buttonWidth,
                height = buttonHeight,
                label = "Finish",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = function()
                    native.showAlert("Finish", "Finish", { "OK" })
                end
            }),
            ctaComponent:new({
                width = buttonWidth,
                height = buttonHeight,
                label = "Home",
                iconPath = "todo",
                style = constants.stylePrimary,
                onTap = function()
                    native.showAlert("Home", "Home", { "OK" })
                end
            })
        }
    })
end

return toolbar
