local residentsService = {}

local repo = require("application.data.features.residents.residentsRepository"):new()
local sortOrder = require("application.data.shared.sortOrder")
local residentsModel = require("application.data.features.residents.residentsModel")

local function filterData(data, limit, offset)
    local startRecord = offset + 1
    local endRecord = startRecord - 1 + limit
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

function residentsService:new()
    local allData = {}

    function self.getResidents(params)
        repo.read({
            refresh = params.refresh,
            onSuccess = function(data)
                allData = data
                local sortParams = {
                    key = params.defaultSortKey,
                    limit = params.limit,
                    offset = params.offset
                }
                if (params.defaultSortOrder == sortOrder.asc) then
                    return params.onSuccess(self.sortAsc(sortParams))
                end
                return params.onSuccess(self.sortDesc(sortParams))
            end,
            onFail = params.onFail
        })
    end

    function self.sortAsc(params)
        table.sort(allData, function(a, b)
            return a[params.key] .. "-" .. a[residentsModel.id] <
                b[params.key] .. "-" .. b[residentsModel.id]
        end)
        return filterData(allData, params.limit, params.offset)
    end

    function self.sortDesc(params)
        table.sort(allData, function(a, b)
            return a[params.key] .. "-" .. a[residentsModel.id] >
                b[params.key] .. "-" .. b[residentsModel.id]
        end)
        return filterData(allData, params.limit, params.offset)
    end

    return self
end

return residentsService
