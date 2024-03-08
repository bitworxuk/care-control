local productLogo = {}

function productLogo:new(config)
    local parent = display.newGroup()
    parent.anchorChildren = true
    local scale = config.width / 520

    local image = display.newImageRect(parent, "assets/images/Care-Control-Logo-ALT.png", 520 * scale, 69 *
        scale)

    return parent
end

return productLogo
