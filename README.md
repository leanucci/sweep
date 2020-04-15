# Yet another Minesweeper

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


