username = null

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

initializeChat = (comm) ->
  chat_box = document.getElementById 'chat_box'
  chat_bar = document.getElementById 'chat_bar'
  username = document.getElementById('username').textContent.replace /@.+/, ''
  return unless chat_box && chat_bar && username

  # send a chat to the server on Enter keypress
  chat_bar.addEventListener 'keyup', (e) ->
    # if user presses enter
    if e.keyCode is 13 and chat_bar.value.length isnt 0
      comm.sendClientChat chat_bar.value
      chat_bar.value = ''

  # Listen for chat events
  document.addEventListener 'chatEvent', (e) ->
    chat = new Chat e.message, e.user
    chat_box.insertBefore chat.toElem(), chat_box.firstChild

window.initializeChat = initializeChat