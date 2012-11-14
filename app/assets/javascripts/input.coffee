initializeInputs = (player, comms) ->
  chatbar = document.getElementById 'chat_bar'
  input_lock = false
  beginMoving = (direction) ->
    input_lock = true
    player[direction]()
    comms.moving player, direction
  document.addEventListener 'keydown', (e) ->
    return if e.target is chatbar or input_lock
    
    switch e.keyCode
      when 87 then beginMoving 'up'
      when 65 then beginMoving 'left'
      when 83 then beginMoving 'down'
      when 68 then beginMoving 'right'
  
  document.addEventListener 'keyup', (e) ->
    return unless input_lock
    input_lock = false
    player.stop()
    comms.stopped player

window.initializeInputs = initializeInputs