class Player
  constructor: (@id, left, top) ->
    #initialBehavior = moveDownBehavior
    initialBehavior = [stillDownBehavior]
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
    @sprite.behave [stillDownBehavior]
  do: (behaviors, move) ->
    if move
      @sprite.behave [behaviors, new MovementBehavior()]
    else
      @sprite.behave [behaviors]
  up: ->
    console.log 'up'
    @sprite.translated = false
    @sprite.velocityY = -50
    @do moveUpBehavior, true
  down: (player) ->
    console.log 'down'
    @sprite.translated = false
    @sprite.velocityY = 50
    @do moveDownBehavior, true
  left: (player) ->
    console.log 'left'
    @sprite.translated = false
    @do stillLeftBehavior
  right: (player) ->
    console.log 'right'
    @sprite.translated = true
    @do stillLeftBehavior

window.Player = Player