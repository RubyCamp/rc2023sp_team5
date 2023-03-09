require 'dxruby'
require_relative "board"
require_relative "player"

# プレイヤーの初期化
first_player = Player.new(1)
second_player = Player.new(0)

# 盤面の初期化
board = Board.new(first_player, second_player)
# 文字を表示させる
font = Font.new(32)

Window.loop do
  board.update
  board.draw

  # プレイヤーアイコンの表示
  #firstplayer.update
  #player.draw

  if board.turn % 2 == 0
    Window.draw_font(100,100, "今の手番は後手", font)
  else
    Window.draw_font(100,100, "今の手番は先手", font)
  end

  # プレイヤーの点数の表示
  Window.draw_font(400, 100, "先手の点数#{first_player.point}" , font) #先手
  Window.draw_font(400, 200, "後手の点数#{second_player.point}", font) #後手

  # ゲーム終了かどうかをチェック
  if board.game_end
    break
  end
  
end