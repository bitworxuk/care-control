local residentsController = {}

local residentsService = require("data.features.residents.residentsService"):new()
local dataUtils = require("data.shared.utils")
local residentsModel = require("data.features.residents.residentsModel")
local sortOrder = require("data.shared.sortOrder")

local defaultState = {
    cardData = {},
    clearData = false,
    isLoading = false,
    isError = false,
    currentSortOrder = sortOrder.desc,
    currentSortKey = residentsModel.outstanding,
    cardOffset = 0,
}

function residentsController:new()
    self.eventKey = "residentsController"

    local state = setmetatable(defaultState, {})
    local cardsPerRequest = 28

    function self.loadData(refresh)
        if (state.isLoading) then
            return
        end

        state.isLoading = true

        if (refresh) then
            state.cardOffset = 0
            state.cardData = {}
            Runtime:dispatchEvent({ name = self.eventKey, state = state })
        end

        residentsService.getResidents({
            refresh = refresh,
            limit = cardsPerRequest,
            offset = state.cardOffset,
            defaultSortKey = state.currentSortKey,
            defaultSortOrder = state.currentSortOrder,
            onSuccess = function(data)
                state.cardData = dataUtils.tableCombine(state.cardData, data)
                state.isLoading = false
                Runtime:dispatchEvent({ name = self.eventKey, state = state })
            end,
            onFail = function()
                state.isLoading = false
                state.isError = true
                Runtime:dispatchEvent({ name = self.eventKey, state = state })
            end
        })
    end

    function self.loadNext()
        if (state.isLoading) then
            return
        end
        state.cardOffset = state.cardOffset + cardsPerRequest
        self.loadData()
    end

    function self.sort(order)
        state.cardOffset = 0
        state.cardData = {}
        state.currentSortOrder = order
        Runtime:dispatchEvent({ name = self.eventKey, state = state })

        if (order == sortOrder.asc) then
            state.cardData = residentsService.sortAsc({
                key = residentsModel.outstanding,
                limit = cardsPerRequest,
                offset = state.cardOffset,
            })
        else
            state.cardData = residentsService.sortDesc({
                key = residentsModel.outstanding,
                limit = cardsPerRequest,
                offset = state.cardOffset
            })
        end
        Runtime:dispatchEvent({ name = self.eventKey, state = state })
    end

    function self.getState()
        return state
    end

    return self
end

return residentsController
