# Work Log

## Zameen Cater

### 22 May 2023

- created repository
- created branch 'zammers'
- tested branch by modifying WORKLOG.md

### 23 May 2023
- created minimal game scene (pool table and cue ball)

### 24 May 2023
- implemented basic PoolTable methods
- implemented Hole class

### 25 May 2023
- continued work on Hole class
- added friendlier Ball constructor
- fixed Ball color code

### 26 May 2023
- worked on cue stick and striking the ball
- added detection for the ball being off the table
- abstracted PoolTable

### 28 May 2023
- implemented elliptical tables
- wrote ball collision code
- improved Ball code overall

## Erica Liu

### 22 May 2023

- testing out working on WORKLOG.md at the same time as Zameen

### 30 May 2023

(away in Kentucky from 5/25 - 5/29)
- trying to fix Cuestick/CueStick renaming issues
- not able to, so I did coding on a Google Doc and would transfer it onto GitHub later
- added render() to Obstacle
- added methods into Sand and Ice (Water needs to renamed to Ice)
- made changes to Game to start a makeObstacles() method

### 31 May 2023

- added balls able to be pocketed, but it doesn't account for the CueBall being pocketed yet,
and the ball disappears instantly since it doesn't get re-rendered
- made CueBall respawn, but it may respawn in a spot with a ball there already,
and the CueBall should go back to the break position if it got pocketed first move
- started the UI, which keeps track of how many balls each player has left
(made rectangles and labels)
- added the balls remaining for each character to the UI
- assigned solid or striped to each player based on the first ball pocketed
- added win screen based on 8ball being pocketed
- changed the green ball to green (it wasn't green before)
- SOME BUGS TO FIX + THINGS TO IMPLEMENT: cueball gets buggy after being pocketed, cueball should be moveable after being pocketed, or at least shouldn't respawn in a place where there are already balls,
need alternating players, should have UI messages appear but that comes after alternating
players are implemented, ball should shrink and disappear into hole

### 1 Jun 2023

- cueball now respawns at break point if it was pocketed before breaking
- ui is recreated when x or c is pressed

### 2 Jun 2023

- fixed merge conflict

### 4 Jun 2023

- merged blob table new code onto erica branch
- added instruction to regenerate blob table
- added in Sand and Ice Obstacles, changed up some constructors in the process
- added the obstacles' effects and rendered them
- added different positions for obstacles for each table type

### 8 Jun 2023

- implemented ui messages, and they should now mostly work besides some minor bugs (ex.
  regenerating a table might make a notification pop up)
- ui messages implemented: not hitting any balls, hitting the wrong ball type, pocketing the wrong
ball type, illegally pocketing the 8-ball, and pocketing the cueball
- fixing player alternation
- moved player turn display to upper left so it wouldn't block the table, and made the display red
- i think i got rid of the big 8 that sometimes appears when the 8ball is pocketed

### 9 Jun 2023

- merged onto main and fixed the many merge conflicts
- need to figure out if cueball can be moved during other fouls?
- rounded ui corners
- bug discovered: PLAYER ONE/TWO swap visibly after a ball gets pocketed
- standardized names to "striped" and "solid"
- fixed 8ball win condition bug
- got rid of big number appearing when a ball is pocketed
- fixed the glitch where the ui balls display shows before the round where the
first ball is pocketed is done
- cleaned up comments and auto formatted
