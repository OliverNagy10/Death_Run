-- SCENE TEMPLATE WAS GOT OF CORONA TURORIALS --

local composer = require( "composer" )
 display.setStatusBar( display.HiddenStatusBar )
local scene= composer.newScene()
 
 local json = require( "json" )
 
local scoresTable = {}
 
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )
 ----------------- Load score and Save score function was put together by researching online forums --------------
local function loadScores()
 
    local file = io.open( filePath, "r" )
 
    if file then
        local contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end
 
    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    end
end
 
 local function saveScores()
 
    for i = #scoresTable, 11, -1 do
        table.remove( scoresTable, i )
    end
 
    local file = io.open( filePath, "w" )
 
    if file then
        file:write( json.encode( scoresTable ) )
        io.close( file )
    end
end

function scene:create( event )
 local music = audio.loadStream("highscore.mp3")
local backgroundMusicChannel = audio.play( music, { channel=1, loops=-1 } )
    local sceneGroup = self.view
    
 loadScores()
 
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )
local function compare( a, b )
        return a > b
    end
    table.sort( scoresTable, compare )
saveScores()
local background = display.newImageRect( sceneGroup, "background1.PNG", 700, 320 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
     
    local highScoresHeader = display.newText( sceneGroup, "High Scores", display.contentCenterX, 30, "font.ttf", 40 )
	highScoresHeader:setFillColor( 0 , 0 , 0 ) 
for i = 1, 10 do
        if ( scoresTable[i] ) then
            local yPos = 50 + ( i * 25 )
 
 local rankNum = display.newText( sceneGroup, i .. ")", display.contentCenterX-50, yPos,"font.ttf" , 18 )
            rankNum:setFillColor( 0,0,0 )
            rankNum.anchorX = 1
 
            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX-30, yPos,"font.ttf" , 18 )
            thisScore.anchorX = 0
             thisScore:setFillColor( 0 , 0 , 0 ) 
        end
    end
	
	
	local menuButton = display.newText( sceneGroup, "Back", display.contentCenterX-230, 30, "font.ttf" , 20 )
    menuButton:setFillColor( 0,0,0 )
	local function gotoMenu()
     audio.stop( backgroundMusicChannel )
	composer.gotoScene( "mainmenu", { time=800, effect="crossFade" } )
end
    menuButton:addEventListener( "tap", gotoMenu )
	
local rock = display.newImageRect(sceneGroup, "rock1.png", 50, 50 )
rock.x = display.contentCenterX-180
rock.y = display.contentHeight-118	
	
local rock2 = display.newImageRect(sceneGroup, "rock2.png", 50, 40 )
rock2.x = display.contentCenterX-220
rock2.y = display.contentHeight-200	

local spear = display.newImageRect(sceneGroup, "spike2.png", 180, 80 )
spear.x = display.contentCenterX-180
spear.y = display.contentHeight-60	

local rock3 = display.newImageRect(sceneGroup, "rock3.png", 80, 70 )
rock3.x = display.contentCenterX-130
rock3.y = display.contentHeight-230	

local man2 = display.newImageRect(sceneGroup, "sideviewrunning1.png", 150, 211 )
man2.x = display.contentCenterX+180
man2.y = display.contentHeight-118

end




 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
   
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
  composer.removeScene( "highscores" )
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene