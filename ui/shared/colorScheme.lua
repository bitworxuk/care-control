local function colorFromRgba(r, g, b, a)
    return { r / 255, g / 255, b / 255, a }
end

local colorScheme = {
    primary = colorFromRgba(255, 255, 255, 1),
    background = colorFromRgba(220, 220, 220, 1),
    buttonPrimary = colorFromRgba(13, 55, 88, 1),
    buttonSecondary = colorFromRgba(26, 185, 177, 1),
    buttonTertiary = colorFromRgba(255, 255, 255, 1),
    greyShade1 = colorFromRgba(220, 220, 220, 1),
    greyShade2 = colorFromRgba(200, 200, 200, 1),
    greyShade3 = colorFromRgba(150, 150, 150, 1),

}
return colorScheme
