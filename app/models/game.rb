# frozen_string_literal: true

class Game
  attr_reader :rows, :started, :finished, :status

  def initialize(rows_num = 8, cols_num = 8)
    @rows_num = rows_num
    @cols_num = cols_num
    @bomb_count = ((rows_num * cols_num) / 6).round
    @started = Time.now
    @status = 'in progress'
    @rows = []

    populate!
  end

  def content
    @content ||= rows.map do |row|
      row.map { |r| r[:revealed] ? r[:content] : '#' }.join(' ')
    end
  end

  def reveal(row, col)
    if row > (@rows_num - 1) || row.negative? || col > (@cols_num - 1) || col.negative?
      return false
    end
    return self if @finished

    reveal_cel(row, col)
    @content = nil

    self
  end

  private

  # reveal the cel, lose the game if its a bomb
  # reveal adjacent non bomb if this cel doesn't have any bombs around
  def reveal_cel(row, col)
    cel = rows[row][col]

    cel[:revealed] = true

    if cel[:bomb]
      @status = 'lost'
      @finished = Time.now
    elsif cel[:content] == '0'
      surrounding_cells(row, col).each do |coords|
        cel = rows[coords.first][coords.last]
        cel[:revealed] = cel[:content] == '0'
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
