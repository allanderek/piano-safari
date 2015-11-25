happy_birthday_score = '''3D w R 0 1
             3D w R 2 1
             2B w L 3 2
             3G w R 3 2
             4D w R 3 2
             2G w L 6 1
             3D w R 6 1
             3B w R 6 1
             1B w L 8 1
             3D w R 8 1
             3G w R 8 1
             2C w L 10 4
             3D w R 10 3
             3F b R 10 3
             3C w R 13 1
             3E w R 13 1
             1A w L 17 3
             3E w R 17 1
             4C w R 17 1
             3E w R 19 1
             4C w R 19 1
             2D w L 20 4
             3D w R 20 1
             3B w R 20 1
             2B w R 22 1
             3G w R 22 1
             1D w L 24 2
             3C w R 24 1
             3A w R 24 1
             1G w L 26 3
             2B w R 26 3
             3G w R 26 3

             3D w R 30 1
             3D w R 32 1

             1G w L 33 5
             2B w R 33 1
             3E w R 33 2

             2D w L 35 3
             2B w R 35 1
             3D w R 35 1

             2B w R 37 1
             3G w R 37 1

             1A w L 39 4
             2D w L 41 2
             3C w R 39 4
             3F b R 39 4

             3D w R 43 1
             3D w R 45 1

             2D w L 46 4
             3C w R 46 1
             3E w R 46 1
             2F b L 48 2
             3C w R 48 2
             3D w R 48 2

             3C w R 50 1
             3A w R 50 1

             1G w L 52 3
             2B w R 52 3
             3G w R 52 3

             2D w L 55 1

             3D w R 59 1
             3D w R 61 1

             2B w L 62 2
             3G w R 62 2
             4D w R 62 2

             2G w L 64 2
             3D w R 64 2
             3B w R 64 1

             1B w L 67 2
             3D w R 67 1
             3G w R 67 1

             2C w L 69 4
             3D w R 69 3
             3F b R 69 3
             3C w R 72 1
             3E w R 72 1

             1A w L 77 3
             3E w L 77 1
             4C w L 77 1
             3E w L 79 1
             4C w L 79 1

             2D w L 80 5
             3D w R 80 1
             3B w R 80 1
             2B w R 83 1
             3G w R 83 1

             1D w L 85 2
             3C w R 85 1
             3A w R 85 1

             1G w L 87 9
             2B w R 87 9
             3G w R 87 9
          '''

jurassic_park_score = '''
    3A b R 0 2
    3A w R 2 2
    3A b R 4 2
    2A b L 4 2
    
    2A b L 8 2
    
    3A b R 12 2
    3A w R 14 2
    3A b R 16 2
    2D b L 16 2
'''

bttf_score = '''
    2C w L 0 4
    3C w R 0 4
    2G w L 4 6
    3G w R 4 6
    3C w L 10 2
    4C w R 10 2
    2G w L 12 8
    3A b R 12 6
    3A w R 18 2
    3G w R 19 2
    3A w R 20 1
    2A b L 20 5
    3G w R 22 3
    3F w R 25 3
    
    3G w R 28 24
    2C w L 28 6
    2C w L 34 2
    2C w L 36 4
    2C w L 40 4
    2C w L 44 2
    2C w L 46 2
    2C w L 48 2
    2C w L 50 2
    
'''

songs = [['Happy Birthday', happy_birthday_score],
         ['Jurassic Park', jurassic_park_score],
         ['Back To The Future', bttf_score]]

loadSong = (song_index) ->
  # First clear all current notes
  $('.note').remove()
  # lane_elements = document.getElementsByClassName('tracklane')
  # for lane_element in lane_elements
  #   for note_element in lane_element.getElementsByClassName('note')
  #    lane_element.removeChild(note_element)
  for note_element in document.getElementsByClassName('note')
    note_element.parentNode.removeChild(note_element)
  [score_name, score] = songs[song_index]
  # This is how tall the score needs to be so the score needs to be as tall as
  # the highest note, that is the note with with a start+length larger than any
  # other.
  max_note_height = 0
  add_note = (scoreline) ->
    tokens = scoreline.split ' '
    if tokens.length < 5
      return
    [lanename, wb, hand, start, length] = tokens
    lanes = document.getElementsByClassName lanename
    lane = lanes[0]
    note = document.createElement 'div'
    lane.appendChild note
    note_class = if wb == 'w' then 'white-' else 'black-'
    hand_class = if hand == 'R' then 'right-hand-note' else 'left-hand-note'
    note.className = note_class + hand_class + " note"
    note.style = 'bottom:' + start + 'em; height:' + length + 'em;'
    notename = if wb == 'w' then lanename[1..] else lanename[1..] + '#'
    keyname = document.createElement 'div'
    note.appendChild keyname
    keyname.textContent = notename
    keyname.className = 'keyname'
    max_note_height = Math.max max_note_height, Number(start) + Number(length)
  for scoreline in score.split '\n'
    add_note scoreline
  score_element = document.getElementById 'score'
  score_element.style.height = max_note_height + 'em'
  return

window.onload = () ->
  select = document.getElementById 'song-selector'
  for [song_name, score] in songs
    option = document.createElement 'option'
    text_node = document.createTextNode song_name
    option.appendChild(text_node)
    select.appendChild option
  piano = document.getElementById 'piano'
  create_key = (keyname) ->
    li = document.createElement 'li'
    piano.appendChild li
    div = document.createElement 'div'
    li.appendChild div
    div.className = 'anchor'
    # text_node = document.createTextNode keyname
    # div.appendChild text_node
    if keyname not in ['c', 'f']
      span = document.createElement 'span'
      div.appendChild span
  create_octave = () ->
    for keyname in ['a', 'b', 'c', 'd', 'e', 'f', 'g']
      create_key keyname
    return
  loadSong(0)

timerId = null
stop_reading = (button) ->
  clearInterval timerId
  button.textContent = "Start"

toggleReading = () ->
  button = document.getElementById 'toggle-reading'
  if button.textContent == "Stop"
    stop_reading button
  else
    bpm_input = document.getElementById 'bpm-input'
    millieseconds = 1.0 / (bpm_input.value / 60000.0)
    timerId = setInterval run, millieseconds
    button.textContent = "Stop"

update = () ->
  score_con = document.getElementById 'score-container'
  score_con.scrollTop += 50
  # if result is false
  #  toggleReading()

run = () ->
  update()
