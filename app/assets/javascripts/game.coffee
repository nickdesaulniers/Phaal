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
    window.spritesheet = new Image()
    runnerCells = [
      { left: 0,   top: 0, width: 47, height: 64 },
      { left: 55,  top: 0, width: 44, height: 64 },
      { left: 107, top: 0, width: 39, height: 64 },
      { left: 150, top: 0, width: 46, height: 64 },
      { left: 208, top: 0, width: 49, height: 64 },
      { left: 265, top: 0, width: 46, height: 64 },
      { left: 320, top: 0, width: 42, height: 64 },
      { left: 380, top: 0, width: 35, height: 64 },
      { left: 425, top: 0, width: 35, height: 64 },
    ]
    sprite = new Sprite 'runner', new SpriteSheetPainter runnerCells
    lastAdvance = 0
    pageFlipInterval = 100
    
    animate = (time) ->
      context.clearRect 0, 0, canvas.width, canvas.height
      board.draw context
      sprite.paint context
      if time - lastAdvance > pageFlipInterval
        sprite.painter.advance()
        lastAdvance = time
      requestAnimationFrame animate
    
    #init
    sprite.left = 200
    sprite.top = 100
    spritesheet.src = 'assets/running-sprite-sheet.png'
    spritesheet.onload = ->
      lastAdvance = Date.now()
      requestAnimationFrame animate
      
      
      