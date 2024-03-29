local toolbar = {}

local screen = require("application.ui.shared.screen")
local colorScheme = require("application.ui.shared.colorScheme")
local constants = require("application.ui.shared.constants")
local productLogoComponent = require("application.ui.shared.components.productLogo")
local toolbarComponent = require("application.ui.shared.components.toolBar")
local circleButtonComponent = require("application.ui.shared.components.circleButton")
local ctaComponent = require("application.ui.shared.components.cta")
local utils = require("application.ui.shared.utils")

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
        width = screen.width,
        height = 70,
        leftPad = screen.leftInset,
        rightPad = screen.rightInset,
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
