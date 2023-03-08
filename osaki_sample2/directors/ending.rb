module Directors
    class Ending
        def initialize
    
         @bg_img = Image.load("images/ending_1.jpg")
        end
    
        def play
         Window.draw(0, 0, @bg_img)
           if Input.key_push?(K_SPACE)
              
            end
         self    
        end
    end
end