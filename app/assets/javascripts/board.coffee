class Tile
  constructor: (src) ->
    @image = new Image()
    @image.src = src
    @width = 50

class Grass extends Tile
  constructor: -> super 'assets/grass.png'

class Water extends Tile
  constructor: -> super 'assets/water.png'

class Dirt extends Tile
  constructor: -> super 'assets/dirt.png'

class Board
  # Here, I'm using a technique called 'blitting' to draw the canvas once
  # offscreen, then copy that canvas when the background is redrawn.  By keeping
  # an extra canvas in memory, the redraws of the background will be much
  # faster.
  constructor: (@state, onScreenContext) ->
    offScreenCanvas = document.createElement 'canvas'
    offScreenCanvas.width = onScreenContext.canvas.width
    offScreenCanvas.height = onScreenContext.canvas.height
    @offScreenContext = offScreenCanvas.getContext '2d'
    @tileDict =
      0: new Grass(),
      1: new Water(),
      2: new Dirt()
    @imageLoader = new ImageLoader()
    for key, tile of @tileDict
      @imageLoader.queueImage tile.image.src
    interval = setInterval (e) =>
      loadingPercentComplete = @imageLoader.loadImages()
      if loadingPercentComplete is 100
        clearInterval interval
        console.log 'Done!'
        x = y = 0
        for row in @state
          x = 0
          for tile in row
            if @tileDict[tile].image.complete
              @offScreenContext.drawImage @tileDict[tile].image, x, y
            x += 50
          y += 50
        @draw onScreenContext
      console.log "loaded #{loadingPercentComplete}%"
    , 16
  draw: (context) ->
    context.clearRect 0, 0, context.canvas.width, context.canvas.height
    context.drawImage @offScreenContext.canvas, 0, 0

window.Board = Board
