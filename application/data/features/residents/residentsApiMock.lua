local residentsApiMock = {}

local json = require("json")

function residentsApiMock.get(params)
    timer.performWithDelay(500, function()
        local path = system.pathForFile("assets/json/SampleJson.json", system.ResourceDirectory)
        local file, errorString = io.open(path, "r")
        if not file then
            params.onFail(errorString)
        else
            local contents = file:read("*a")
            params.onSuccess(json.decode(contents));
        end
    end)
end

return residentsApiMock
