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
  # Dummy test code
  runnerCells = [
    new Cell(184, 0, 25, 50)
    new Cell(210, 0, 25, 50)
    new Cell(237, 0, 25, 50)
    new Cell(263, 0, 25, 50)
    new Cell(289, 0, 25, 50)
  ]
  runDown = new AnimationBehavior(runnerCells, 1000 / runnerCells.length)
  moveDown = new MovementBehavior()

  sprite = new Sprite 'runner',
  new SpriteSheetPainter(runnerCells),
  [runDown, moveDown]
  
  animate = (time) ->
    board.draw context
    sprite.update context, time
    sprite.paint context
    requestAnimationFrame animate
  
  #init
  sprite.left = canvas.width / 2 - sprite.width / 2
  sprite.top = 100
  sprite.sheet.src = 'assets/lock.png'
  sprite.sheet.onload = ->
    requestAnimationFrame animate
