initializeInputs = (player) ->
  chatbar = document.getElementById 'chat_bar'
  input_lock = false
  document.addEventListener 'keydown', (e) ->
    return if e.target is chatbar or
      input_lock                  or
      [87, 65, 83, 68].indexOf(e.keyCode) is -1
    
    input_lock = true
    
    switch e.keyCode
      when 87 then player.up()
      when 65 then player.left()
      when 83 then player.down()
      when 68 then player.right()
  
  document.addEventListener 'keyup', (e) ->
    return if e.target is chatbar or not input_lock
    input_lock = false
    player.stop()

window.initializeInputs = initializeInputs