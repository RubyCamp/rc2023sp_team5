require 'dxruby'
require_relative 'board'
require_relative "hexagon"
require_relative "player"
require_relative "directors/title"
require_relative "directors/game"
require_relative "directors/ending"

# ウィンドウの初期化
Window.width = 800
Window.height = 600
Window.caption = "Team5 Game"

# ゲームディレクターの初期化
ending_director = Directors::Ending.new
game_director = Directors::Game.new(ending_director)
title_director = Directors::Title.new(game_director)

ending_director.next_director = title_director
current_director = title_director

# ゲームループ
Window.loop do
  current_director = current_director.play
end