class Map
  LINE_SEP = 80

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
    end
  end

  def draw(image)
    Window.draw(0,0,image)
  end

  def draw
    draw_font
    #   draw_lines
    # @data.each_with_index do |line, dy|
    #   line.each_with_index do |chip, dx|
    #     Window.draw(dx * LINE_SEP, dy * LINE_SEP, @chips[chip]) if chip >= 0
    #   end
  end
  private

  def set_chip(x, y)
    @data[y][x] = @turn % 2
    @turn += 1
  end

  def draw_font
    font = Font.new(32)
    Window.draw_font(600,0,"player1",font)
    Window.draw_font(600,300,"player2",font)
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
