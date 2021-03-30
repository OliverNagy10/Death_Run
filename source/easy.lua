
local composer = require("composer")
local scene= composer.newScene("easy")

display.setStatusBar( display.HiddenStatusBar )

function scene:create( event )
 ----audio sounds ---------------------------------------------------------------------------
 local music = audio.loadStream("game.mp3")
local backgroundMusicChannel = audio.play( music, { channel=1, loops=-1 } )
 local jumpsound = audio.loadSound("jump.mp3")
----------------------------------------------------------------------------------------- 
 local sceneGroup = self.view
 local delayTime = -1
--All objects excluding spawing ones ------------------------------------------------
local wall = display.newImageRect(sceneGroup, "wall.png", 2000, 98 )
wall.x = display.contentCenterX
wall.y = display.contentCenterY-215
wall.type = "wall"

local wall2 = display.newImageRect(sceneGroup, "wall2.png", 98, 1000 )
wall2.x = display.contentCenterX+345
wall2.y = display.contentCenterY
wall2.type = "wall2"

local wall3 = display.newImageRect(sceneGroup, "wall2.png", 98, 1000 )
wall3.x = display.contentCenterX-235
wall3.y = display.contentCenterY
wall3.type = "wall3"

local background = display.newImageRect( sceneGroup,"background1.PNG", 600, 320 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.type = "background"

local background1 = display.newImageRect(sceneGroup, "background1.PNG", 600, 320 )
background1.x = display.contentCenterX
background1.y = display.contentCenterY
background1.type = "background1"

local background2 = display.newImageRect(sceneGroup, "background1.PNG", 600, 320 )
background2.x = display.contentCenterX+480
background2.y = display.contentCenterY
background2.type = "background2"

local background3 = display.newImageRect(sceneGroup, "background1.PNG", 600, 320 )
background3.x = display.contentCenterX+960
background3.y = display.contentCenterY
background3.type = "background3"

local ground = display.newImageRect(sceneGroup, "ground.png", 587, 237 )
ground.x = display.contentCenterX+3
ground.y = display.contentHeight+50

local ground1 = display.newImageRect(sceneGroup, "ground.png", 587, 237 )
ground1.x = display.contentCenterX+483
ground1.y = display.contentHeight+50

local ground2 = display.newImageRect(sceneGroup, "ground.png", 587, 237 )
ground2.x = display.contentCenterX+963
ground2.y = display.contentHeight+50

local man = display.newImageRect(sceneGroup, "sideview.png", 40, 130 )
man.x = display.contentCenterX
man.y = display.contentHeight-170
man.type = "man"


local pit = display.newImageRect(sceneGroup, "pit.png" ,587, 100 )
pit.x = display.contentCenterX+1443
pit.y = display.contentHeight-17
local groundShape = {-190 , -50 , -55, 50 , -190 , 50 }
local lavaShape  = {  -120 , 15 , -120 , 50, 120, 50 , 120 , 15  }
local groundShape2 = { 190 , -50 , 90, 50 , 190 , 50 }
pit.type = "pit"


local deathforce = display.newImageRect(sceneGroup, "deathforce.png", 200,380 )
deathforce.x = display.contentCenterX-280
deathforce.y = display.contentCenterY-10
deathforce.type = "deathforce"

local heart = display.newImageRect(sceneGroup, "heart.png", 40,40 )
heart.x = display.contentCenterX+260
heart.y = display.contentCenterY-130
heart.type = "heart"
 
 local heart2 = display.newImageRect(sceneGroup, "heart.png", 40,40 )
heart2.x = display.contentCenterX+230
heart2.y = display.contentCenterY-130
heart2.type = "heart2"
 
 local heart3 = display.newImageRect(sceneGroup, "heart.png", 40,40 )
heart3.x = display.contentCenterX+200
heart3.y = display.contentCenterY-130
heart3.type = "heart3"

--LEVEL OF DIFFICULTY VARIABLES-----------------------------------------------------------------

local lives = 3
--Game physics
local physics = require( "physics" )
physics.start(true)
--Speed of game
local amount = 0.1
local runSpeed = 1
local function runSpeedIncrease (event)
runSpeed = runSpeed + amount 
end 
local runSpeedIncrease  = timer.performWithDelay( 5000, runSpeedIncrease, 0 )
--speed of objects
local rockvelocity = -65
local velocityamount = 2
local velocity= -170
local function velocitySpeeder (event) 
    velocity= velocity- velocityamount
	rockvelocity = rockvelocity - velocityamount
    end 
local velocitySpeeder  = timer.performWithDelay( 5000, velocitySpeeder, 0  )
------------------------------------------------------------------------------------------------
--Physics Bodys excluding the spawning bodies ----------------------------------------------------------------------------------------
physics.addBody( wall3 , "static" )
physics.addBody( ground , "static" )
physics.addBody( ground1 , "static" )
physics.addBody( wall , "static" )
physics.addBody( wall2 , "static" )
physics.addBody( ground2 , "static" )
physics.addBody( man , "dynamic" , {   density = 0.03 , bounce= 0.0 , friction = 0.5  } )
man.linearDamping = 2
physics.addBody( deathforce , "static"    )
physics.addBody( pit , "static" , 
{shape = lavaShape}, 
{shape = groundShape},
{shape = groundShape2} 
)


local pistonJoint = physics.newJoint( "piston", man, wall3, anchor_x, anchor_y, axisX, axisY )
-------------------------------------------------------------------------------------------------

--high score-------------------------------------------------------------
local score = 0
local highScoreFont =  display.newText( score, display.contentCenterX, 20, "font.ttf", 40 )
highScoreFont:setFillColor( 0 , 0 , 0 )
local function add (event)
score = score + 1
highScoreFont.text = score
end 
timer.performWithDelay( 200, add, 0)
--Makes ground move ----------------------------------------------------
local function move(event) 
ground.x = ground.x - runSpeed
ground1.x = ground1.x - runSpeed
ground2.x = ground2.x - runSpeed
pit.x = pit.x - runSpeed
background1.x = background1.x - runSpeed
background2.x = background2.x - runSpeed
background3.x = background3.x - runSpeed
if ( background1.x ) < -480 then 
background1.x = display.contentCenterX +600
end 
if ( background2.x ) < -480 then 
background2.x = display.contentCenterX +600
end 
if ( background3.x ) < -480 then 
background3.x = display.contentCenterX +600 
end 
if ( ground.x) < -477 then 
ground.x = display.contentCenterX+1190
end 
if ( ground1.x) < -477 then 
ground1.x = display.contentCenterX+1190
end 
if ( ground2.x) < -477 then 
ground2.x = display.contentCenterX+1190
end 
if ( pit.x) < -477 then 
pit.x = display.contentCenterX+1190
end

end 
Runtime:addEventListener("enterFrame", move)

--Jump Button-----------------------------------------------------------
local button = display.newImageRect(sceneGroup,"jump.png" , 70,60)
button.x = display.contentCenterX+220
button.y = display.contentHeight-35
button.alpha = 0.7
function button:tap (event)
man:applyLinearImpulse( 0, -0.7 , man.x , man.y)

end 
button:addEventListener("tap" , button)
-- move Right---------------------------------------------------------
local moveRight = display.newImageRect(sceneGroup,"jump1.png" , 70,55)
moveRight.x = display.contentCenterX-140
moveRight.y = display.contentHeight-35
moveRight.alpha = 0.7
function moveRight:tap (event)
man:applyLinearImpulse( 0.25, 0 , man.x , man.y)
end 
moveRight:addEventListener("tap" , moveRight)
--move Left--------------------------------------------------------------- 
local moveLeft = display.newImageRect(sceneGroup,"jump2.png" , 70,55)
moveLeft.x = display.contentCenterX-230
moveLeft.y = display.contentHeight-35
moveLeft.alpha = 0.7
function moveLeft:tap (event)
man:applyLinearImpulse( -0.25, 0 , man.x , man.y)
end 
moveLeft:addEventListener("tap" , moveLeft)


 --Restores character -------------------------------------------------------------------------------
 	local function restoreMan()
 
    man.isBodyActive = false
    transition.to( man, {time=2000, alpha=0.3 ,
    
		onComplete = function()
            transition.to( man, { time=100, alpha =1 }) 
			man.isBodyActive = true
            end
    } )
end


--Ends Game----------------------------------------------------------------------------------------------------------------------
local function endGame()
	rockvelocity = 0
	velocity = 0 
	runSpeed= 0 
	velocityamount = 0 
	amount = 0 
	
	audio.stop( backgroundMusicChannel )
	audio.play(jumpsound)
	composer.setVariable( "finalScore", score )
	display.remove(man)
	display.remove(highScoreFont)
	
	local gameover = display.newText(sceneGroup, "Game Over", display.contentCenterX, display.contentCenterY-80, "font.ttf", 40 )
	gameover:setFillColor( 0 , 0 , 0 )
	
	
	local homeButton = display.newText( sceneGroup,"Home", display.contentCenterX, display.contentCenterY, "font.ttf", 20 )
	homeButton:setFillColor( 0 , 0 , 0 )

	pistonJoint:removeSelf()
	
	Runtime:removeEventListener( "enterFrame", move)
	button:removeEventListener("tap" , button)
	moveRight:removeEventListener("tap" , moveRight)
	moveLeft:removeEventListener("tap" , moveLeft)
    display.remove(heart)
	display.remove(heart2)
	display.remove(heart3)
	lives = 0
	display.remove(ground)
	display.remove(ground1)
	display.remove(ground2)
	display.remove(pit) 
	 display.remove(deathforce)
	function homeButton:tap (event)
    composer.removeScene("easy" )
	composer.gotoScene("mainmenu" ,{ effect = "fade"  , time = 200 } )
	 
    end 
    homeButton:addEventListener("tap" , homeButton)	
end
	

    	
-- Collision Handler -------------------------------------------------------------------------------------------------------------
local function manCollision( self , event )
 
    if event.phase == "began"  then
    if (event.target.type=="man" and event.other.type=="deathforce") then 
	endGame()
	end 
   end 
   end 

man.collision = manCollision
man:addEventListener("collision" , man)		

local function pitCollision( self , event )
 
    if event.phase == "began"  then
    if (event.target.type=="pit" and event.other.type=="man") then 
	endGame()
	
	end 
   end 
   end 

pit.collision = pitCollision
pit:addEventListener("collision" , pit)		

--rock spawning and collision  handler---------------------------------------------------------------
local function spawnRock()
local rock = display.newImageRect( sceneGroup,"rock2.png", 40, 30 )
rock.x = math.random(10, 500)
rock.y = display.contentHeight+500
physics.addBody(rock , "kinematic"   ) 
rock:setLinearVelocity( 0, rockvelocity)
rock.type = "rock"

local function rockCollision( self , event )
 
    if event.phase == "began"  then
    if ((event.target.type=="rock" and event.other.type=="man")  or 
	(event.target.type=="man" and event.other.type=="rock"))   then 
	
	timer.performWithDelay( 10, restoreMan )
	  
	audio.play(jumpsound)
    
    lives = lives - 1 
	if ( lives == 2 ) then 
	display.remove(heart)
	
	elseif ( lives == 1 ) then 
	display.remove(heart2)
	 
	elseif ( lives == 0  ) then 
	endGame()
	display.remove(heart3)
	display.remove(rock)
	display.remove(spear)
	display.remove(rock1)
end

end 
end 
end 
rock.collision = rockCollision
rock:addEventListener( "collision" , rock)
end
timer.performWithDelay(  8000, spawnRock, delayTime)



-- Spear Spawning and collision handler--------------------------------------------------------------------
local function spawnSpear()
local spear = display.newImageRect(sceneGroup, "spike2.png", 100, 50 )
spear.x = math.random(600, 850)
spear.y = math.random(190, 240) 
local headShape = {-22 , -15 , -35, 2 , -22 , 15 }
local spearShape  = {  -22 , -3 , -22 , 3, 40, 3, 40, -3  }
physics.addBody(spear, "kinematic",  
{shape = headShape},
{shape = spearShape}
) 
spear:setLinearVelocity( velocity, 0)
spear.type = "spear"

local function spearCollision( self , event )
    
    if event.phase == "began"  then
	if ((event.target.type=="spear" and event.other.type=="man") or 
	(event.target.type=="man" and event.other.type=="spear"))   then 
   
	timer.performWithDelay( 10, restoreMan )
	audio.play(jumpsound)
	
	lives = lives - 1 
    if ( lives == 2  ) then 
	display.remove(heart)
	 
	elseif ( lives == 1  ) then 
	display.remove(heart2)
	 
	elseif ( lives == 0 ) then 
	endGame()
	display.remove(heart3)
	display.remove(rock)
	display.remove(spear)
	display.remove(rock1)
end
end
end 
end 
spear.collision = spearCollision
spear:addEventListener("collision" , spear)
end
timer.performWithDelay(  7500, spawnSpear, delayTime)


-- rocks spawing and collision handler 2-------------------------------------------------------------------------------------------------------------- 
 local function spawnRock1()
local rock1 = display.newImageRect(sceneGroup, "rock1.png", 40, 30 )
rock1.x = math.random(10 , 500)
rock1.y =  display.contentHeight-500
physics.addBody(rock1 , "kinematic"  ) 
rock1:setLinearVelocity( 0, -rockvelocity)
rock1.type = "rock1"

local function rock1Collision( self , event )
    if event.phase == "began"  then
	if ((event.target.type=="rock1" and event.other.type=="man") or 
	(event.target.type=="man" and event.other.type=="rock1"))   then 
    
	timer.performWithDelay( 10, restoreMan )
	
	audio.play(jumpsound)
	
	lives = lives - 1 
	if ( lives == 2  ) then 
	display.remove(heart)
	 
	elseif ( lives == 1 ) then 
	display.remove(heart2)
	 
	elseif ( lives == 0 ) then 
	endGame()
	display.remove(heart3)
	display.remove(rock)
	display.remove(spear)
	display.remove(rock1)
end
end 
end 
end
rock1.collision = rock1Collision
rock1:addEventListener("collision" , rock1)
end 
 timer.performWithDelay(8000, spawnRock1, delayTime)
 

end
scene:addEventListener( "create", scene )

function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
       timer.cancel(spawnRock1)
   timer.cancel(spawnRock)
   timer.cancel(spawnSpear) 
 timer.cancel(runSpeedIncrease)
	timer.cancel(velocitySpeeder)
    elseif ( phase == "did" ) then
       
  composer.removeScene( "easy" )
    end
end

scene:addEventListener( "hide", scene )



return scene
