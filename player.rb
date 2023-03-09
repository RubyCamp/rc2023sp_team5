class Player < Sprite
    attr_accessor :point
    # 画像の読み込み
    @@heximage = Image.load('image/mousepoint.png')

    # 初期化
    def initialize(turn, mx=0,my=0,name="default")
        @mx = mx
        @my = my
        self.image = @@heximage
        self.collision = [1,1]
        @point = 0 # プレイヤーの点数
        @turn = turn # 先手の場合、1。後手の場合、0。
    end

    def update
        self.x = Input.mouse_x
        self.y = Input.mouse_y
    end
    
    def shot(hexagon)
        # puts "#{}"
    end

    
    # def syoutotucheck
    #     if @player === @hexagon && Input.mouse_push?(M_LBUTTON)
    #         Window.draw_font(500, 300, "衝突", font)
    #     end
    # end

end