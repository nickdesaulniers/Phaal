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

window.Cell = Cell
window.AnimationBehavior = AnimationBehavior
window.MovementBehavior = MovementBehavior