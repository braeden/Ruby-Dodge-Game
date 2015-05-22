# Ruby-Dodge-Game
Game built using the Ruby Ray gem

#To Do
- Add score to @game_over render
- Get rid of cheat by going to the bottom of the screen
- Add specials like time_slow (commented out [not working])
- Fix pause function
- Get quit to not display errors on the teminal
- Alternate to generating random numbers for spawn
- Change the spawn, so there is a start screen, then generate obstacles closer to edge of screen
  - This will let it run better on low specs and not lag  
- Hide cursor on screen http://www.rubydoc.info/gems/ray/Ray/Window:hide_cursor
- Log score with CSV gem and display highscores
- As level increases, also slowly increase the amount of obstacles spawned (`if rand(5 - @increase_amount_here) == 1`)
