require "pry-byebug"

class MySign
    attr_accessor :sign
    def initialize(sign)
        @sign = sign
    end
end

class Game
    def initialize
        @game_done = false
        @field = Array.new
        @result
        9.times { |x| @field[x] = MySign.new(x) }
    end

    def display_grid
        print "   
                |       |       
            #{@field[0].sign}   |   #{@field[1].sign}   |   #{@field[2].sign}   
         _______|_______|_______
                |       |       
            #{@field[3].sign}   |   #{@field[4].sign}   |   #{@field[5].sign}  
         _______|_______|_______
                |       |       
            #{@field[6].sign}   |   #{@field[7].sign}   |   #{@field[8].sign}   
                |       |       
      
        "
    end

    def get_input
        puts "Choose your field, number 0 - 8"
        input = gets.chomp().to_i
        while (input < 0) || (input > 8) 
            puts "Wrong field"
            input = gets.chomp().to_i
        end
        if (input.between?(0,8))
            while (@field[input].sign.class == String)
                puts "Wrong input!"
                input = gets.chomp().to_i
            end
        else
            return "Wrong input!"
        end
        return input
    end

    def winner?
        #ROW CHECK?
        x = 0
        y = 2

        until (x > 8)
            row = @field[(x..y)].all? {|z| z.sign == 'X'
            } || @field[(x..y)].all? {|z| z.sign == 'O'}

            if (row == true)
                if (@field[x].sign == 'X')
                    @result = "Player-One Won!"
                elsif (@field[x].sign == 'O')
                    @result = "Player-Two Won!"
                end
                return row
            end
            x += 3
            y += 3
        end
        #COLUMN CHECK?
        x = 0 
        y = 6

        until (x > 2)
            column = @field[(x..y).step(3)].all? {|z| z.sign == 'X'
            } || @field[(x..y).step(3)].all? { |z| z.sign == 'O'}
            if (column == true)
                if (@field[x].sign == 'X')
                    @result = "Player-One Won!"
                elsif (@field[x].sign == 'O')
                    @result = "Player-Two Won!"
                end
                return column
            end
            x += 1
            y += 1
        end
        #DIAGONAL CHECK?
        x = 0
        y = 8
        w = 4

        until (x > 2)
            diagonal = @field[(x..y).step(w)].all? { |z| z.sign == 'X'
            } ||  @field[(x..y).step(w)].all? { |z| z.sign == 'O'}
            if (diagonal == true)
                if (@field[x].sign == 'X')
                    @result = 'Player-One Won!'
                elsif (@field[x].sign == 'O')
                    @result = "Player-Two Won!"
                end
                return diagonal
            end
            x += 2
            y -= 2
            w -= 2
        end
        return false
    end

    def round 
        user1_input = get_input
        @field[user1_input].sign = "X"
        @game_done = winner?
        display_grid

        if (@game_done == false && @field.any? { |x| x.sign.class == Integer})
            user2_input = get_input
            @field[user2_input].sign = "O"
            @game_done = winner?
        end
        if (@field.all? { |x| x.sign.class == String})
            @game_done = true
            @result = "Its a draw!"
        end
        display_grid
    end

    def game_Inprogress
        until (@game_done) do
            round
        end
        puts @result
    end


end

puts "\n    Welcome to the Tic Tac Toe Game!!"

new_game = Game.new

print "   
                |       |       
            0   |   1   |   2   
         _______|_______|_______
                |       |       
            3   |   4   |   5   
         _______|_______|_______
                |       |       
            6   |   7   |   8   
                |       |       
      
"
new_game.game_Inprogress



