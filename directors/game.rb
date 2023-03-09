module Directors
    class Game
        def initialize(next_director)
          @next_director = next_director
          @bg_img = Image.load("image/game_ui2.jpg")
          @heximage = Image.load('image/Hex50x58.png')
          @map = Map.new
          @imgwidth,@imghaight = 50,58
        end

        
        
    
        def play
          Window.draw(0, 0, @bg_img)
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
          player = Player.new
          @map.update
          @map.draw
          player.update
          player.draw
          hexagons.each do |hexagon|
            hexagon.draw
          Sprite.check(player,hexagons)
          end

          if Input.key_push?(K_SPACE)
            return @next_director
          end
          self    
        end
    end
end