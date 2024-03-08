local composer = require("composer")
local scene = composer.newScene()

local screen = require("ui.shared.screen")
local colorScheme = require("ui.shared.colorScheme")
local widget = require("widget")
local toolbarComponent = require("ui.features.residents.components.toolbar")
local filterBarComponent = require("ui.features.residents.components.filterBar")
local residentCardComponent = require("ui.features.residents.components.residentCard")
local residentsModel = require("data.features.residents.residentsModel")
local controller = require("ui.features.residents.controller.residentsController"):new()

function scene:create(event)
    local group = self.view

    local viewState = controller.getState()
    local cards = {}
    local filterBar
    local loadText
    local scrollView

    local background = display.newRect(group, screen.centerX, screen.centerY, screen.width, screen.height)
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


    local function drawFilterBar()
        if (filterBar ~= nil) then
            filterBar:removeSelf()
        end
        filterBar = filterBarComponent:new({
            sortOrder = viewState.currentSortOrder,
            onSortChanged = function(sortOrder)
                controller.sort(sortOrder)
            end,
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
                drawFilterBar()
            end,
            onUpdate = function()
                filterBar.closeMenus()
                controller.loadData(true)
            end,
        })
        filterBar.x = 0
        filterBar.y = toolbar.height
        group:insert(filterBar)
    end

    drawFilterBar()

    local function scrollListener(event)
        if (event.limitReached) then
            if (event.direction == "up") then
                controller.loadNext()
            end
        end
        return true
    end

    local function drawScrollview()
        if (scrollView) then
            scrollView:removeSelf()
            scrollView = nil
        end

        scrollView = widget.newScrollView({
            width = screen.width,
            height = screen.height - (filterBar.y + filterBar.height),
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

    local function drawCards(rebuild)
        local tilesPerRow = 4
        local colCount = 0
        local colSpace = 15
        local rowCount = 0
        local rowSpace = 15
        local startX = screen.leftInset + colSpace * .5
        local startY = rowSpace * .5
        local screenPad = screen.leftInset + screen.rightInset
        local tileWidth = ((screen.width - screenPad) / 4) - colSpace - (colSpace / 4)
        local tileHeight = 90

        if (#viewState.cardData == 0) then
            drawScrollview()
            cards = {}
            loadText = display.newText({
                x = screen.centerX,
                y = screen.centerY - 100,
                text = "loading..."
            })
            loadText:setFillColor(unpack(colorScheme.buttonPrimary))
            scrollView:insert(loadText)
        elseif (loadText ~= nil) then
            loadText:removeSelf()
            loadText = nil
        end

        for i = 1, #viewState.cardData do
            local cardData = viewState.cardData[i]

            if (cards[i] == nil) then
                local alertStatus = residentCardComponent.alertStatus.none
                local alertCount = 0

                if (cardData[residentsModel.outstanding] > 0) then
                    alertStatus = residentCardComponent.alertStatus.warning
                    alertCount = cardData[residentsModel.outstanding]
                elseif (cardData[residentsModel.due] > 0) then
                    alertStatus = residentCardComponent.alertStatus.danger
                    alertCount = cardData[residentsModel.due]
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
                startX = screen.leftInset + colSpace * .5
                startY = startY + tileHeight + rowSpace
            end
        end
    end

    local function onStateChange(e)
        viewState = e.state
        drawCards()
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
