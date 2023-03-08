class Player < Sprite
    heximage = Image.load('image/Hex50x58.png')
    def mousepos
        mx,my, = Input.mouse_x, Input.mouse_y
        Sprite.new( mx, my, image=)
        
    end
    

end