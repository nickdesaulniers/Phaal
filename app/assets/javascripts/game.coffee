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
  
  animate = (time) ->
    board.draw context
    player.update context, time
    player.paint context
    requestAnimationFrame animate
  
  #init
  player = new Player 'id7', canvas.width / 2 - 25 / 2, 100
  player.load 'assets/lock.png', ->
    requestAnimationFrame animate

  setTimeout ->
    player.do downBehavior
    setTimeout ->
      player.reset()
    , 2000
  , 3000