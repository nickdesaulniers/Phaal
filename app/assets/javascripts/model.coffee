class Model
  # movement in pixels per second
  constructor: (src, @x, @y, @speed) ->
    @_ready = false
    @_image = new Image()
    @_image.src = src
    @_image.onload = =>
      @_ready = true
      #document.body.appendChild @_image
  isReady: ->
    @_ready
  getImage: ->
    @_image

class Hero extends Model
  constructor: (x, y, speed) ->
    super 'assets/hero.png', x, y, speed

class Monster extends Model
  constructor: (x, y) ->
    super 'assets/monster.png', x, y

class World extends Model
  constructor: ->
    super 'assets/world.png'

#nick = new Model 'assets/rails.png'
#window.Model = Model
new Hero()

window.Hero = Hero
window.Monster = Monster
window.World = World
