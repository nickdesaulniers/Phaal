# Animation cells for the sprites
class Cell
  constructor: (@left, @top, @width, @height) ->

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
      sprite.top += sprite.velocityY * ((time - @lastAdvance) / 1000)
      # move sprite to top if it reaches the bottom, don't keep this
      if sprite.top + sprite.height > context.canvas.height
        sprite.top = 0
    @lastAdvance = time

# Behaviors

# Still
stillCells = [
  new Cell 0,   0, 25, 50
  new Cell 27,  0, 25, 50
  new Cell 55,  0, 25, 50
  new Cell 84,  0, 25, 50
  new Cell 111, 0, 25, 50
  new Cell 139, 0, 25, 50]
animateStill = new AnimationBehavior stillCells, 1000 / stillCells.length

# Down
downCells = [
  new Cell 184, 0, 25, 50
  new Cell 210, 0, 25, 50
  new Cell 237, 0, 25, 50
  new Cell 263, 0, 25, 50
  new Cell 289, 0, 25, 50
  new Cell 316, 0, 25, 50]
animateDown = new AnimationBehavior downCells, 1000 / downCells.length
moveDown = new MovementBehavior()

window.stillBehavior = [animateStill]
window.downBehavior = [animateDown, moveDown]