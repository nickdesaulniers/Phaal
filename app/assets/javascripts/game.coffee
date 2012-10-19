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
      { left: 184, top: 0, width: 25, height: 50 },
      { left: 210, top: 0, width: 25, height: 50 },
      { left: 237, top: 0, width: 25, height: 50 },
      { left: 263, top: 0, width: 25, height: 50 },
      { left: 289, top: 0, width: 25, height: 50 },
    ]
    runDown =
      lastAdvance: 0,
      pageFlipInterval: 1000 / runnerCells.length,
      execute: (sprite, context, now) ->
        if now - @lastAdvance > @pageFlipInterval
          sprite.painter.advance()
          @lastAdvance = now
    moveDown =
      lastMove: 0,
      execute: (sprite, context, time) ->
        #console.log sprite.top
        if @lastMove isnt 0
          #console.log sprite.top
          sprite.top += sprite.velocityY * ((time - @lastMove) / 1000)
          if sprite.top + sprite.height > context.canvas.height
            sprite.top = 0
        @lastMove = time
    sprite = new Sprite 'runner',
    new SpriteSheetPainter(runnerCells),
    [runDown, moveDown]
    
    animate = (time) ->
      context.clearRect 0, 0, canvas.width, canvas.height
      board.draw context
      sprite.update context, time
      sprite.paint context
      requestAnimationFrame animate
    
    #init
    sprite.left = 200
    sprite.top = 100
    spritesheet.src = 'assets/lock.png'
    spritesheet.onload = ->
      lastAdvance = Date.now()
      requestAnimationFrame animate
      
      
      