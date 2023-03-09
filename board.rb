# 本ファイルはRubyキャンプ2023春の講師である穂高さんが作ってくださったオセロのサンプルコードです。
# 盤面の表示とコマを置くメソッド以外は下山が実装しました。

class Board
  attr_accessor :turn, :game_end

  LINE_SEP = 64


  # 盤面を初期化
  def initialize(first_player, second_player)
    @data = []
    @data << [-1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, 1, 0, -1, -1, -1]
    @data << [-1, -1, -1, 0, 1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1]
    @data << [-1, -1, -1, -1, -1, -1, -1, -1]
    @turn = 1 # ターンを表わす変数
    @chips = [
      Image.new(LINE_SEP, LINE_SEP).circle_fill(LINE_SEP / 2, LINE_SEP / 2, LINE_SEP / 2, C_WHITE),
      Image.new(LINE_SEP, LINE_SEP).circle_fill(LINE_SEP / 2, LINE_SEP / 2, LINE_SEP / 2, C_BLACK)

    ]
    @font3 = Font.new(40)
    @trn_img1 = Image.load("image/haikei_white.png")
    @trn_img2 = Image.load("image/haikei_black.png")
    @sound1 = Sound.new("sound/othello_02.wav")

  # 石の入れ替えイベント用変数
    @random_num = rand(2..10)
    # p @random_num
    
  # 手番のプレイヤーを表す変数
    @first_player = first_player
    @second_player = second_player
    #game終了を判定する変数
    @game_end = false
  # イベント用の変数
    @doublepoint1p = false
    @doublepoint2p = false
    @skip_event = 3
    @skip_event_flag =false
  end

  def update
    @stonecount = 0
    mx, my = Input.mouse_x, Input.mouse_y
    cx, cy = mx / LINE_SEP, my / LINE_SEP
    if cx <  8 && cy < 8
      if Input.mouse_push?(M_LBUTTON)
        # コマを置ける場合、描画する
        directions = judge(cx, cy)
        # 置きたいコマの周囲に相手の石がない場合、ターミナルに「置けないよ」と表示する
        if directions.empty?
          puts "置けないよ" 
        # 相手の石があってもひっくり返せない場合は
        else
          reverse_pos = return_reverse_pos(directions, cx, cy)
          # ひっくり返せるマスがない場合
          if reverse_pos.empty?
            puts "ひっくり返せるコマがないよ"
          # ひっくり返せるマスがある場合
          else
            # ひっくり返す
            reverse_stones(reverse_pos)
            # 石を置く
            set_chip(cx, cy)
            if @skip_event == @turn
              turnskip
            end
            if @skip_event_flag == true && @turn > @skip_event+1
              @skip_event_flag = false
            end
            # 盤面初期時に作成したインスタンス変数@random_numがターン数と一致した場合
            # if @random_num == @turn 
            # # 自分と相手の石を反転させる処理
            #   reverse_color
            # end
          end
        end
    if @turn_color != 0
      Window.draw(550, 185, @trn_img1)
      Window.draw_font(550, 185, "きみのターン！", @font3, {:color => C_RED})
    else
      Window.draw(550, 485, @trn_img2)
      Window.draw_font(550, 485, "きみのターン！", @font3, {:color => C_YELLOW})
    end
      # プレイヤーの点数を加点する
      if @turn_color == 1
        @first_player.point +=1
        #　ポイント2倍フラグがオンの時追加で1点
        if @doublepoint1p
          plus_point(@first_player)
          @doublepoint1p = false
        end
        #　3個以上ひっくり返したときに追加で1点
        if @stonecount >= 3
          plus_point(@first_player)
          @stonecount = 0
        end
      else
        @second_player.point +=1
        if @doublepoint2p
          plus_point(@second_player)
          @doublepoint1p = false
        end
        if @stonecount >= 3
          plus_point(@second_player)
          @stonecount = 0
        end
      end
      end
    end
    # ゲーム終了を監視する
    if game_end?
      puts 'ゲームを終了します'
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
    if @skip_event_flag == true
      Window.draw_font(250, 550, "追加ターン！！", @font3, {:color => C_RED})
    end
  end

  # ゲームを終了するかどうか判定する関数
  def game_end?
    # すべてのマスに対し、return_reverse_posメソッドを実行し返り値の配列が空でなければfalseを返す
      @data.each_with_index do |data, i|
        data.each_with_index do |index, j|
          unless return_reverse_pos(judge(j, i), j, i).empty?
            return @game_end        
          end
        end
      end
      # すべてのマスを探索し裏返せるコマがない場合trueを返す
      @game_end = true
      return @game_end
    end


  private

  # コマを置く処理
  def set_chip(x, y)
    # 手番が奇数の場合、先手（白）。偶数の場合、後手（白）
    @data[y][x] = @turn_color
    @turn += 1
  end

  # 周囲に相手のコマがあるかどうか判定するメソッド
  def judge(x, y)
    # クリックしたマスにコマが置いていないかどうかを確認する。
    # 引数： x:マウスが置かれている配列のx座標、y:y座標
    # 手番を判定する変数。1の場合、先手。0の場合、後手。
    @turn_color = @turn % 2
    # 方角を保持する配列
    directions = []
    # 置きたいマスが空白かどうか
    if @data[y][x] == -1
      # クリックした周囲8マスに相手のコマがあるかどうか確認
      (-1..1).each do |i|
        next if y+i < 0 || y+i > 7
        (-1..1).each do |j|
          next if x+j < 0 || x+j > 7
          # @turn_colorは手番を表わす変数。奇数の場合、先手。偶数の場合は後手。
          # 周囲8マスを探索して相手のコマが隣接している、すなわち@turn_colorとは異なる変数があればtrueを返す
          if @data[y+i][x+j] != -1 && @data[y+i][x+j] != @turn_color
            #puts "違う色が隣接しているね"
            directions << [j,i]
          end
        end
      end
    end
    return directions
  end

  # judgeメソッドの返り値directionsを使ってひっくり返せる座標reverse_posを返すメソッド
  def return_reverse_pos(directions, x, y)
    # 相手のコマがある方向にむけて探索する
    # 色をひっくり返す座標を保持する配列
    reverse_pos = []
    # コマをひっくり返すか判定するフラグ
    reverse_flag = false
    # 方角を保持した二次元配列directionsを使う
    directions.each do |direction|
      # 探索している座標を格納する配列
      tmp_pos = []
      # ひっくり返すコマのｘ座標
      reverse_row = x
      # ひっくり返すコマのy座標
      reverse_col = y
    
      # ひっくり返すx座標
      reverse_row += direction[0]
      # ひっくり返すy座標
      reverse_col += direction[1]
      # 一時的な配列に格納する
      tmp_pos << [reverse_row, reverse_col]
      # 見つけた方向を捜査していく
      while true
        # 盤面の外を探索しないように範囲を限定する
        next if reverse_col < 0 || reverse_col > 7 || reverse_row < 0 || reverse_row > 7 #この行は必要？
          if @data[reverse_col][reverse_row] != @turn_color && @data[reverse_col][reverse_row] != -1
            # ひっくり返すx座標
            reverse_row += direction[0]
            # ひっくり返すy座標
            reverse_col += direction[1]
      
            tmp_pos << [reverse_row, reverse_col]
            
            # ループの中で配列の外を参照しそうになった時、ループを外に出せる
            if reverse_col < 0 || reverse_col > 7 || reverse_row < 0 || reverse_row > 7
              break
            end
          
          # 手番と同じ色のコマに到達したらフラグをtrueにして探索終了
          elsif @data[reverse_col][reverse_row] == @turn_color
            reverse_flag = true
            # tmp_posをreverse_posに追加する
            reverse_pos += tmp_pos.slice(0..-2)
            # ここでx,ｙの座標が着手可能な座標にあたる
            # 例えば着手可能な座標と、そこに置くとひっくり返せる座標の配列のハッシュを返したりする？

            break
          # 何も置かれていないコマの場合も探索終了
          else
            #puts "何もコマがおかれておらず探索終了"
            break
          end
      end
    end
    return reverse_pos
  end
  
  # コマを置いた時、隣接する相手のコマを反転させるメソッド
  def reverse_stones(reverse_pos)
    #return_reverse_posメソッドの返り値の二次元配列を受け取る
    # 間にあった相手の石を裏返す
    reverse_pos.each do |pos|
      @data[pos[1]][pos[0]] = @turn_color
      # プレイヤーの点数を加点する
      if @turn_color == 1
        @first_player.point +=1
      else
        @second_player.point +=1
      end
      @stonecount += 1
    end
  end

  # コマの色をすべて逆にするイベント用のメソッド
  def reverse_color
    # 盤面の全てのコマを確認して1を0に、0を1にしてひっくり返す         
    @data.each do |row|
      row.each_with_index do |item,i|
        if item == 0
          row[i] = 1
        elsif item == 1
          row[i] = 0
        end
      end
    end
  end
  
  # 1ターン飛ばすメソッド
  def turnskip
    @turn += 1
    @skip_event_flag =true
  end

  # playerのポイントを加算するメソッド
  def plus_point(player)
    plus_point = 1
    player.point += plus_point
  end

  # ポイント二倍フラグをオンにするメソッド
  def doublepointflag(turn)
    if turn == 1
      @doublepoint1p = true
    else
      @doublepoint2p = true
    end
  end

  #　盤面を描画する
  def draw_lines
    count = 0
    LINE_SEP.step(Window.width, LINE_SEP) do |dx|
      break if count > 7
      Window.draw_line(dx, 0, dx, Window.height - 90, C_WHITE)
      count += 1
    end

    count = 0
    LINE_SEP.step(Window.height, LINE_SEP) do |dy|
      break if count > 7
      Window.draw_line(0, dy, Window.width - 290 , dy, C_WHITE)
      count += 1
    end
  end
end
