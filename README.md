# Yet another Minesweeper

## How to play

### Create a game:

    POST to https://sweeper-lean.herokuapp.com/games

You will get a response with the game details, including its id. Right now the only available game size is
8x8. It is recommended to use an http client that beautifies the JSON response. 

Sample response:

```json
{
  "started": "2020-04-20 12:57:17 -0300",
  "finished": null,
  "status": "in progress",
  "id": "c0de2506",
  "columns": 8,
  "rotws": 8,
  "board":{
    "0": "# # # # # # # #",
    "1": "# # # # # # # #",
    "2": "# # # # # # # #",
    "3": "# # # # # # # #",
    "4": "# # # # # # # #",
    "5": "# # # # # # # #",
    "6": "# # # # # # # #",
    "7": "# # # # # # # #"
  }
}
```

### Make a move

    PUT to https://sweeper-lean.herokuapp.com/games/:id

You need to submit `row` and `col` params with the row number. If its a valid position, you will get an
updated status for the board:

Example for a request revealing row 5, col 2

```json
{
  "started": "2020-04-20 12:57:17 -0300",
  "finished": null,
  "status": "in progress",
  "id": "c0de2506",
  "columns": 8,
  "rotws": 8,
  "board":{
    "0": "# # # # # # # #",
    "1": "# # # # # # # #",
    "2": "# # # # # # # #",
    "3": "# # # # # # # #",
    "4": "# # # # # # # #",
    "5": "# # 1 # # # # #",
    "6": "# # # # # # # #",
    "7": "# # # # # # # #"
  }
}
```
## What is it

Minesweeper is a classic game where you reveal cells on a grid which contains some bombs, with the goal of
revealing bombs by inferring their position. By revealing a cell, you either get the number of bombs adjacent to the
cell, or a bomb. Getting a bomb means you lost, revealing all the non bomb cells wins the game.

## Roadmap

Time is very limited, so requirements will be met in the following order:

1. develop a [running web app](#running-web-app)
2. implement [game creation](#game-crud) and details (show page equivalent)
3. implement cell revealing
4. implement win/lose conditions
5. flagging cells
6. persistence (time to setup is too high and can be invested in features)

At some point, I'll add a how to play section here

### Running web app

This includes app structure, tools and a simple endpoint.

All built with tdd, using the following tools:

* Sinatra as the very small framework
* RSpec as the testing tool
* Bundler as the dependecy manager

### Game CRUD

For the game CRUD, I'll start by building the Game class, and work my way up to the controller from there. 

This is the first entry in the README file I write _before_ coding the actual thing.

I plan on tdd-ing a `Game` class that implements the public API for a `Game` object.

What I expect to code is:

For the game class

* game class that can be instantiated with fixed number of rows and columns
* seeding of bombs
* game creation time
* status: [won, lost, inprogress]
* public method to reveal a cell

For cells

* coordinates/position
* content [bomb, empty, # of surrounding bombs]
* status [revealed, concealed, flagged]


