class Player
    def initialize(name, point)
        @font = Font.new(24)
        @name = name
        @point = point
    end

    def update
    end

    def draw
        Window.draw_font(0, 0, @name, @font)
    end
end