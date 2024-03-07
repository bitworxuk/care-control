local residentsRepository = {}

local residentsApi = require("data.features.residents.residentsApiMock")

function residentsRepository:new()
    local cachedData = {}

    function self.create(params)
        error("Create not implemented")
    end

    function self.read(params)
        if (params.refresh) then
            residentsApi.get({
                onSuccess = function(data)
                    cachedData = data
                    params.onSuccess(cachedData)
                end,
                onFail = params.onFail
            })
        else
            params.onSuccess(cachedData)
        end
    end

    function self.update(params)
        error("Update not implemented")
    end

    function self.delete(params)
        error("Delete not implemented")
    end

    return self
end

return residentsRepository
