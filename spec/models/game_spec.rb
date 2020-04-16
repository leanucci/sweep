require 'spec_helper'

describe Game do
  context "On creation" do
    # * game class that can be instantiated with fixed number of rows and columns
    # * seeding of bombs
    # * game creation time
    # * status: [won, lost, inprogress]
    # * public method to reveal a cell
    subject(:game) { Game.new }
    let(:bigger_game) { Game.new(16, 16) }

    it "one eight of rows are bombs" do
      expect(subject.rows.flatten.size).to eq(64)
      expect(bigger_game.rows.flatten.size).to eq(256)
    end

    it "has one sixth of its size in bombs" do
      bombs = subject.rows.flatten.select { |cell| cell[:bomb] } 
      expect(bombs.count).to eq(10)

      bigger_game_bombs = bigger_game.rows.flatten.select { |cell| cell[:bomb] }
      expect(bigger_game_bombs.count).to eq(42)
    end

    it "has a start date"
    it "is in state inprogress"
    it "allows a cell position to be revealed"
  end
end
