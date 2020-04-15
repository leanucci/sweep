class Game
  ROW_SIZE = 16
  COLUMN_SIZE = 16

  attr_reader :rows

  def initialize
    @rows = []
    populate!
    self
  end



  private

  def populate!
    return false if @rows.any?

    begin
      ROW_SIZE.times do
        row = []
        COLUMN_SIZE.times do
          row << Hash.new
        end
        rows << row
      end
    rescue => e
      puts "There was an error populating the game"
      @rows = []
    end
    self
  end
end
