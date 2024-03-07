local filterBar = {}

local colorScheme = require("ui.shared.colorScheme")
local toolbarComponent = require("ui.shared.components.toolbar")
local dropdownMenuComponent = require("ui.shared.components.dropdownMenu")
local ctaComponent = require('ui.shared.components.cta')
local constants = require("ui.shared.constants")


function filterBar:new()
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
                onItemSelected = function() end
            }),
            dropdownMenuComponent:new({
                width = 180,
                height = 30,
                label = "Alphabetical",
                items = { "Filter Flag", "item 1", "item 2", "item 3", "item 4" },
                onItemSelected = function() end
            }),
            dropdownMenuComponent:new({
                width = 180,
                height = 30,
                label = "Tasks",
                items = { "Show All", "item 1", "item 2", "item 3", "item 4" },
                onItemSelected = function() end
            })
        },
        trailing = {
            ctaComponent:new({
                width = 70,
                height = 30,
                label = "Clear",
                iconPath = "todo",
                style = constants.styleTertiary,
                onTap = function()
                    native.showAlert("Update", "Update", { "OK" })
                end
            }),
            ctaComponent:new({
                width = 85,
                height = 30,
                label = "Update",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = function()
                    native.showAlert("Update", "Update", { "OK" })
                end
            }),
        }
    });
end

return filterBar
