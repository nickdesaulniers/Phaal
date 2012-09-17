$(document).ready ->
  # Setup requestAnimationFrame
  requestAnimationFrame =
    window.requestAnimationFrame       or
    window.mozRequestAnimationFrame    or
    window.webkitRequestAnimationFrame or
    window.msRequestAnimationFrame

  # Create the canvas
  canvas = document.getElementById 'map'
  ctx = canvas.getContext '2d'

  # Set the first previous time measurement
  last = Date.now()

  # Include images
  # Background image
  bgReady = false
  bgImage = new Image()
  bgImage.onload = ->
    bgReady = true
  bgImage.src = 'assets/map.png'

  # Hero image
  heroReady = false
  heroImage = new Image()
  heroImage.onload = ->
    heroReady = true
  heroImage.src = 'assets/hero.png'

  # Monster image
  monsterReady = false
  monsterImage = new Image()
  monsterImage.onload = ->
    monsterReady = true
  monsterImage.src = 'assets/monster.png'

  # Game objects
  hero = {
    x:     canvas.width / 2,
    y:     canvas.height / 2,
    speed: 256 # movement in pixels per second
  }
  monster = {
    x: 0,
    y: 0
  }
  monstersCaught = 0

  # Handle keyboard controls
  keysDown = {}
  addEventListener 'keydown', (e) ->
    keysDown[e.keyCode] = true
  addEventListener 'keyup', (e) ->
    delete keysDown[e.keyCode]

  # Reset game when player catches a monster
  reset = ->
    #hero.x = canvas.width / 2
    #hero.y = canvas.height / 2

    # Throw the monster somewhere on the screen randomly
    monster.x = 32 + (Math.random() * (canvas.width - 64))
    monster.y = 32 + (Math.random() * (canvas.height - 64))

  # Update game objects
  update = (modifier) ->
    # Player holding up
    if keysDown[38]
      hero.y -= hero.speed * modifier
    # Player holding down
    if keysDown[40]
      hero.y += hero.speed * modifier
    # Player holding left
    if keysDown[37]
      hero.x -= hero.speed * modifier
    # Player holding right
    if keysDown[39]
      hero.x += hero.speed * modifier

    # Are they touching?
    if hero.x <= (monster.x + 32) and
    monster.x <= (hero.x    + 32) and
    hero.y    <= (monster.y + 32) and
    monster.y <= (hero.y    + 32)
      ++monstersCaught
      reset()

  # Draw everything
  render = ->
    if bgReady
      ctx.drawImage bgImage, 0, 0
    if heroReady
      ctx.drawImage heroImage, hero.x, hero.y
    if monsterReady
      ctx.drawImage monsterImage, monster.x, monster.y

    # Score
    ctx.fillStyle = 'rgb(250, 250, 250)'
    ctx.font = '24px Helvetica'
    ctx.textAlign = 'left'
    ctx.textBaseline = 'top'
    ctx.fillText 'Goblins caught: ' + monstersCaught, 32, 32

  # The main game loop
  main = ->
    now = Date.now()
    delta = now - last
    #alert "now #{now}, last #{last}"
    #alert "calling update with update of #{delta/1000}"
    update delta / 1000
    render()

    last = now
    requestAnimationFrame main

  # Phat beats
  document.getElementById('phat_beats').play()
  reset()
  main()
  