local filterBar = {}

local colorScheme = require("ui.shared.colorScheme")
local toolbarComponent = require("ui.shared.components.toolbar")
local dropdownMenuComponent = require("ui.shared.components.dropdownMenu")
local ctaComponent = require('ui.shared.components.cta')
local constants = require("ui.shared.constants")
local utils = require("ui.shared.utils")

local requiredParams = {
    "onFilter1",
    "onFilter2",
    "onFilter3",
    "onClear",
    "onUpdate",
}


function filterBar:new(params)
    utils.verifyConfig(requiredParams, params, "RESIDENTS_FILTER_BAR")
    return toolbarComponent:new({
        width = WIDTH,
        height = 50,
        backgroundColor = colorScheme.primary,
        componentSpacing = 10,
        leading = {
            dropdownMenuComponent:new({
                width = 180,
                height = 30,
                label = "CSG",
                items = { "Show All", "item 1", "item 2", "item 3", "item 4" },
                onItemSelected = params.onFilter1
            }),
            dropdownMenuComponent:new({
                width = 180,
                height = 30,
                label = "Alphabetical",
                items = { "Filter Flag", "item 1", "item 2", "item 3", "item 4" },
                onItemSelected = params.onFilter2
            }),
            dropdownMenuComponent:new({
                width = 180,
                height = 30,
                label = "Tasks",
                items = { "Show All", "item 1", "item 2", "item 3", "item 4" },
                onItemSelected = params.onFilter3
            })
        },
        trailing = {
            ctaComponent:new({
                width = 70,
                height = 30,
                label = "Clear",
                iconPath = "todo",
                style = constants.styleTertiary,
                onTap = params.onClear
            }),
            ctaComponent:new({
                width = 85,
                height = 30,
                label = "Update",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = params.onUpdate
            }),
        }
    });
end

return filterBar
