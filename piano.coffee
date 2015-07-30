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

             2D w L 35 2
             2B w R 35 1
             3D w R 35 1
          '''
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
  for scoreline in score.split '\n'
    add_note scoreline
  return
