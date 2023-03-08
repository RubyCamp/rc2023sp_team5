class Hexagon
    # attr_accessor :x, :y
    def initialize(x,y,image)
        @x = x
        @y = y
        @image = image    
    end

    def draw
        Window.draw(@x,@y,@image)
    end
end