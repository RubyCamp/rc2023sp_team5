module Directors

  class Game
    def initialize(next_director)
      @next_director = next_director
      @bg_img = Image.load("image/game_ui2.jpg")
      @heximage = Image.load('image/Hex50x58.png')
      @imgwidth, @imgheight = 50, 58
      @font1 = Font.new(64)
      @font2 = Font.new(50)
      @font3 = Font.new(40)
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
      # 背景画像の表示
      Window.draw(0, 0, @bg_img)
      if @board.can_play == false
        # puts "置けないよ" 
        Window.draw_font(100, 400, "置けないよ", @font3, {:color => C_WHITE})
      end

      Window.draw_font(660, 10, "先手", @font1, {:color => C_GREEN})
      Window.draw_font(660, 310, "後手", @font2, {:color => C_GREEN})
      Window.draw_font(550, 190, "先手:#{@first_player.point}pt", @font1, {:color => C_GREEN})
      Window.draw_font(550, 490, "後手:#{@second_player.point}pt", @font2, {:color => C_GREEN})

      @board.update
      @board.draw
      
      # @hexagons.each do |row|
      #   row.each do |hexagon|
      #     hexagon.draw
      #   end
      # end

      if @board.game_end? || Input.key_push?(K_SPACE)
        # ending_directorに勝者の情報を渡す
        if @first_player.point > @second_player.point
          @next_director.winner = 1
          @next_director.winner_point = @first_player.point
        else 
          @next_director.winner = 2
          @next_director.winner_point = @second_player.point
        end
        # 勝利時の音楽を鳴らす
        @winning_bgm.play
        return @next_director
      end
      self    
    end
  end
end

