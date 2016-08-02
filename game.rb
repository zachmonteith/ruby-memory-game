require './board.rb'
require './card.rb'
require './player.rb'
class Game

attr_accessor :board, :tries

  def initialize(player = 'computer', grid_size = 4)
    @board = Board.new(grid_size)
    @tries = 0
    if player == 'computer'
      @player = ComputerPlayer.new(grid_size)
    else
      @player = HumanPlayer.new(grid_size)
    end
  end


  # def get_move
  #   puts "what card would you like to check? [row, column]"
  #   @pos1 = gets.chomp.split(",")
  #   @pos1.map! { |num| num.to_i }
  #   until valid_move?(@pos1)
  #     puts "Sorry, invalid position. Try again."
  #     puts "what card would you like to check? [row, column]"
  #     @pos1 = gets.chomp.split(",")
  #     @pos1.map! { |num| num.to_i }
  #   end
  #   @board.reveal(@pos1)
  #   @board.render
  #   puts "which card do you think it matches? [row, column]"
  #   @pos2 = gets.chomp.split(",")
  #   @pos2.map! { |num| num.to_i }
  #   until valid_move?(@pos2)
  #     puts "Sorry, invalid position. Try again."
  #     puts "which card do you think it matches? [row, column]"
  #     @pos2 = gets.chomp.split(",")
  #     @pos2.map! { |num| num.to_i }
  #   end
  #   @board.reveal(@pos2)
  #   @board.render
  # end

  def match?
    if @board.grid[@player.pos1[0]][@player.pos1[1]].value !=
        @board.grid[@player.pos2[0]][@player.pos2[1]].value

      @board.grid[@player.pos1[0]][@player.pos1[1]].hide
      @board.grid[@player.pos2[0]][@player.pos2[1]].hide
    end
  end

  def play
    @board.populate
    until @board.won?
      @board.render
      pos = @player.get_first_move
      val = @board.reveal(pos)
      @player.receive_revealed_card(pos, val)
      @board.render
      pos = @player.get_second_move
      val = @board.reveal(pos)
      @player.receive_revealed_card(pos, val)
      @board.render
      sleep(4)
      system("clear")
      match?
      @tries += 1
    end
    win
  end

  def win
    puts "wow, you did it!  I didn't think you could! you took #{@tries}"
    puts "tries to correctly identify each pair."
    if @tries < (@board.grid.length * 3)
      puts "great job, that is very impressive."
    else
      puts "took you a while, huh?"
    end
    puts "coded by Kurt and Zach for A/a on March 8, 2016"
    puts "thank you for playing!"
  end
end



if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
