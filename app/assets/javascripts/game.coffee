$(document).ready ->
  # Setup requestAnimationFrame
  requestAnimationFrame =
    window.requestAnimationFrame       or
    window.mozRequestAnimationFrame    or
    window.webkitRequestAnimationFrame or
    window.msRequestAnimationFrame

  # Create the canvas
  canvas = document.getElementById 'map'

  # Set the first previous time measurement
  last = Date.now()

  # Game objects
  world = new World()
  hero = new Hero canvas.width / 2, canvas.height / 2, 256
  monster = new Monster 0, 0
  monstersCaught = 0

  # Create the View
  view = new View canvas, world, hero, monster
  
  # Create the Input handler to handle keyboard controls
  input = new Input()

  # Reset game when player catches a monster
  reset = ->
    # Throw the monster somewhere on the screen randomly
    monster.x = 32 + Math.floor Math.random() * (canvas.width - 64)
    monster.y = 32 + Math.floor Math.random() * (canvas.height - 64)
    #console.log "Monster x: #{monster.x}, y: #{monster.y}"

  # Update game objects
  update = (modifier) ->
    nextStep = hero.speed * modifier
    # Player holding up
    if input.isPressed(keyCodes.up) and hero.y - nextStep > 32
      hero.y -= nextStep
    # Player holding down
    if input.isPressed(keyCodes.down) and hero.y + nextStep < canvas.height - 64
      hero.y += nextStep
    # Player holding left
    if input.isPressed(keyCodes.left) and hero.x - nextStep > 32
      hero.x -= nextStep
    # Player holding right
    if input.isPressed(keyCodes.right) and hero.x + nextStep < canvas.width - 64
      hero.x += nextStep

    # Are they touching?
    if hero.x <= (monster.x + 32) and
    monster.x <= (hero.x    + 32) and
    hero.y    <= (monster.y + 32) and
    monster.y <= (hero.y    + 32)
      ++monstersCaught
      reset()

  # The main game loop
  main = ->
    now = Date.now()
    delta = now - last

    update delta / 1000
    view.render monstersCaught

    last = now
    requestAnimationFrame main

  # Phat beats
  #document.getElementById('phat_beats').play()
  reset()
  main()
