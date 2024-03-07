local composer = require("composer")
local scene = composer.newScene()

local colorScheme = require("ui.shared.colorScheme")
local constants = require("ui.shared.constants")

local productLogoComponent = require("ui.components.productLogo")
local toolbarComponent = require("ui.components.toolbar")
local circleButtonComponent = require("ui.components.circleButton")
local ctaComponent = require('ui.components.cta')

function scene:create(event)
    local group = self.view

    local background = display.newRect(group, CENTERX, CENTERY, WIDTH, HEIGHT)
    background:setFillColor(unpack(colorScheme.background));

    local toolbar = toolbarComponent:new({
        width = WIDTH,
        height = 35,
        backgroundColor = colorScheme.primary,
        leading = {
            circleButtonComponent:new({
                radius = 8,
                style = constants.stylePrimary,
                onTap = function()
                    native.showAlert("Back", "Back touched", { "ok" })
                end
            }),
            productLogoComponent:new({
                width = 70
            })
        },
        trailing = {
            ctaComponent:new({
                width = 50,
                height = 18,
                label = "Get help",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = function()
                    native.showAlert("Help", "Help", { "OK" })
                end
            }),
            ctaComponent:new({
                width = 50,
                height = 18,
                label = "Finish",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = function()
                    native.showAlert("Finish", "Finish", { "OK" })
                end
            }),
            ctaComponent:new({
                width = 50,
                height = 18,
                label = "Home",
                iconPath = "todo",
                style = constants.stylePrimary,
                onTap = function()
                    native.showAlert("Home", "Home", { "OK" })
                end
            })
        }
    })
    toolbar.x = 0
    toolbar.y = STATUSBARHEIGHT
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

    end
end

function scene:hide(event)
    local group = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

    end
end

function scene:destroy(event)
    local group = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
