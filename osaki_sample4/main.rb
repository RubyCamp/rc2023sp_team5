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

map = Map.new
player = Player.new("1P", 0)

ending_director = Directors::Ending.new
game_director = Directors::Game.new(ending_director)
title_director = Directors::Title.new(game_director)

ending_director.next_director = title_director

current_director = title_director

Window.loop do
  map.update
  map.draw
  
  player.update
  player.draw  
   
  current_director = current_director.play
end