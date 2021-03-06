class Sprite
  constructor: (@user_name, @painter, @behaviors = []) ->
    @top = 0
    @left = 0
    @width = 25
    @height = 50
    @velocityX = 0 # pixels / second
    @velocityY = 0 # pixels / second
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
    
    # check if we need to flip image (special case for right movement)
    if sprite.translated
      context.save()
      context.translate context.canvas.width, 0
      context.scale -1, 1
      context.drawImage sprite.sheet,
      cell.left, cell.top, sprite.width, sprite.height,
      context.canvas.width - sprite.left - sprite.width, sprite.top,
      sprite.width, sprite.height
      context.restore()
    else
      # Assumes cells are all the same width and height, set in sprite
      context.drawImage sprite.sheet, cell.left, cell.top, sprite.width,
      sprite.height, sprite.left, sprite.top, sprite.width, sprite.height
    
    # Draw username
    context.strokeText sprite.user_name, sprite.left + 12, sprite.top - 10
    context.fillText   sprite.user_name, sprite.left + 12, sprite.top - 10

window.Sprite = Sprite
window.SpriteSheetPainter = SpriteSheetPainter
