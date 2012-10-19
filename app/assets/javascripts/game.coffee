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
  