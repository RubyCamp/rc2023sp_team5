require 'dxruby'
require_relative 'map'

map = Map.new

Window.width = 800
Window.height = 600
Window.caption = "Team5 Game"

Window.loop do
  map.update
  map.draw
end