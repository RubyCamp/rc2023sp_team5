require 'dxruby'
require_relative 'map'
require_relative "hexagon"
require_relative "player"

heximage = Image.load('image/Hex50x58.png')
map = Map.new
player = Player.new

imgwidth  = 50
imghaight = 58

hexagons = []
evenflag = false
for j in 0..8 do
  if j % 2 == 0
    evenflag = true
  else
    evenflag = false
  end
  8.times do |i|
    x = i *imgwidth
    y = i *1 + j * 43
    if  evenflag
      x += 25
      if i >= 7
        break
      end
    end
    hexagon = Hexagon.new(x,y,heximage)
    hexagons << hexagon
  end
end

Window.width = 800
Window.height = 600
Window.caption = "Team5 Game"

Window.loop do
  map.update
  map.draw
  hexagons.each do |hexagon|
    hexagon.draw
  player.mousepos
  end
end