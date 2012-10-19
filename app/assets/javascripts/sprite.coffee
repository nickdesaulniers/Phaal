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
    @
  paint: (context) ->
    @painter.paint @, context if @painter?
  update: (context, time) ->
    for i in [0..@behaviors.length]
      @behaviors[i].execute @, context, time

window.Sprite = Sprite