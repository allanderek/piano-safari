window.onload = () ->
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
  score = '''3D w R 0 1
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
    note.className = note_class + hand_class
    note.style = 'bottom:' + start + 'em; height:' + length + 'em;'
    notename = if wb == 'w' then lanename[1..] else lanename[1..] + '#'
    keyname = document.createElement 'div'
    note.appendChild keyname
    keyname.textContent = notename
    keyname.className = 'keyname'
    max_note_height = Math.max max_note_height, Number(start) + Number(length)
  for scoreline in score.split '\n'
    add_note scoreline
  score = document.getElementById 'score'
  score.style.height = max_note_height + 'em'
  return


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
