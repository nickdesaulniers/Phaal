class Sprite
  constructor: (@name, @painter, @behaviors = []) ->
    @top = 0
    @left = 0
    @width = 25
    @height = 50
    @velocityX = 0
    @velocityY = 50 # pixels / second
    @visible = true
    @animating = false
    @sheet = new Image()
  paint: (context) ->
    @painter.paint @, context if @painter?
  update: (context, time) ->
    for i in [0...@behaviors.length]
      @behaviors[i].execute @, context, time
  behave: (behaviors) ->
    @behaviors = behaviors
    @painter.cells = behaviors[0].cells if behaviors[0].cells

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
    context.drawImage sprite.sheet, cell.left, cell.top, cell.width,
    cell.height, sprite.left, sprite.top, cell.width, cell.height

window.Sprite = Sprite
window.SpriteSheetPainter = SpriteSheetPainter
