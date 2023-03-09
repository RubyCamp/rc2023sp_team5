module Directors
    class Ending
        attr_accessor :next_director, :winner
        def initialize    
         @bg_img = Image.load("image/ending_2.jpg")
         @winner = nil
         @font5 = Font.new(70)
        end
    

        def play
         Window.draw(0, 0, @bg_img)
         Window.draw_font(500, 350, "#{@winner}P", @font5, {:color => C_BLACK})
            if Input.key_push?(K_SPACE)
                
                return @next_director
            end
            self    
        end

        
    end
end