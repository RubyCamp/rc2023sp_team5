if directions.empty?
          @can_play = false
        else
          @can_play = true
        end
          # 置きたいコマの周囲に相手の石がない場合、ターミナルに「置けないよ」と表示する
          if @can_play == false
          
          # puts "置けないよ" 
            #Window.draw_font(100, 400, "置けないよ", @font3, {:color => C_WHITE})
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
              @sound1.play
              # 盤面初期時に作成したインスタンス変数@random_numがターン数と一致した場合
              # if @random_num == @turn 
              # # 自分と相手の石を反転させる処理
              #   reverse_color
              # end
    
          # プレイヤーの点数を加点する
              
            end
          end