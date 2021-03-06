# Animation cells for the sprites
class Cell
  constructor: (@left, @top) ->

class AnimationBehavior
  constructor: (@cells, @pageFlipInterval) ->
  lastAdvance: 0
  execute: (sprite, context, now) ->
    if now - @lastAdvance > @pageFlipInterval
      sprite.painter.advance()
      @lastAdvance = now

class MovementBehavior
  lastAdvance: 0
  execute: (sprite, context, time) ->
    if @lastAdvance isnt 0
      sprite.top  += sprite.velocityY * ((time - @lastAdvance) / 1000)
      sprite.left += sprite.velocityX * ((time - @lastAdvance) / 1000)
      # move sprite to top if it reaches the bottom, don't keep this
      if sprite.top + sprite.height > context.canvas.height
        sprite.top = 0
      if sprite.top < 0
        sprite.top = context.canvas.height - sprite.height
      if sprite.left + sprite.width > context.canvas.width
        sprite.left = 0
      if sprite.left < 0
        sprite.left = context.canvas.width - sprite.width
    @lastAdvance = time

# Still - Down
stillDownCells = [
  new Cell 0,   0
  new Cell 27,  0
  new Cell 55,  0
  new Cell 84,  0
  new Cell 111, 0
  new Cell 139, 0]
animateStillDown = ->
  new AnimationBehavior stillDownCells, 1000 / stillDownCells.length

# Still - Up
stillUpCells = [
  new Cell 1,   192
  new Cell 29,  192
  new Cell 56,  192
  new Cell 83,  192
  new Cell 111, 192
  new Cell 138, 192]
animateStillUp = ->
  new AnimationBehavior stillUpCells, 1000 / stillUpCells.length

# Still - Left
stillLeftCells = [
  new Cell 0,   98
  new Cell 26,  98
  new Cell 53,  98
  new Cell 79,  98
  new Cell 105, 98
  new Cell 132, 98]
animateStillLeft = ->
  new AnimationBehavior stillLeftCells, 1000 / stillLeftCells.length

# Still - Right
# still left but need to set sprite.translated = true, kinda sucks

# Move - Down
moveDownCells = [
  new Cell 184, 0
  new Cell 210, 0
  new Cell 237, 0
  new Cell 263, 0
  new Cell 289, 0
  new Cell 316, 0]
animateMoveDown = ->
  new AnimationBehavior moveDownCells, 1000 / moveDownCells.length

# Move - Up
moveUpCells = [
  new Cell 184, 192
  new Cell 210, 192
  new Cell 237, 192
  new Cell 262, 192
  new Cell 287, 192
  new Cell 314, 192]
animateMoveUp = ->
  new AnimationBehavior moveUpCells, 1000 / moveUpCells.length

# Move - Left
moveLeftCells = [
  new Cell 186, 96
  new Cell 211, 96
  new Cell 235, 96
  new Cell 259, 96
  new Cell 284, 96
  new Cell 308, 96]
animateMoveLeft = ->
  new AnimationBehavior moveLeftCells, 1000 / moveUpCells.length

# Move - Right
# move left but need to set sprite.translated = true, kinda sucks
  
class Player
  constructor: (@user_name, left, top) ->
    initialBehavior = [animateStillDown()]
    initialCells = initialBehavior[0].cells
    
    @sprite = new Sprite @user_name,
    new SpriteSheetPainter(initialCells),
    initialBehavior
    
    @sprite.left = left
    @sprite.top = top
    @stopBehavior = [animateStillDown()]
  load: (asset, cb) ->
    @sprite.sheet.src = asset
    @sprite.sheet.onload = cb if typeof cb is 'function'
  update: (context, time) ->
    @sprite.update context, time
  paint: (context) ->
    @sprite.paint context
  stop: ->
    @sprite.behave @stopBehavior
  do: (behaviors, move) ->
    if move
      @sprite.behave [behaviors, new MovementBehavior()]
    else
      @sprite.behave [behaviors]
  up: ->
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = -50
    @stopBehavior = [animateStillUp()]
    @do animateMoveUp(), true
  down: (player) ->
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = 50
    @stopBehavior = [animateStillDown()]
    @do animateMoveDown(), true
  left: (player) ->
    @sprite.translated = false
    @sprite.velocityX = -50
    @sprite.velocityY = 0
    @stopBehavior = [animateStillLeft()]
    @do animateMoveLeft(), true
  right: (player) ->
    @sprite.translated = true
    @sprite.velocityX = 50
    @sprite.velocityY = 0
    @stopBehavior = [animateStillLeft()]
    @do animateMoveLeft(), true

window.Player = Player