# 本ファイルはRubyキャンプ2023春の講師である穂高さんが作ってくださったものです。オセロのサンプルコートです。

class Board
  LINE_SEP = 64

  # 盤面を初期化
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
      # コマを置けない場合、「置けないよ」と表示する
      if judge(cx, cy)
        # 描画する
        set_chip(cx, cy)
        # 裏返す


      # コマを置けない場合、とりあえずターミナルに表示する
      else
        puts "置けないよ"  
      end
    end
  end

  # コマを表示
  def draw
    draw_lines
    @data.each_with_index do |line, dy|
      line.each_with_index do |chip, dx|
        Window.draw(dx * LINE_SEP, dy * LINE_SEP, @chips[chip]) if chip >= 0
      end
    end
  end


  private
  # コマを置く処理
  def set_chip(x, y)
    # 手番が奇数の場合、先手（白）。偶数の場合、後手（白）
    @data[y][x] = @turn % 2
    @turn += 1
  end

  # コマを置けるかどうか判定する処理
  def judge(x, y)
    # コマが置いていないかどうか、また相手のコマが隣接していれば裏返せる
    if @data[y][x] == -1 
      2.times do |i|
        2.times do |j|
          if data[]
            return true
          end
        end
      end
    else
      return false
    end
  end

  #　盤面を描画する
  def draw_lines
    LINE_SEP.step(Window.width, LINE_SEP) do |dx|
      Window.draw_line(dx, 0, dx, Window.height, C_WHITE)
    end

    LINE_SEP.step(Window.height, LINE_SEP) do |dy|
      Window.draw_line(0, dy, Window.width, dy, C_WHITE)
    end
  end
end