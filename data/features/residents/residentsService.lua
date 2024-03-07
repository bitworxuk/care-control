local residentsService = {}

local repo = require("data.features.residents.residentsRepository"):new()

local function filterData(data, limit, offset)
    local startRecord = offset + 1
    local endRecord = startRecord + limit
    if (startRecord > #data) then
        return {}
    end

    if (endRecord > #data) then
        endRecord = #data
    end

    local results = {}
    for i = startRecord, endRecord do
        results[#results + 1] = data[i]
    end
    return results
end

function residentsService.getResidents(params)
    local allData = {}
    repo.read({
        refresh = params.refresh,
        onSuccess = function(data)
            allData = data
            params.onSuccess(filterData(allData, params.limit, params.offset))
        end,
        onFail = params.onFail
    })
end

return residentsService
