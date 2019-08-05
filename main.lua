require("engine_config")
require(GRAPHICS_ENGINE_PATH .. "ParticleSystem")
require(PHYSICS_ENGINE_PATH .. "Circle")
require(PHYSICS_ENGINE_PATH .. "Vector2")

local system

function love.load()
	--[[ local img = love.graphics.newImage('Assets/Images/Particles/smoke_04.png')
 
	psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setParticleLifetime(2, 10) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(5)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency. ]]

	local force = 40
	system = ParticleSystem:init(nil, Circle:init(Vector2:init(love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5), 1, 0.01), 100)
	system:setParticleLifeTime(0, 1)
	system:setLinearForce(-force/2, -force, force/2, 0)
	system:emit()
end
 
function love.draw()
	--[[ -- Draw the particle system at the center of the game window.
	love.graphics.draw(psystem, love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5, 0, 0.05, 0.05, 0, 0) ]]
	system:draw()
end
 
function love.update(dt)
	--[[ psystem:update(dt) ]]
	system:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then 
		if system.state == PARTICLESYSTEM_STOPPED then
			system:emit()
		else
			system:stop()
		end
	end

	if key == "escape" then
		love.event.quit()
	end
end