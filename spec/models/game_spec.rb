# frozen_string_literal: true

require 'spec_helper'

describe Game do
  context 'A new game' do
    # * game class that can be instantiated with fixed number of rows and columns
    # * seeding of bombs
    # * game creation time
    # * status: [won, lost, inprogress]
    # * public method to reveal a cell
    subject(:game) { Game.new }
    let(:bigger_game) { Game.new(16, 16) }

    it 'has cells equal to rows * cols' do
      expect(subject.rows.flatten.size).to eq(64)
      expect(bigger_game.rows.flatten.size).to eq(256)
    end

    it 'has one sixth of its size in bombs' do
      bombs = subject.rows.flatten.select { |cell| cell[:bomb] }
      expect(bombs.count).to eq(10)

      bigger_game_bombs = bigger_game.rows.flatten.select { |cell| cell[:bomb] }
      expect(bigger_game_bombs.count).to eq(42)
    end

    it 'has a start date' do
      expect(game.started).to be_a(Time)
    end

    it "is in 'in progress' status" do
      expect(game.status).to eq('in progress')
    end

    context 'when revealing a cell' do
      it 'returns an error if the coordinates are off limits' do
        expect(game.reveal(8, 8)).to be_falsey
      end

      it 'reveals the cell' do
        expect { game.reveal(4, 3) }.to change { game.rows[4][3][:revealed] }.from(false).to(true)
      end
    end
  end
end
