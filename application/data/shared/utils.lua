local utils = {}

function utils.tableCombine(tbl1, tbl2)
    local result = setmetatable(tbl1, {})
    for i = 1, #tbl2 do
        table.insert(result, tbl2[i])
    end
    return result
end

return utils
