module Directors
    class Ending
        attr_accessor :next_director
        def initialize    
         @bg_img = Image.load("image/ending_2.jpg")
         
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