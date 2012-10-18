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
  constructor: (@state) ->
    canvas = document.createElement 'canvas'
    @ctx = canvas.getContext '2d'
    @tileDict =
      0: new Grass(),
      1: new Water(),
      2: new Dirt()
  draw: (context) ->
    x = y = 0
    for row in @state
      x = 0
      for tile in row
        #console.log "board state #{tile}, #{@tileDict[tile].image.complete}"
        if @tileDict[tile].image.complete
          context.drawImage @tileDict[tile].image, x, y
          console.log "drawing to #{x}, #{y}"
        x += 50
      y += 50
    null

# Queue up background images
imageLoader = new window.ImageLoader()
imageLoader.queueImage 'assets/grass.png'
imageLoader.queueImage 'assets/water.png'
imageLoader.queueImage 'assets/dirt.png'

tileMap = [
  [1, 1, 2, 2, 0, 0, 0, 0, 2, 0, 0],
  [1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0],
  [1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [2, 2, 0, 0, 2, 2, 2, 2, 0, 0, 0],
  [0, 0, 0, 0, 2, 1, 1, 2, 0, 0, 0],
  [0, 0, 0, 0, 2, 1, 1, 2, 0, 0, 0],
  [0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0],
  [2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]

board = new Board tileMap
$(document).ready ->
  context = document.getElementById('map').getContext '2d'
  # Load them up
  interval = setInterval (e) ->
    loadingPercentComplete = imageLoader.loadImages()
    if loadingPercentComplete is 100
      clearInterval interval
      console.log 'Done!'
      board.draw context
    console.log "loaded #{loadingPercentComplete}%"
  , 16
