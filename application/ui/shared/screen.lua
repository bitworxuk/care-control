local topInset, leftInset, bottomInset, rightInset = display.getSafeAreaInsets()

return {
    topInset = topInset,
    leftInset = leftInset,
    bottomInset = bottomInset,
    rightInset = rightInset,
    width = display.contentWidth,
    height = display.contentHeight,
    centerX = display.contentWidth * 0.5,
    centerY = display.contentHeight * 0.5,
    statusBarHeight = display.topStatusBarContentHeight
}
