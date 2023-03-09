require 'dxruby'

image = Image.load('image/mouse-cursor.jpg')  # data.pngを読み込む

Window.loop do
  x = Input.mouse_pos_x  # マウスカーソルのx座標
  y = Input.mouse_pos_y  # マウスカーソルのy座標

  Window.draw(x, y, image)  # data.pngを描画する
end