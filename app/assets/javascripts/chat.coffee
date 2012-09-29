username = null

class ChatEvent
  constructor: (msg) ->
    evt = document.createEvent 'Event'
    evt.initEvent 'chatEvent', true, true
    evt.message = msg.message
    evt.user = msg.user
    document.dispatchEvent evt

class Chat
  constructor: (msg, user) ->
    # <p><span class="user">user</span>msg</p>
    @p = document.createElement 'p'
    span = document.createElement 'span'
    span.setAttribute 'class',
    if user is username then 'current_user' else 'other_user'
    span.appendChild document.createTextNode user
    @p.appendChild span
    @p.appendChild document.createTextNode ': ' + msg 
  toElem: ->
    @p

$(document).ready ->
  chat_box = document.getElementById 'chat_box'
  chat_bar = document.getElementById 'chat_bar'
  username = document.getElementById('username').textContent.replace /@.+/, ''
  return unless chat_box && chat_bar && username

  location = (window.location + 'websocket').replace /^http/, 'ws'
  dispatcher = new WebSocketRails location

  # send a chat to the server on Enter keypress
  chat_bar.addEventListener 'keyup', (e) ->
    # if user presses enter
    if e.keyCode is 13
      dispatcher.trigger 'client_chat',
      chat_bar.value unless chat_bar.value.length is 0
      chat_bar.value = ''

  # On receiving a chat trigger a chat event
  dispatcher.bind 'chatter', (msg) ->
    new ChatEvent msg

  # Listen for chat events
  document.addEventListener 'chatEvent', (e) ->
    chat = new Chat e.message, e.user
    chat_box.insertBefore chat.toElem(), chat_box.firstChild