module Directors
    class Game
        def initialize(next_director)
         @next_director = next_director
         @bg_img = Image.load("image/game_1.jpg")
         @heximage = Image.load('image/Hex50x58.png')
         @map = Map.new
       end
        
    
        def play
#          Window.draw(0, 0, @bg_img)

          hexagons = []
          evenflag = false
          for j in 0..8 do
            if j % 2 == 0
              evenflag = true
            else
              evenflag = false
            end
            8.times do |i|
              x = i *50
              y = i *1 + j * 43
              if  evenflag
                x += 25
                if i >= 7
                  break
                end
              end
              hexagon = Hexagon.new(x,y,@heximage)
              hexagons << hexagon
            end
          end

          @map.update
          @map.draw
          hexagons.each do |hexagon|
            hexagon.draw
          end

          if Input.key_push?(K_SPACE)
            return @next_director
          end
          self    
        end
    end
end