# Down
downCells = [
  new Cell(184, 0, 25, 50)
  new Cell(210, 0, 25, 50)
  new Cell(237, 0, 25, 50)
  new Cell(263, 0, 25, 50)
  new Cell(289, 0, 25, 50)]
animateDown = new AnimationBehavior downCells, 1000 / downCells.length
moveDown = new MovementBehavior()

class Player
  constructor: (@id, left, top) ->
    proto = @constructor.prototype
    
    @sprite = new Sprite 'Player',
    new SpriteSheetPainter(downCells),
    [animateDown, moveDown]
    
    @sprite.left = left
    @sprite.top = top
  load: (asset, cb) ->
    @sprite.sheet.src = asset
    @sprite.sheet.onload = cb if typeof cb is 'function'
  update: (context, time) ->
    @sprite.update context, time
  paint: (context) ->
    @sprite.paint context

window.Player = Player