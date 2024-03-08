local filterBar = {}

local colorScheme = require("application.ui.shared.colorScheme")
local toolbarComponent = require("application.ui.shared.components.toolBar")
local dropdownMenuComponent = require("application.ui.shared.components.dropdownMenu")
local ctaComponent = require("application.ui.shared.components.cta")
local sortButtonComponent = require("application.ui.shared.components.sortButton")
local constants = require("application.ui.shared.constants")
local utils = require("application.ui.shared.utils")
local screen = require("application.ui.shared.screen")

local requiredParams = {
    "onSortChanged",
    "onFilter1",
    "onFilter2",
    "onFilter3",
    "onClear",
    "onUpdate",
}

function filterBar:new(config)
    utils.verifyConfig(requiredParams, config, "RESIDENTS_FILTER_BAR")

    local parent = display.newGroup()

    local leadingComponents = {
        sort = sortButtonComponent:new({
            width = 200,
            height = 30,
            items = { "Outstanding Issues" },
            defaultSortOrder = config.sortOrder,
            onSortChanged = config.onSortChanged
        }),
        dropDownCsg = dropdownMenuComponent:new({
            width = 200,
            height = 30,
            label = "CSG",
            items = { "Show All", "item 1", "item 2", "item 3", "item 4" },
            onItemSelected = config.onFilter1
        }),
        dropDownAlphabetical = dropdownMenuComponent:new({
            width = 200,
            height = 30,
            label = "Alphabetical",
            items = { "Filter Flag", "item 1", "item 2", "item 3", "item 4" },
            onItemSelected = config.onFilter2
        }),
        dropDownTasks = dropdownMenuComponent:new({
            width = 200,
            height = 30,
            label = "Tasks",
            items = { "Show All", "item 1", "item 2", "item 3", "item 4" },
            onItemSelected = config.onFilter3
        })
    }

    local bar = toolbarComponent:new({
        width = screen.width,
        height = 50,
        leftPad = screen.leftInset,
        rightPad = screen.rightInset,
        backgroundColor = colorScheme.primary,
        componentSpacing = 10,
        leading = {
            leadingComponents.sort,
            leadingComponents.dropDownCsg,
            leadingComponents.dropDownAlphabetical,
            leadingComponents.dropDownTasks
        },
        trailing = {
            ctaComponent:new({
                width = 70,
                height = 30,
                label = "Clear",
                iconPath = "todo",
                style = constants.styleTertiary,
                onTap = config.onClear
            }),
            ctaComponent:new({
                width = 85,
                height = 30,
                label = "Update",
                iconPath = "todo",
                style = constants.styleSecondary,
                onTap = config.onUpdate
            }),
        }
    });
    parent:insert(bar)

    function parent.closeMenus()
        leadingComponents.dropDownCsg.close()
        leadingComponents.dropDownAlphabetical.close()
        leadingComponents.dropDownTasks.close()
    end

    return parent
end

return filterBar
