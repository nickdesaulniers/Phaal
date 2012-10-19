class Sprite
  constructor: (@name, @painter, @behaviors = []) ->
    @top = 0
    @left = 0
    @width = 10
    @height = 10
    @velocityX = 0
    @velocityY = 0
    @visible = true
    @animating = false
  paint: (context) ->
    @painter.paint @, context if @painter?
  update: (context, time) ->
    #console.log @behaviors
    for i in [0...@behaviors.length]
      @behaviors[i].execute @, context, time

class SpriteSheetPainter
  constructor: (@cells = []) ->
    @cellIndex = 0
  advance: ->
    if @cellIndex is @cells.length - 1
      @cellIndex = 0
    else
      @cellIndex++
  paint: (sprite, context) ->
    cell = @cells[@cellIndex]
    context.drawImage spritesheet, cell.left, cell.top, cell.width, cell.height,
    sprite.left, sprite.top, cell.width, cell.height

class SpriteAnimator
  constructor: (@painters = [], @elapsedCB) ->
    @duration = 1000
    @startTime = 0
    @index = 0
  end: (sprite, originalPainter) ->
    sprite.animating = false
    if @elapsedCallback
      @elapsedCallback sprite
    else 
      sprite.painter = originalPainter
  start: (sprite, duration) ->
    endTime = Date.now() + duration
    period = duration / @painters.length
    originalPainter = sprite.painter
    @index = 0
    sprite.animating = true
    sprite.painter = @painters[@index]
    interval = setInterval =>
      if Date.now() < endTime
        sprite.painter = @painters[++@index]
      else
        @end sprite, originalPainter
        clearInterval interval
    , period
  
window.Sprite = Sprite
window.SpriteSheetPainter = SpriteSheetPainter
#window.SpriteAnimator = SpriteAnimator
