module Directors
    class Game
        def initialize(next_director)
         @next_director = next_director
         @bg_img = Image.load("images/game_1.jpg")
        end
        
    
        def play
         Window.draw(0, 0, @bg_img)

         
           if Input.key_push?(K_SPACE)
              return @next_director
            end
         self    
        end
    end
end