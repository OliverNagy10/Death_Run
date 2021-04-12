-- SCENE TEMPLATE WAS GOT OF CORONA TURORIALS --
local composer = require( "composer" )
 
local scene= composer.newScene("mainmenu")
display.setStatusBar( display.HiddenStatusBar )

function scene:create( event )
 ---- All audio in all of the scenes was found on youtube then converted via mp3 converter 
 --https://www.youtube.com/watch?v=H6qMQjTLtj4
 --https://www.youtube.com/watch?v=IJCQU-8w0gI&t=117s
 ---------------------------------------------------------------
 local music = audio.loadStream("menu.mp3")
local backgroundMusicChannel = audio.play( music, { channel=1, loops=-1 } )
 --------------------------------------------------------------------------------------------------------------------------------------------------------
    local sceneGroup = self.view
    
 local background = display.newImageRect( sceneGroup,  "background1.PNG", 700, 320 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.type = "background"

 local easyButton = display.newImageRect( sceneGroup,  "easy.png" , 152, 37 )
easyButton.x = display.contentCenterX
easyButton.y = display.contentCenterY
 
local mediumButton = display.newImageRect( sceneGroup,  "medium.png" , 152 , 37)
mediumButton.x = display.contentCenterX
mediumButton.y = display.contentCenterY+50
 
local hardButton = display.newImageRect( sceneGroup,  "hard.png" , 152 , 37)
hardButton.x = display.contentCenterX
hardButton.y = display.contentCenterY+100
 
local Deathrun = display.newText( sceneGroup ,"DEATH RUN", display.contentCenterX, display.contentCenterY-110, "font.ttf", 40 )
	Deathrun:setFillColor( 0 , 0 , 0 ) 
	
	local Highscores = display.newText( sceneGroup, "High Scores", display.contentCenterX, display.contentCenterY-55,"font.ttf", 20 )
	Highscores:setFillColor( 0 , 0 , 0 ) 

local man1 = display.newImageRect(sceneGroup, "sideviewrunning1.png", 150, 211 )
man1.x = display.contentCenterX-180
man1.y = display.contentHeight-118

local man2 = display.newImageRect(sceneGroup, "sideviewrunning2.png", 150, 211 )
man2.x = display.contentCenterX+180
man2.y = display.contentHeight-118
	
function easyButton:tap (event)
 audio.stop( backgroundMusicChannel )
composer.gotoScene("easy" ,{ effect = "fade"  , time = 500 } )
end 
easyButton:addEventListener("tap" , easyButton)	

function Highscores:tap (event)
 audio.stop( backgroundMusicChannel )
composer.gotoScene("highscores" ,{ effect = "fade"  , time = 500 } )
end 
Highscores:addEventListener("tap" , Highscores)	

function mediumButton:tap (event)
 audio.stop( backgroundMusicChannel )
composer.gotoScene("medium" ,{ effect = "fade"  , time = 500 } )
end 
mediumButton:addEventListener("tap" , mediumButton)	

function hardButton:tap (event)
 audio.stop( backgroundMusicChannel )
composer.gotoScene("hard" ,{ effect = "fade"  , time = 500 } )
end 
hardButton:addEventListener("tap" , hardButton)	
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
      
 
    elseif ( phase == "did" ) then
     
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
   
    if ( phase == "will" ) then
       
 
    elseif ( phase == "did" ) then
    
 composer.removeScene( "mainmenu" )
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
   
 
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

 return scene