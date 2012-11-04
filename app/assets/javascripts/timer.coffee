class StopWatch
  startTime: 0
  running: false
  elapsed: null
  start: ->
    @startTime = Date.now()
    @elapsed = null
    @running = true
  stop: ->
    @elapsed = Date.now() - @startTime
    @running = false
  getElapsedTime: ->
    if @running then Date.now() - @startTime else this.elapsed
  reset: ->
    @elapsed = 0

class AnimationTimer
  constructor: (@duration) ->
  stopWatch: new Stopwatch()
  start: ->
    @stopWatch.start()
  stop: ->
    @stopWatch.stop()
  getElapsedTime: ->
    elapsedTime = @stopWatch.getElapsedTime()
    if @stopWatch.running then @elapsedTime else null
  isRunning: ->
    @stopWatch.running
  isOver: ->
    @stopWatch.getElapsedTime > @duration

window.AnimationTimer = AnimationTimer