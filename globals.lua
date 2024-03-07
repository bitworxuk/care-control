--Development or production environment
ENVIRONMENT = system.getInfo( "environment" )
IN_SIM = ENVIRONMENT == "simulator"
PLATFORM = system.getInfo( "platformName" )

--UI Constants
WIDTH = display.contentWidth
HEIGHT = display.contentHeight
CENTERX = display.contentWidth*0.5
CENTERY = display.contentHeight*0.5
STATUSBARHEIGHT = display.topStatusBarContentHeight