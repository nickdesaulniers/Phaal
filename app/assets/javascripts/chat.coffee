class ChatEvent
  constructor: (msg) ->
    evt = document.createEvent 'Event'
    evt.initEvent 'chatEvent', true, true
    evt.message = msg.message
    evt.user = msg.user
    document.dispatchEvent evt

class Chat
  constructor: (msg, user) ->
    # <p><span class="current_user">user</span>msg</p>
    @p = document.createElement 'p'
    span = document.createElement 'span'
    span.appendChild document.createTextNode user
    @p.appendChild span
    @p.appendChild document.createTextNode ': ' + msg
  toElem: ->
    @p

class ChatQueue
  constructor: (@maxLength, @targetElem) ->
    @queue = []
  push: (chat) ->
    return unless chat instanceof Chat
    @queue.push chat
    @queue.shift() if @queue.length > @maxLength
    @targetElem.innerHTML = ''
    for chat in @queue
      @targetElem.appendChild chat.toElem()

$(document).ready ->
  chat_box = document.getElementById 'chat_box'
  chat_bar = document.getElementById 'chat_bar'
  username = document.getElementById('username').textContent.replace /@.+/, ''
  return unless chat_box && chat_bar && username

  location = (window.location + 'websocket').replace /^http/, 'ws'
  dispatcher = new WebSocketRails location
  queue = new ChatQueue 10, chat_box

  # send a chat to the server on Enter keypress
  chat_bar.addEventListener 'keyup', (e) ->
    # if user presses enter
    if e.keyCode is 13
      dispatcher.trigger 'client_chat', chat_bar.value
      chat_bar.value = ''

  # On receiving a chat trigger a chat event
  dispatcher.bind 'chatter', (msg) ->
    new ChatEvent msg

  # Listen for chat events
  document.addEventListener 'chatEvent', (e) ->
    queue.push new Chat e.message, e.user