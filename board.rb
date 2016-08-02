require 'byebug'

class Board
  attr_accessor :grid, :shuffled_cards

  def initialize(grid_size = 4)
    @grid = Array.new(grid_size) { Array.new(grid_size) }
    @shuffled_cards = sorted_cards.shuffle
  end

  def sorted_cards
    sorted_cards = []
    ((@grid.size ** 2) / 2).times do |i|
      sorted_cards << i
      sorted_cards << i
    end
    sorted_cards
  end

  def to_s(grid)
    string_grid = "col  "
    i = 0
    while i < grid.length
      string_grid << "#{i}  "
      i += 1
    end
    string_grid << "\nrow \n"
    grid.each_with_index do |row, i|
      string_grid << ("#{i}:   " + row.join("  ") + "\n")
    end
    string_grid
  end

  def render
    rendered_grid = grid.map do |row|
      row.map do |card|
        if card.face_up
          card.value
        else
          "#"
        end
      end
    end
    puts to_s(rendered_grid)
  end

  def populate
    @grid.map! do |row|
      row.each_with_index do |_, i|
        row[i] = Card.new(shuffled_cards[i])
      end
    end
  end

  def reveal(pos)
    @grid[pos[0]][pos[1]].reveal
    @grid[pos[0]][pos[1]].value
  end

  def won?
    @grid.all? do |row|
      row.all? {|card| card.face_up}
    end
  end

end
