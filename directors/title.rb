module Directors
    class Title
        def initialize(next_director)
          @next_director = next_director
          @bg_img = Image.load("image/start_2.jpg")
        end
    
        def play
          Window.draw(0, 0, @bg_img)
            if Input.key_push?(K_SPACE)
              return @next_director
            end
            return self    
        end
    end
end