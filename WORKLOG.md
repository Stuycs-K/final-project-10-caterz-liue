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
(made rectangles and lables)
