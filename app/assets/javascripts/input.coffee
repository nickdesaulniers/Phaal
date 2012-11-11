initializeInputs = (player) ->
  chatbar = document.getElementById 'chat_bar'
  document.addEventListener 'keyup', (e) ->
    return if e.target is chatbar or
      #player.sprite.animating     or
      [87, 65, 83, 68].indexOf(e.keyCode) is -1
    
    switch e.keyCode
      when 87 then player.up()
      when 65 then player.left()
      when 83 then player.down()
      when 68 then player.right()

window.initializeInputs = initializeInputs