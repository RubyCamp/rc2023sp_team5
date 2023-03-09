class Hexagon < Sprite
    # attr_accessor :x, :y
    def initialize(x,y,image,imgwidth,imghaight)
        self.x = x
        self.y = y
        @checkfont = Font.new(60) 

        self.image = image
        self.collision=[imgwidth/2,imghaight/2,imgwidth/2]
        #@font = Font.new(32)
    end

    def hit(player)
        puts "あたってる"
        Window.draw_font(x, y, "衝突", @checkfont)
    end

        # def draw
    #     # Sprite.draw(@x,@y,@image)
    #     # Window.draw(@x,@y,@image)
    # end
end