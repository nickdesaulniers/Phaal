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
    @tileDict =
      0: new Grass(),
      1: new Water(),
      2: new Dirt()
    @imageLoader = new ImageLoader()
    for key, tile of @tileDict
      @imageLoader.queueImage tile.image.src
  draw: (context) ->
    x = y = 0
    for row in @state
      x = 0
      for tile in row
        if @tileDict[tile].image.complete
          context.drawImage @tileDict[tile].image, x, y
        x += 50
      y += 50
    null

window.Board = Board
