class Player < Sprite 
    attr_accessor :point
    # 画像の読み込み
    @@cursor_image = Image.load("image/mouse-cursor.jpg")
    def initialize(turn)
        self.image = @@cursor_image
        @point = 0 # プレイヤーの点数
        @turn = turn # 先手の場合、1。後手の場合、0。
    end

    def update
        self.x = Input.mouse_pos_x  # マウスカーソルのx座標
        self.y = Input.mouse_pos_y  # マウスカーソルのy座標
    end
end