require 'dxruby'
require_relative 'map'
require_relative "hexagon"

heximage = Image.load('image/Hex50x58.png')
map = Map.new

hexagons = []
evenflag = false
for j in 0..8 do
  if j % 2 == 0
    evenflag = true
  else
    evenflag = false
  end
  8.times do |i|
    x = i *50
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
  end
end