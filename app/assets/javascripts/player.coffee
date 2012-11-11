class Player
  constructor: (@id, left, top) ->
    initialBehavior = [stillDownBehavior]
    initialCells = initialBehavior[0].cells
    
    @sprite = new Sprite 'Player',
    new SpriteSheetPainter(initialCells),
    initialBehavior
    
    @sprite.left = left
    @sprite.top = top
    @stopBehavior = [stillDownBehavior]
  load: (asset, cb) ->
    @sprite.sheet.src = asset
    @sprite.sheet.onload = cb if typeof cb is 'function'
  update: (context, time) ->
    @sprite.update context, time
  paint: (context) ->
    @sprite.paint context
  stop: ->
    @sprite.behave @stopBehavior
  do: (behaviors, move) ->
    if move
      @sprite.behave [behaviors, new MovementBehavior()]
    else
      @sprite.behave [behaviors]
  up: ->
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = -50
    @stopBehavior = [stillUpBehavior]
    @do moveUpBehavior, true
  down: (player) ->
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = 50
    @stopBehavior = [stillDownBehavior]
    @do moveDownBehavior, true
  left: (player) ->
    @sprite.translated = false
    @sprite.velocityX = -50
    @sprite.velocityY = 0
    @stopBehavior = [stillLeftBehavior]
    @do moveLeftBehavior, true
  right: (player) ->
    @sprite.translated = true
    @sprite.velocityX = 50
    @sprite.velocityY = 0
    @stopBehavior = [stillLeftBehavior]
    @do moveLeftBehavior, true

window.Player = Player