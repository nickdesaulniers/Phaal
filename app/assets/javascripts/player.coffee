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
    @stopBehavior = [stillDownBehavior]
  load: (asset, cb) ->
    @sprite.sheet.src = asset
    @sprite.sheet.onload = cb if typeof cb is 'function'
  update: (context, time) ->
    @sprite.update context, time
  paint: (context) ->
    @sprite.paint context
  stop: ->
    @sprite.animating = false
    @sprite.behave @stopBehavior
  do: (behaviors, move) ->
    if move
      @sprite.behave [behaviors, new MovementBehavior()]
    else
      @sprite.behave [behaviors]
  up: ->
    console.log 'up'
    @sprite.animating = true
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = -50
    @stopBehavior = [stillUpBehavior]
    @do moveUpBehavior, true
  down: (player) ->
    console.log 'down'
    @sprite.animating = true
    @sprite.translated = false
    @sprite.velocityX = 0
    @sprite.velocityY = 50
    @stopBehavior = [stillDownBehavior]
    @do moveDownBehavior, true
  left: (player) ->
    console.log 'left'
    @sprite.animating = true
    @sprite.translated = false
    @sprite.velocityX = -50
    @sprite.velocityY = 0
    @stopBehavior = [stillLeftBehavior]
    @do moveLeftBehavior, true
  right: (player) ->
    console.log 'right'
    @sprite.animating = true
    @sprite.translated = true
    @sprite.velocityX = 50
    @sprite.velocityY = 0
    @stopBehavior = [stillLeftBehavior]
    @do moveLeftBehavior, true

window.Player = Player