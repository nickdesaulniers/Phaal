class Input
  constructor: ->
    @_keysDown = {}
    nick = addEventListener 'keydown', (e) =>
      @_keysDown[e.keyCode] = true
    addEventListener 'keyup', (e) =>
      delete @_keysDown[e.keyCode]
  isPressed: (keyCode) ->
    !!@_keysDown[keyCode]

window.Input = Input
window.keyCodes = {
  left:  37,
  up:    38,
  right: 39,
  down:  40
}