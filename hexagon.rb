class Hexagon < Sprite
    # attr_accessor :x, :y
    def initialize(x,y,image)
        self.x = x
        self.y = y
        self.image = image    
    end

    # def draw
    #     # Sprite.draw(@x,@y,@image)
    #     # Window.draw(@x,@y,@image)
    # end
end