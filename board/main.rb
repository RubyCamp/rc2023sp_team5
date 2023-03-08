require 'dxruby'
require_relative "board"

board = Board.new
# 文字を表示させる
font = Font.new(32)

Window.loop do
  board.update
  board.draw
  if board.turn % 2 == 0
    Window.draw_font(100,100, "今の手番は後手", font)
  else
    Window.draw_font(100,100, "今の手番は先手", font)
  end
  
end