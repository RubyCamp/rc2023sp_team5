class Map
  LINE_SEP = 64

  def initialize
    @data = []
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    @turn = 1
    @chips = [
      Image.new(LINE_SEP, LINE_SEP).circle_fill(LINE_SEP / 2, LINE_SEP / 2, LINE_SEP / 2, C_BLUE),
      Image.new(LINE_SEP, LINE_SEP).circle_fill(LINE_SEP / 2, LINE_SEP / 2, LINE_SEP / 2, C_YELLOW)
    ]
  end

  def update
    mx, my = Input.mouse_x, Input.mouse_y
    cx, cy = mx / LINE_SEP, my / LINE_SEP
    if Input.mouse_push?(M_LBUTTON)
      set_chip(cx, cy)
      
     # judge(cx, cy)
    end
  end

  def draw
    draw_lines
    @data.each_with_index do |line, dy|
      line.each_with_index do |chip, dx|
        Window.draw(dx * LINE_SEP, dy * LINE_SEP, @chips[chip]) if chip >= 0
      end
    end
  end

  private

  def set_chip(x, y)
    @data[y][x] = @turn % 2
    @turn += 1
  end

  def draw_lines
    LINE_SEP.step(Window.width, LINE_SEP) do |dx|
      Window.draw_line(dx, 0, dx, Window.height, C_WHITE)
    end

    LINE_SEP.step(Window.height, LINE_SEP) do |dy|
      Window.draw_line(0, dy, Window.width, dy, C_WHITE)
    end
  end
end
