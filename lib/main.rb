puts 'Hello, World!'
require 'terminal-table'

my_mtx = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
table = Terminal::Table.new do |t|
  # Add a border style
  t.style = { border_x: '-', border_i: '+' }
  # Add the rows
  my_mtx.each { |row| t.add_row(row) }
end

puts table

class GameCheck
  attr_accessor :mtx
  attr_reader :p1wins, :p2wins
  def initialize(mtx)
    @mtx = mtx
    @p1wins = false
    @p2wins = false
    # @game_draw = false
  end

  def fully_filled?(mtx)
    mtx.flatten.none? { |element| element.is_a?(Integer) }
  end

  def print_matrix(mtx)
    table = Terminal::Table.new do |t|
      t.style = { border_x: '-', border_i: '+' }
      mtx.each { |row| t.add_row(row) }
    end
    puts table
  end

  def check_matrix(mtx)
    # p mtx
    mtx.each do |row|
      if row.all?('X')
        @p1wins = true
        return true
      elsif row.all?('O')
        @p2wins = true
        return true
      end
    end
    # @game_draw = true
    return false
  end

  def get_diagonal_elements(mtx)
    diagonal_elements = []
    mtx.each_with_index do |row, row_index|
      diagonal_elements << row[row_index]
    end
    diagonal_elements
  end

  def get_anti_diagonal_elements(mtx)
    anti_diagonal_elements = []
    mtx.each_with_index do |row, row_index|
      anti_diagonal_elements << row[-row_index - 1]
    end
    anti_diagonal_elements
  end
  

#This method returns true if any of the possible rows,colums,diagonals have been changed to 'X's or 'O's
  def check_all_possibilities(my_mtx)
    d1 = [get_diagonal_elements(my_mtx)]
    d2 = [get_anti_diagonal_elements(my_mtx)]
    # p d1
    # p d2
    mtx_arr = []
    # p my_mtx
    # p my_mtx.transpose
    mtx_arr.push(check_matrix(my_mtx))
    mtx_arr.push(check_matrix(my_mtx.transpose))
    mtx_arr.push(check_matrix(d1))
    mtx_arr.push(check_matrix(d2))
    
    # puts @p1wins
    # puts @p2wins
    # puts @game_draw
    # p mtx_arr
    mtx_arr.any?(true)
  end

end



class Player
  attr_accessor :name,:marker,:mtx
  def initialize(name,marker,mtx)
    @name = name
    @marker = marker
  end



  def move(mtx)
    puts "#{@name}, enter the number where you would like to place your mark (or 'e' to exit or restart):"
    pos = gets.chomp

    if pos.downcase == 'e'
      puts "Do you want to restart the game? (y/n)"
      choice = gets.chomp.downcase

      if choice == 'y'
        # Restart the game
        return
      else
        # Exit the game
        exit
      end
    end

    pos = pos.to_i

    loop do
      location_valid = false

      mtx.each_with_index do |row, row_index|
        row.each_with_index do |element, col_index|
          if element == pos && !['X', 'O'].include?(mtx[row_index][col_index])
            mtx[row_index][col_index] = @marker
            location_valid = true
            break
          end
        end

        break if location_valid
      end

      break if location_valid

      puts "Invalid location or already occupied. Please choose another location (or 'e' to exit or restart):"
      pos = gets.chomp

      if pos.downcase == 'e'
        puts "Do you want to restart the game? (y/n)"
        choice = gets.chomp.downcase

        if choice == 'y'
          # Restart the game
          return
        else
          # Exit the game
          exit
        end
      end
      pos = pos.to_i
    end
  end

end





class Game
  def game_start
    my_mtx = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    puts "TIC-TAC-TOE\n\nLet's play TIC-TAC-TOE"
    # puts "\n\n#{m.to_a}"
    my_mtx.each do |array|
      print array.join(" ")
    puts
    end
    puts "Enter your name Player 1: "
    p1name = gets.chomp
    puts "Enter your name Player 2: "
    p1 = Player.new(p1name,'X',my_mtx)
    p2name = gets.chomp
    p2 = Player.new(p2name,'O',my_mtx)
    my_game_check = GameCheck.new(my_mtx)
    until my_game_check.check_all_possibilities(my_mtx) || my_game_check.fully_filled?(my_mtx)
      p1.move(my_mtx)
      my_game_check.print_matrix(my_mtx)
      break if my_game_check.check_all_possibilities(my_mtx) || my_game_check.fully_filled?(my_mtx)
      p my_game_check.p1wins
      p my_game_check.p2wins
      p2.move(my_mtx)
      my_game_check.print_matrix(my_mtx)
    end
    if my_game_check.p1wins
      puts "#{p1.name} has won this game!"
    elsif my_game_check.p2wins
      puts "#{p2.name} has won this game!"
    else
      puts "It's a draw!"
    end
  end
end


my_game = Game.new
my_game.game_start




#Need to display a message showing which player wins along with the player name