require 'dxruby'
require_relative "board"

board = Board.new

Window.loop do
  board.update
  board.draw
end