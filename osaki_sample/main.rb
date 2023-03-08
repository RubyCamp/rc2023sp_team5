require 'dxruby'
require_relative 'map'
require_relative "player"

map = Map.new
player = Player.new("1P", 0)

Window.loop do
  map.update
  map.draw
  
  player.update
  player.draw
end