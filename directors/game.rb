module Directors
  class Game
    def initialize(next_director)
      @next_director = next_director
      @bg_img = Image.load("image/game_ui2.jpg")
      @heximage = Image.load('image/Hex50x58.png')
      @imgwidth, @imgheight = 50, 58
      @font = Font.new(64)
      @first_player = Player.new(1)
      @second_player = Player.new(0)
      # 盤面の初期化
      @board = Board.new(@first_player, @second_player)
      # 音声ファイルの読み込み
      @winning_bgm = Sound.new("sound/win.wav")

      # # 盤面の六角形を
      # @hexagons = []
      # evenflag = false
      # start_x  = 75 # x座標の始点
      # start_y  = 100 # y座標の始点
      # # 2次元配列に格納する
      # for j in 0..8 do
      #   if j % 2 == 0
      #     evenflag = true
      #   else
      #     evenflag = false
      #   end
      #   tmp_ary = []
      #   8.times do |i|
      #     x = i *@imgwidth + start_x
      #     y = i *1 + j * @imgheight*0.74  + start_y
      #     if  evenflag
      #       x += @imgwidth*0.5
      #       if i >= 7
      #         break
      #       end
      #     end
      #     @hexagon = Hexagon.new(x,y,@heximage,@imgwidth,@imgheight)
      #     tmp_ary << @hexagon
      #   end
      #   @hexagons << tmp_ary
      # end
      # p @hexagons
    end

    def play
      Window.draw(0, 0, @bg_img)

      Window.draw_font(660, 10, "先手", @font, {:color => C_GREEN})
      Window.draw_font(660, 310, "後手", @font, {:color => C_GREEN})
      Window.draw_font(550, 190, "先手:#{@first_player.point}pt", @font, {:color => C_GREEN})
      Window.draw_font(550, 490, "後手:#{@second_player.point}pt", @font, {:color => C_GREEN})

      @board.update
      @board.draw
      
      # @hexagons.each do |row|
      #   row.each do |hexagon|
      #     hexagon.draw
      #   end
      # end

      # ゲーム終了
      if @board.game_end? || Input.key_push?(K_SPACE)
        @winning_bgm.play
        return @next_director
      end
      self    
    end
  end
end