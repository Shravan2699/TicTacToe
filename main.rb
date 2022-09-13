require 'terminal-table'
$arr = (1..9).to_a
$new_arr = $arr.each_slice(3).to_a


$table = Terminal::Table.new :rows =>$new_arr


puts "\n\n              TIC-TAC-TOE\n\nLet's play TIC-TAC-TOE"
puts "\n\n#{$table}"

class Player
    attr_accessor :end_game,:name
    def initialize(name,marker)
        @name = name
        @marker = marker
        @end_game = 0
        @score = 0
    end


    def score_adder
        if @end_game == 1
            @score += 1
        end
    end

    

    def move
        puts "Enter the number where #{@name} wants to place the marker\n"
        get_num = gets.chomp.to_i
        $arr[get_num-1] = @marker
        $new_arr = $arr.each_slice(3).to_a
        $table = Terminal::Table.new :rows =>$new_arr
    end

    def check_rows_cols(ar)
        #Checking if any of the subarrays in arr and arr.transpose is 'X' or 'O'
        results = []
        ar.each do |curr|
          if curr.all?(@marker)
            results.push(true)
          else
            results.push(false)
          end
        end
      
        #Check if any of the elements in results array is TRUE
        if results.any?(true)
          puts "GAME OVER!"
          @end_game = 1
          puts "#{@name} has won the game!WELL DONE MATE!"
          puts @end_game
        end

        #Checking the diagonals
        if $arr[0] == @marker && $arr[4] == @marker && $arr[8] == @marker
            @end_game = 1
            puts "#{@name} has won the game!WELL DONE MATE!"
            @end_game = 1
            puts @end_game
        end        
    end

    def end_game
        @end_game
    end
end


# $game_over = 0
puts 'Enter the name of player 1: '
p1name = gets.chomp
puts 'Enter the name of player 2: '
p2name = gets.chomp

p1 = Player.new(p1name,'X')
p2 = Player.new(p2name,'O')

game_over = false

while game_over == false
    p1.move
    p1.check_rows_cols($new_arr)
    p1.check_rows_cols($new_arr.transpose)
    puts $table
    if p1.end_game != 1
        p2.move
        p2.check_rows_cols($new_arr)
        p2.check_rows_cols($new_arr.transpose)
        puts $table
        if p2.end_game == 1
            puts "#{p2.name} has won the game!!"
            game_over = true
        end
    else
        puts "#{p1.name} has won the game!!"
        game_over = true
    end
end


#Nice to haves(Will add it when I re-touch on the project)

#Will have to add 'TIE' method
#Need to add a method that counts the wins of P1 and P2 and also the draws
#We will also show the total rounds P1 and P2 have played and rounds won by each of them and also rounds tied