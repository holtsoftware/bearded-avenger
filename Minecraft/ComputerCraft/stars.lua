local holeWidth = 5
local height = 4
local lend = false

function forward()
	while turtle.detect() do
		turtle.dig()
	end
	while turtle.attack() do
	end
	turtle.forward()
end

function selectItem(name)
	for i=1,16 do
		turtle.select(i)
		local data = turtle.getItemDetail()
		if data and data.name == name then
			return
		end
	end
end

function doHeight()
	for i=1,(height - 1) do
		if turtle.detectUp() then
			turtle.digUp()
		end
		turtle.up()
	end
	for i=1,(height - 1) do
		turtle.down()
	end
end

function goDown()
	local success, data = turtle.inspectDown()

	if success and data.name == "minecraft:bedrock" then
		lend = true
		print("hit bedrock")
	elseif turtle.detectDown() then
		turtle.digDown()
		turtle.down()
	else
		turtle.down()
	end
end

while not lend do
	for i=1,holeWidth do
		if not lend then
			doHeight()
			forward()
			turtle.turnRight()
			turtle.turnRight()
			selectItem("minecraft:oak_stairs")
			turtle.place()
			turtle.turnLeft()
			turtle.turnLeft()
			goDown()
		end
	end
	if not lend then
		doHeight()
		forward()
		turtle.turnRight()
		turtle.turnRight()
		selectItem("minecraft:oak_stairs")
		turtle.place()
		turtle.turnLeft()
		turtle.turnLeft()
		for i=1,3 do
			doHeight()
			turtle.turnRight()
			for j=1,holeWidth+1 do
				forward()
				doHeight()
			end
		end

		turtle.turnRight()
	end
end