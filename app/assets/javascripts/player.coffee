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
    @sprite.velocityX = 0
    @sprite.velocityY = -50
    @do moveUpBehavior, true
  down: (player) ->
    console.log 'down'
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = 50
    @do moveDownBehavior, true
  left: (player) ->
    console.log 'left'
    @sprite.translated = false
    @sprite.velocityX = -50
    @sprite.velocityY = 0
    @do moveLeftBehavior, true
  right: (player) ->
    console.log 'right'
    @sprite.translated = true
    @sprite.velocityX = 50
    @sprite.velocityY = 0
    @do stillLeftBehavior

window.Player = Player