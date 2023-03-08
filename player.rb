class Player < Sprite
    @@heximage = Image.load('image/mousepoint.png')
    def initialize(mx=0,my=0)
        @mx = mx
        @my = my
        self.image = @@heximage
        self.collision = [1,1]
    end
    def update
        self.x = Input.mouse_x
        self.y = Input.mouse_y
    end
    
    def shot(hexagon)
        puts "#{}"
    end

    
    # def syoutotucheck
    #     if @player === @hexagon && Input.mouse_push?(M_LBUTTON)
    #         Window.draw_font(500, 300, "衝突", font)
    #     end
    # end

end