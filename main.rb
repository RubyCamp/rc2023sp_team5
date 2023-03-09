require 'dxruby'
require_relative 'map'
require_relative "hexagon"
require_relative "player"
require_relative "directors/title"
require_relative "directors/game"
require_relative "directors/ending"

Window.width = 800
Window.height = 600
Window.caption = "Team5 Game"

heximage = Image.load('image/Hex50x58.png')
map = Map.new

ending_director = Directors::Ending.new
game_director = Directors::Game.new(ending_director)
title_director = Directors::Title.new(game_director)

ending_director.next_director = title_director
current_director = title_director

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

p hexagons

Window.loop do
  map.update
  map.draw
  Sprite.check(player,hexagons)
  hexagons.each do |hexagon|
    hexagon.draw
  end
  current_director = current_director.play
  player.update
  player.draw
end