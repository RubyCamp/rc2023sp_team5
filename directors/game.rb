module Directors
    class Game
        def initialize(next_director)
          @next_director = next_director
          @bg_img = Image.load("image/game_ui2.jpg")
          @heximage = Image.load('image/Hex50x58.png')
          @imgwidth,@imghaight = 50,58

          @font1 = Font.new(64)
          @font2 = Font.new(50)
          

          @first_player = Player.new(1)
          @second_player = Player.new(0)
          # 盤面の初期化
          @board = Board.new(@first_player, @second_player)
        end
    
        def play
          Window.draw(0, 0, @bg_img)

           
         


          Window.draw_font(660, 10, "先手", @font1, {:color => C_GREEN})
          Window.draw_font(660, 310, "後手", @font1, {:color => C_GREEN})
          Window.draw_font(550, 115, "先手:#{@first_player.point}pt", @font2, {:color => C_GREEN})
          Window.draw_font(550, 415, "後手:#{@second_player.point}pt", @font2, {:color => C_GREEN})
          #Window.draw_font(550, 485, "きみのターン！", @font3, {:color => C_YELLOW})


          hexagons = []
          evenflag = false
          start_x  = 75
          start_y  = 100
          for j in 0..8 do
            if j % 2 == 0
              evenflag = true
            else
              evenflag = false
            end
            8.times do |i|
              x = i *@imgwidth + start_x
              y = i *1 + j * @imghaight*0.74  + start_y
              if  evenflag
                x += @imgwidth*0.5
                if i >= 7
                  break
                end
              end
              hexagon = Hexagon.new(x,y,@heximage,@imgwidth,@imghaight)
              hexagons << hexagon
            end
          end
          
          @board.update
          @board.draw
          
          hexagons.each do |hexagon|
            hexagon.draw
          end

          if @board.game_end? || Input.key_push?(K_SPACE)
            if @first_player.point > @second_player.point
              @next_director.winner = 1
            else 
              @next_director.winner = 2
            end
            return @next_director
          end
          self    
        end
    end
end

