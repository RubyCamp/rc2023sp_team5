class Hexagon < Sprite
    # attr_accessor :x, :y
    def initialize(x,y,image)
        self.x = x
        self.y = y
        self.image = image 
        self.collision=[25,29,25]
      # @font = Font.new(32)
    end

   # def hit(player)
    #    Window.draw_font(x, y, "衝突", @font)
    #end
        # def draw
    #     # Sprite.draw(@x,@y,@image)
    #     # Window.draw(@x,@y,@image)
    # end
end