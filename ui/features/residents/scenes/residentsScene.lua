local composer = require("composer")
local scene = composer.newScene()

local colorScheme = require("ui.shared.colorScheme")
local constants = require("ui.shared.constants")

local widget = require("widget")
local toolbarComponent = require("ui.features.residents.components.toolbar")
local filterBarComponent = require("ui.features.residents.components.filterBar")
local residentCardComponent = require("ui.features.residents.components.residentCard")

local residentsService = require("data.features.residents.residentsService")

local onDataLoaded
local cardOffset = 0
local cardsPerRequest = 32

function scene:create(event)
    local group = self.view

    local background = display.newRect(group, CENTERX, CENTERY, WIDTH, HEIGHT)
    background:setFillColor(unpack(colorScheme.background));

    local toolbar = toolbarComponent:new()
    toolbar.x = 0
    toolbar.y = 0
    group:insert(toolbar)

    local filterBar = filterBarComponent:new()
    filterBar.x = 0
    filterBar.y = toolbar.height
    group:insert(filterBar)

    local scrollView = widget.newScrollView({
        width = WIDTH,
        height = HEIGHT - (filterBar.y + filterBar.height),
        top = filterBar.y + filterBar.height,
        left = 0,
        hideBackground = true,
        horizontalScrollDisabled = true,
        bottomPadding = 20,
    })
    group:insert(scrollView)

    scrollView:toBack()
    background:toBack()

    function onDataLoaded(data)
        local tilesPerRow = 4
        local colCount = 0
        local colSpace = 15
        local rowCount = 0
        local rowSpace = 15
        local startX = colSpace * .5
        local startY = rowSpace * .5
        local tileWidth = (WIDTH / 4) - colSpace - (colSpace / 4)
        local tileHeight = 90

        for i = 1, #data do
            local alertStatus = residentCardComponent.alertStatus.none
            local alertCount = 0
            if (data[i].outstanding ~= nil and data[i].outstanding > 0) then
                alertStatus = residentCardComponent.alertStatus.warning
                alertCount = data[i].outstanding
            elseif (data[i].due ~= nil and data[i].due > 0) then
                alertStatus = residentCardComponent.alertStatus.danger
                alertCount = data[i].due
            end

            local card = residentCardComponent:new({
                width = tileWidth,
                height = tileHeight,
                title = data[i].name,
                subtitle = data[i].room,
                imagePath = "todo",
                alertStatus = alertStatus,
                alertCount = alertCount,
            })

            card.anchorX = 0
            card.anchorY = 0
            card.x = startX
            card.y = startY
            scrollView:insert(card)

            colCount = colCount + 1
            startX = startX + tileWidth + colSpace

            if (colCount >= tilesPerRow) then
                colCount = 0
                rowCount = rowCount + 1
                startX = colSpace * .5
                startY = startY + tileHeight + rowSpace
            end
        end
    end
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        residentsService.getResidents({
            refresh = true,
            limit = cardsPerRequest,
            offset = cardOffset,
            onSuccess = function(data)
                onDataLoaded(data)
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
