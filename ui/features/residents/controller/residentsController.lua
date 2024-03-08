local residentsController = {}

local residentsService = require("data.features.residents.residentsService")
local dataUtils = require("data.shared.utils")

function residentsController:new()
    self.eventKey = "residentsController"

    local state = {
        cardData = {},
        clearData = false,
        isLoading = false,
        isError = false
    }

    local cardOffset = 0
    local cardsPerRequest = 32

    function self.loadData(refresh)
        if (state.isLoading) then
            return
        end

        state.isLoading = true

        if (refresh) then
            cardOffset = 0
            state.cardData = {}
            Runtime:dispatchEvent({ name = self.eventKey, state = state })
        end

        residentsService.getResidents({
            refresh = refresh,
            limit = cardsPerRequest,
            offset = cardOffset,
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
        cardOffset = cardOffset + cardsPerRequest
        self.loadData()
    end

    return self
end

return residentsController
