require 'dxruby'
require_relative 'map'

map = Map.new

Window.loop do
  map.update
  map.draw
end