class Game
  ROW_SIZE = 16
  COLUMN_SIZE = 16
  BOMBS = 40

  attr_reader :rows

  def initialize
    @rows = []
    populate!
    self
  end

  private

  def populate!
    return false if @rows.any?

    add_rows
    create_cells

    self
  end

  def add_rows
    ROW_SIZE.times { @rows << [] }
  end

  def create_cells
    rows.each do |row|
      COLUMN_SIZE.times { row << Hash.new }
    end
  end
end
