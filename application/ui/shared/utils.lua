local utils = {}

function utils.verifyConfig(requiredParams, config, componentName)
    for i = 1, #requiredParams do
        if (config[requiredParams[i]] == nil) then
            error(componentName .. " missing parameter -> " .. requiredParams[i])
        end
    end
    return true
end

return utils
