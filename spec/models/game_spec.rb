require 'spec_helper'

describe Game do
  context "On creation" do
    # * game class that can be instantiated with fixed number of rows and columns
    # * seeding of bombs
    # * game creation time
    # * status: [won, lost, inprogress]
    # * public method to reveal a cell
    it "has fixed dimensions" do
      game = Game.new
      expect(game.rows.flatten.size).to eq(Game::ROW_SIZE * Game::COLUMN_SIZE)
    end

    it "has bombs" # no clue yet of what this test does
    it "has a start date"
    it "is in state inprogress"
    it "allows a cell position to be revealed"
  end
end
