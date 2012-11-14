$(document).ready ->
  # Setup requestAnimationFrame
  requestAnimationFrame =
    window.requestAnimationFrame       or
    window.mozRequestAnimationFrame    or
    window.webkitRequestAnimationFrame or
    window.msRequestAnimationFrame

  # Create the canvas
  canvas = document.getElementById 'map'
  return unless canvas
  context = canvas.getContext '2d'
  
  context.font = 'italic 12px Open Sans'
  context.fillStyle = 'white'
  context.strokeStyle = 'rgba(100, 100, 100, 0.5)'
  context.lineWidth = 4
  context.textAlign = 'center'

  tileMap = [
    [1, 1, 2, 2, 0, 0, 0, 0, 2],
    [1, 2, 2, 0, 0, 0, 0, 0, 0],
    [1, 2, 0, 0, 0, 0, 0, 0, 0],
    [2, 2, 0, 0, 2, 2, 2, 2, 0],
    [0, 0, 0, 0, 2, 1, 1, 2, 0],
    [0, 0, 0, 0, 2, 1, 1, 2, 0],
    [0, 0, 0, 0, 2, 2, 2, 2, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 2],
    [2, 2, 0, 0, 0, 0, 0, 0, 0]
  ]
  board = new Board tileMap, context
  player_list = {}
  animate = (time) ->
    board.draw context
    for id, player of player_list
      player.update context, time
    for id, player of player_list
      player.paint context
    requestAnimationFrame animate

  username = document.getElementById('username').textContent.replace /@.+/, ''
  comms = new Comms player_list, (coords) ->
    # coords = [left, top, id, direction]
    player = new Player username, coords[0], coords[1]
    player.load 'assets/lock.png', ->
      player_list[coords[2]] = player
      player[coords[3]]()
      player.stop()
      requestAnimationFrame animate
    initializeInputs player, comms
  initializeChat comms
