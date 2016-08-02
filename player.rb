class HumanPlayer
attr_accessor :pos1, :pos2, :grid_size

  def initialize(grid_size)
    @grid_size = grid_size
  end

  def valid_move?(pos)
    pos.all? do |num|
      (0...@grid_size).to_a.include?(num)
    end
  end

  def receive_revealed_card(pos, value)
  end

  def get_first_move
    puts "what card would you like to check? [row, column]"
    @pos1 = gets.chomp.split(",")
    @pos1.map! { |num| num.to_i }
    until valid_move?(@pos1)
      puts "Sorry, invalid position. Try again."
      puts "what card would you like to check? [row, column]"
      @pos1 = gets.chomp.split(",")
      @pos1.map! { |num| num.to_i }
    end
  end

  def get_second_move
    puts "which card do you think it matches? [row, column]"
    @pos2 = gets.chomp.split(",")
    @pos2.map! { |num| num.to_i }
    until valid_move?(@pos2)
      puts "Sorry, invalid position. Try again."
      puts "which card do you think it matches? [row, column]"
      @pos2 = gets.chomp.split(",")
      @pos2.map! { |num| num.to_i }
    end
  end
end

class ComputerPlayer
  attr_accessor :grid_size, :known_cards, :matched_cards, :match_idx

  def initialize(grid_size)
    @grid_size = grid_size
    @known_cards = Hash.new {[]}
    @matched_cards = []
    @match_idx = 0
  end

  def receive_revealed_card(pos, value)
    @known_cards[value] << [pos]
  end

  def receive_match(pos1, pos2)
    @matched_cards << [pos1, pos2]
  end

  def get_first_move
    if @matched_cards[@match_idx]
      @match_idx += 1
      return @matched_cards[@match_idx - 1]
    else
      i = 0
      while i < @grid_size
        j = 0
        while j < @grid_size
          unless @known_cards[[i,j]]
            return [i,j]
          end
          j += 1
        end
        i += 1
      end
    end
  end

  def get_second_move
    counterhash = Hash.new(0)
    @known_cards.each do |_, val|
      counterhash[val] += 1
    end
    counterhash.each do |val_of_card, times|
    if times > 1 && @matched_cards ! .include? (val_of_card)
      @matched_cards << val_of_card

    end
  end
