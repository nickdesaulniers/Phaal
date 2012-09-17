class View
  constructor: (@_canvas, @_gameObjects...) ->
    for gameObject in @_gameObjects
      unless gameObject instanceof Model
        throw new Error 'View second argument must be a model'
    @_ctx = @_canvas.getContext '2d'
  render: (score = 0) ->
    for gameObject in @_gameObjects
       if gameObject.isReady()
         @_ctx.drawImage gameObject.getImage(), gameObject.x, gameObject.y
    @_ctx.fillStyle = 'rgb(250, 250, 250)'
    @_ctx.font = '24px Helvetica'
    @_ctx.textAlign = 'left'
    @_ctx.textBaseline = 'top'
    @_ctx.fillText "Goblins caught: #{score}", 32, 32         

window.View = View