# frozen_string_literal: true

class Game
  attr_reader :rows, :started, :finished, :status, :id

  GAME_LEVEL = {
    easy: [8, 8, 10, 54],
    medium: [16, 16, 40, 216],
    hard: [30, 20, 100, 500]
  }

  def initialize(level = :easy)
    @id = SecureRandom.hex(4)
    @rows_num, @cols_num, @bomb_count, @safe_cells = GAME_LEVEL[level]
    @started = Time.now
    @status = 'in progress'
    @rows = []

    populate!
  end
  
  def to_json
    {
      started: started,
      finished: finished,
      status: status,
      id: id,
      columns: @cols_num,
      rotws: @rows_num,
      board: board.map.with_index(0) { |row, idx| [idx, row] }.map.with_object({}) { |ary, res| res[ary.first] = ary.last; res }
    }.to_json
  end

  def board
    @board ||= rows.map do |row|
      row.map { |r| r[:revealed] ? r[:content] : '#' }.join(' ')
    end
  end

  def reveal(row, col)
    if row > (@rows_num - 1) || row.negative? || col > (@cols_num - 1) || col.negative?
      return false
    end
    return self if @finished

    reveal_cel(row, col)
    @board = nil

    self
  end

  private

  # reveal the cel, lose the game if its a bomb
  # reveal adjacent non bomb if this cel doesn't have any bombs around
  def reveal_cel(row, col)
    cel = rows[row][col]

    cel[:revealed] = true
    @safe_cells -= 1

    if cel[:bomb]
      @status = 'lost'
      @finished = Time.now
    elsif cel[:content] == '0'
      surrounding_cells(row, col).each do |coords|
        cel = rows[coords.first][coords.last]
        if cel[:content] == '0'
          cel[:revealed] = true
          @safe_cells -= 1
        end
      end
    end
  end

  def populate!
    add_rows
    create_cells
    seed_board
  end

  def add_rows
    @rows_num.times { @rows << [] }
  end

  def create_cells
    rows.each do |row|
      @cols_num.times do
        row << ({})
      end
    end
  end

  def seed_board
    seed_bombs
    seed_content
  end

  def seed_bombs
    bomb_locations.each do |location|
      rows[location.first][location.last][:bomb] = true
    end
  end

  def seed_content
    rows.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        cell[:revealed] = false
        cell[:content] = if cell[:bomb]
          'b'
        else
          find_surrounding_bombs(row_index, col_index).count.to_s
        end

        rows[row_index][col_index] = cell
      end
    end
  end

  # very very simple seed implementation
  def bomb_locations
    @bomb_locations ||= begin
      bomb_rows = (0...@rows_num).to_a.shuffle.take(@bomb_count)
      bomb_cols = (0...@cols_num).to_a.shuffle.take(@bomb_count)

      bomb_rows.product(bomb_cols).shuffle.take(@bomb_count)
    end
  end

  # this method finds the content in the 8 surrounding cells:
  # [
  #   [row -1, col -1], [row -1, col], [row -1, col +1],
  #   [row,    col -1],    THE CELL,   [row,    col +1],
  #   [row +1, col -1], [row +1, col], [row +1, col +1]
  # ]
  #
  def find_surrounding_bombs(row, col)
    surrounding_cells(row, col).intersection(bomb_locations)
  end

  def surrounding_cells(row, col)
    row_numbers = [row - 1, row, row + 1].reject { |num| num.negative? || num + 1 > @rows_num }
    col_numbers = [col - 1, col, col + 1].reject { |num| num.negative? || num + 1 > @cols_num }
    row_numbers.product(col_numbers) - [row, col]
  end
end
