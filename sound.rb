require 'dxruby'

sound = Sound.new("sound/othello_02.wav")  # sound.wav読み込み
bgm = Sound.new("sound/win.wav")  # bgm.mid読み込み

bgm.play

Window.loop do
  if Input.key_push?(K_Z) then  # Zキーで再生
    sound.play
  end
end