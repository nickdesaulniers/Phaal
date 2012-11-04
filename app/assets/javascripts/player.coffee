class Player
  constructor: (@id, left, top) ->
    #initialBehavior = downBehavior
    initialBehavior = stillBehavior
    initialCells = initialBehavior[0].cells
    
    @sprite = new Sprite 'Player',
    new SpriteSheetPainter(initialCells),
    initialBehavior
    
    @sprite.left = left
    @sprite.top = top
  load: (asset, cb) ->
    @sprite.sheet.src = asset
    @sprite.sheet.onload = cb if typeof cb is 'function'
  update: (context, time) ->
    @sprite.update context, time
  paint: (context) ->
    @sprite.paint context
  reset: ->
    @sprite.behave stillBehavior
  do: (behaviors) ->
    @sprite.behave behaviors

window.Player = Player