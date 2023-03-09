module Directors
    class Ending
        attr_accessor :next_director, :winner, :winner_point

        def initialize    
         @bg_img = Image.load("image/ending_2.jpg")
         @winner = nil
         @winner_point = nil
         @font5 = Font.new(70)
        end
    
        def play
            Window.draw(0, 0, @bg_img)
            Window.draw_font(100, 300, "#{@winner}P：#{@winner_point}ポイント獲得！！", @font5, {:color => C_BLACK})
            # タイトル画面に戻る
            if Input.key_push?(K_SPACE)
                return @next_director
            end
            self    
        end
    end
end