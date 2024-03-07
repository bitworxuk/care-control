local composer = require("composer")
local scene = composer.newScene()

local colorScheme = require("ui.shared.colorScheme")
local constants = require("ui.shared.constants")

local toolbarComponent = require("ui.features.residents.components.toolbar")
local dropdownMenuComponent = require("ui.shared.components.dropdownMenu")
local filterBarComponent = require("ui.features.residents.components.filterBar")

local residentsService = require("data.features.residents.residentsService")

function scene:create(event)
    local group = self.view

    local background = display.newRect(group, CENTERX, CENTERY, WIDTH, HEIGHT)
    background:setFillColor(unpack(colorScheme.background));

    local toolbar = toolbarComponent:new()
    toolbar.x = 0
    toolbar.y = STATUSBARHEIGHT
    group:insert(toolbar)

    local filterBar = filterBarComponent:new()
    filterBar.x = 0
    filterBar.y = STATUSBARHEIGHT + toolbar.height
    group:insert(filterBar)
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        residentsService.getResidents({
            refresh = true,
            limit = 10,
            offset = 0,
            onSuccess = function(data)
                for i = 1, #data do
                    print(data[i])
                end
            end,
            onFail = function() end
        })
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
