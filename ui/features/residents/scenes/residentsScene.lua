local composer = require("composer")
local scene = composer.newScene()

local colorScheme = require("ui.shared.colorScheme")
local constants = require("ui.shared.constants")

local widget = require("widget")
local toolbarComponent = require("ui.features.residents.components.toolbar")
local filterBarComponent = require("ui.features.residents.components.filterBar")
local residentCardComponent = require("ui.features.residents.components.residentCard")

local controller = require("ui.features.residents.controller.residentsController"):new()

local viewState = {}

function scene:create(event)
    local group = self.view

    local cards = {}

    local background = display.newRect(group, CENTERX, CENTERY, WIDTH, HEIGHT)
    background:setFillColor(unpack(colorScheme.background));

    local toolbar = toolbarComponent:new({
        onHelp = function()
            print("help pressed")
        end,
        onFinish = function()
            print("finish pressed")
        end,
        onHome = function()
            print("home pressed")
        end
    })
    toolbar.x = 0
    toolbar.y = 0
    group:insert(toolbar)

    local filterBar = filterBarComponent:new({
        onFilter1 = function(value)
            print("Filter changed " .. value)
        end,
        onFilter2 = function(value)
            print("Filter changed " .. value)
        end,
        onFilter3 = function(value)
            print("Filter changed " .. value)
        end,
        onClear = function()
            print("Clear pressed")
        end,
        onUpdate = function()
            controller.loadData(true)
        end,
    })
    filterBar.x = 0
    filterBar.y = toolbar.height
    group:insert(filterBar)

    local function scrollListener(event)
        if (event.limitReached) then
            if (event.direction == "up") then
                controller.loadNext()
            end
        end
        return true
    end

    local scrollView
    local function addScrollView()
        if (scrollView) then
            scrollView:removeSelf()
            scrollView = nil
        end

        scrollView = widget.newScrollView({
            width = WIDTH,
            height = HEIGHT - (filterBar.y + filterBar.height),
            top = filterBar.y + filterBar.height,
            left = 0,
            hideBackground = true,
            horizontalScrollDisabled = true,
            bottomPadding = 50,
            listener = scrollListener
        })
        group:insert(scrollView)

        scrollView:toBack()
        background:toBack()
    end

    local function addCards(rebuild)
        local tilesPerRow = 4
        local colCount = 0
        local colSpace = 15
        local rowCount = 0
        local rowSpace = 15
        local startX = colSpace * .5
        local startY = rowSpace * .5
        local tileWidth = (WIDTH / 4) - colSpace - (colSpace / 4)
        local tileHeight = 90

        if (#viewState.cardData == 0) then
            addScrollView()
            cards = {}
        end

        for i = 1, #viewState.cardData do
            local cardData = viewState.cardData[i]

            if (cards[i] == nil) then
                local alertStatus = residentCardComponent.alertStatus.none
                local alertCount = 0

                if (cardData.outstanding ~= nil and cardData.outstanding > 0) then
                    alertStatus = residentCardComponent.alertStatus.warning
                    alertCount = cardData.outstanding
                elseif (cardData.due ~= nil and cardData.due > 0) then
                    alertStatus = residentCardComponent.alertStatus.danger
                    alertCount = cardData.due
                end

                local card = residentCardComponent:new({
                    width = tileWidth,
                    height = tileHeight,
                    title = cardData.name,
                    subtitle = cardData.room,
                    imagePath = "todo",
                    alertStatus = alertStatus,
                    alertCount = alertCount,
                })

                card.anchorX = 0
                card.anchorY = 0
                card.x = startX
                card.y = startY
                card.id = cardData.id
                cards[#cards + 1] = card
                scrollView:insert(card)
            end

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

    local function onStateChange(e)
        viewState = e.state
        addCards()
    end

    Runtime:addEventListener(controller.eventKey, onStateChange)
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        controller.loadData(true)
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
    Runtime:removeEventListener(controller.eventKey)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
