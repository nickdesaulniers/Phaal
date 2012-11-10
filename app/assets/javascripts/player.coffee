class Player
  constructor: (@id, left, top) ->
    #initialBehavior = moveDownBehavior
    initialBehavior = stillDownBehavior
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
    @sprite.behave stillDownBehavior
  do: (behaviors) ->
    @sprite.behave behaviors
  up: ->
    console.log 'up'
    @sprite.animating = true
    @sprite.translated = false
    #@do stillUpBehavior
    @sprite.velocityY *= -1
    @do moveUpBehavior
    @sprite.animating = false
  down: (player) ->
    console.log 'down'
    @sprite.animating = true
    @sprite.translated = false
    @do stillDownBehavior
    @sprite.animating = false
  left: (player) ->
    console.log 'left'
    @sprite.animating = true
    @sprite.translated = false
    @do stillLeftBehavior
    @sprite.animating = false
  right: (player) ->
    console.log 'right'
    @sprite.animating = true
    @sprite.translated = true
    @do stillLeftBehavior
    @sprite.animating = false

window.Player = Player