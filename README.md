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

### Running web app

This includes app structure, tools and a simple endpoint.

All built with tdd, using the following tools:

* Sinatra as the very small framework
* RSpec as the testing tool
* Bundler as the dependecy manager

### Game CRUD

