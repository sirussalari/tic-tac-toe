class Board
    attr_accessor :row1
    attr_accessor :row2
    attr_accessor :row3
    @@board_array = [
        [],
        [],
        []
    ]

    def initialize
        @row1 = '_ _ _'
        @row2 = '_ _ _'
        @row3 = '_ _ _'
    end

    def self.board_array
        return @@board_array
    end

    def place_piece(board, player, player_number, row, column)
        char = nil
        if player_number == 1
            char = 'x'
        else
            char = 'o'
        end
        column_index = nil
        if column == 1
            column_index = 0
        elsif column == 2
            column_index = 2
        elsif column == 3
            column_index = 4
        end

        if row == 1 and Board.is_not_empty(board, player, row1[column_index])
            row1[column_index] = char
            Board.board_array[row - 1][column - 1] = char
            board.display_board
            if !Board.game_over(board)
                for person in Player.instances
                    if person != player
                        person.turn(board)
                    end
                end
            elsif Board.game_over(board) == 'tie'
                puts "Game over! It's a tie!"
            else
                puts "Game over! #{player.name} wins!"
            end
        elsif row == 2 and Board.is_not_empty(board, player, row2[column_index])
            row2[column_index] = char
            Board.board_array[row - 1][column - 1] = char
            board.display_board
            if !Board.game_over(board)
                for person in Player.instances
                    if person != player
                        person.turn(board)
                    end
                end
            elsif Board.game_over(board) == 'tie'
                puts "Game over! It's a tie!"
            else
                puts "Game over! #{player.name} wins!"
            end
        elsif row == 3 and Board.is_not_empty(board, player, row3[column_index])
            row3[column_index] = char
            Board.board_array[row - 1][column - 1] = char
            board.display_board
            if !Board.game_over(board)
                for person in Player.instances
                    if person != player
                        person.turn(board)
                    end
                end
            elsif Board.game_over(board) == 'tie'
                puts "Game over! It's a tie!"
            else
                puts "Game over! #{player.name} wins!"
            end
        end
    end

    def display_board
        puts row1
        puts row2
        puts row3
    end

    def self.is_not_empty(board, player, space)
        if space != '_'
            puts "Uh oh! It looks like that spot is taken. Please try again"
            player.turn(board)
        else
            return true
        end
    end

    def self.game_over(board)
        column1 = []
        column2 = []
        column3 = []
        for row in Board.board_array
            column1.append(row[0])
            column2.append(row[1])
            column3.append(row[2])
        end
        for row in Board.board_array
            if row.count('x') == 3 or row.count('o') == 3
                return true
            end
        end
        if column1.count('x') == 3 or column1.count('o') == 3
            return true
        elsif column2.count('x') == 3 or column2.count('o') == 3
            return true
        elsif column3.count('x') == 3 or column3.count('o') == 3
            return true
        end
        count = 0
        for row in Board.board_array
            if row.length == 3
                count += 1
            end
        end
        if count == 3
            return 'tie'
        end
        return false
    end    
end

class Player
    attr_reader :player_number
    attr_reader :name
    @@instances = []

    def initialize(player_number, name)
        @player_number = player_number
        @name = name
        @@instances.append(self)
    end

    def self.instances
        return @@instances
    end

    def turn(board)
        row = nil
        column = nil
        loop do
            puts "#{@name}, which row would you like to place a piece? "
            row = gets
            row = row.to_i
            if row > 0 and row < 4
                break
            end
        end

        loop do
            puts "And which column? "
            column = gets
            column = column.to_i
            if column > 0 and column < 4
                break
            end
        end

        board.place_piece(board, self, player_number, row, column)
    end
end

puts "What is player 1's name? "
name_1 = gets.chomp

puts "What is player 2's name? "
name_2 = gets.chomp

player_1 = Player.new(1, name_1)
player_2 = Player.new(2, name_2)

board = Board.new
player_1.turn(board)

