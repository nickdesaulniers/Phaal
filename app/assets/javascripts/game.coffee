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
  board = new Board tileMap, context, ->
    # Dummy test code
    radius = 75
    ball = new Sprite 'ball', {
      paint: (sprite, context) ->
        context.beginPath()
        context.arc sprite.left + sprite.width / 2,
        sprite.top + sprite.height / 2,
        radius, 0, Math.PI * 2, false
        context.clip()
        context.shadowColor = 'rgb(0,0,0)'
        context.shadowOffsetX = -4
        context.shadowOffsetY = -4
        context.shadowBlur = 8
        context.lineWidth = 2
        context.strokeStyle = 'rgb(100, 100, 195)'
        context.fillStyle = 'rgba(30, 144, 255, 0.15)'
        context.fill()
        context.stroke()
    }
    ball.left = 320
    ball.top = 160
    ball.paint context
  