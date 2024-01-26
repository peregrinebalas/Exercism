require 'pry'

class Board
    attr_reader :board

    def initialize(board)
        @board = parse_board(board)
    end

    def winner
        if board.length == 1 then
            board[0][0]
        elsif x_left_to_right? then
            'X'
        elsif o_top_to_bottom? then
            'O'
        else
            return ''
        end
    end

    private

    def parse_board(board)
        board.map do |row|
            row.split(" ")
        end
    end

    def area(row, column)
        {
            top: row - 1 >= 0 && board[row-1][column],
            bottom: board[row+1] && board[row+1][column],
            left: column - 1 >= 0 && board[row][column-1],
            right: board[row][column+1],
            top_right: row - 1 >= 0 && board[row-1][column+1],
            top_left: row - 1 >= 0 && column - 1 >= 0 && board[row-1][column-1],
            bottom_right: board[row+1] && board[row+1][column+1],
            bottom_left: board[row+1] && column - 1 >= 0 && board[row+1][column-1],
        }
    end

    def opposition(cell)
        if cell == 'X' then
            'O'
        elsif cell == 'O' then
            'X'
        else
            '.'
        end
    end

    def adjacent_occupation?(cell, row, column)
        area ||= area(row, column)
        opposition = opposition(cell)
        
        area[:top] == cell ||
        area[:bottom] == cell ||
        area[:left] == cell ||
        area[:right] == cell
    end

    # XXXXXXXXXXXXXXXXXXXXXXXXXXXX

    def x_left_to_right?
        if x_left? then
            x_crosses?
        end
    end

    def x_left?
        board.any? { |row| row[0] == 'X' }
    end

    def x_crosses?
        outcome = ('.' * board[0].length).split('')

        board.each_with_index do |row, row_i|
            valid_connections = []
            row.each_with_index do |cell, i|
                if cell == 'X' && x_valid_step?(cell, row_i, i) then
                    outcome[i] = cell
                    valid_connections << true
                else
                    valid_connections << false
                end
            end

            no_connections = valid_connections.all? { |c| c == false }
            connection_made = outcome.all? { |cell| cell == 'X' }
            if (no_connections && !connection_made) then
                outcome = ('.' * board[0].length).split('')
            end
        end
        outcome.all? { |cell| cell == 'X' }
    end

    def x_valid_step?(cell, row, column)
        adjacent_occupation?(cell, row, column) ||
        x_unblocked_diagonal?(cell, row, column)
    end

    def x_unblocked_diagonal?(cell, row, column)
        area ||= area(row, column)
        opposition = opposition(cell)

        x_unblocked_top_right?(cell, opposition, area) ||
        x_unblocked_bottom_right?(cell, opposition, area) ||
        x_unblocked_top_left?(cell, opposition, area) ||
        x_unblocked_bottom_left?(cell, opposition, area)
    end

    def x_unblocked_top_right?(cell, opposition, area)
        (area[:top_right] && area[:top_right] == cell) &&
        ((area[:right] && area[:right] != opposition) &&
        (area[:top] && area[:top] != opposition))
    end

    def x_unblocked_bottom_right?(cell, opposition, area)
        (area[:bottom_right] && area[:bottom_right] == cell) &&
        ((area[:right] && area[:right] != opposition) &&
        (area[:bottom] && area[:bottom] != opposition))
    end

    def x_unblocked_top_left?(cell, opposition, area)
        (area[:top_left] && area[:top_left] == cell) &&
        ((area[:left] && area[:left] != opposition) &&
        (area[:top] && area[:top] != opposition))
    end

    def x_unblocked_bottom_left?(cell, opposition, area)
        (area[:bottom_left] && area[:bottom_left] == cell) &&
        ((area[:left] && area[:left] != opposition) &&
        (area[:bottom] && area[:bottom] != opposition))
    end

    # OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO

    def o_top_to_bottom?
        if o_top? then
            o_crosses?
        end
    end

    def o_top?
        board[0].any? { |column| column == 'O' }
    end

    def o_crosses?
        outcome = ('.' * board.length).split('')

        board.each_with_index do |row, row_i|
            valid_connections = []
            row.each_with_index do |cell, i|
                if cell == 'O' && o_valid_step?(cell, row_i, i) then
                    outcome[row_i] = cell
                    valid_connections << true
                else
                    valid_connections << false
                end
            end

            no_connections = valid_connections.all? { |c| c == false }
            connection_made = outcome.all? { |cell| cell == 'X' }
            if (no_connections && !connection_made) then
                outcome = ('.' * board.length).split('')
            end
        end

        outcome.all? { |cell| cell == 'O' }
    end

    def o_valid_step?(cell, row, column)
        adjacent_occupation?(cell, row, column) ||
        o_unblocked_diagonal?(cell, row, column)
    end

    def o_unblocked_diagonal?(cell, row, column)
        area ||= area(row, column)
        opposition = opposition(cell)

        o_unblocked_top_right?(cell, opposition, area) ||
        o_unblocked_bottom_right?(cell, opposition, area) ||
        o_unblocked_top_left?(cell, opposition, area) ||
        o_unblocked_bottom_left?(cell, opposition, area)
    end

    def o_unblocked_top_right?(cell, opposition, area)
        (area[:top_right] && area[:top_right] == cell)
    end

    def o_unblocked_bottom_right?(cell, opposition, area)
        (area[:bottom_right] && area[:bottom_right] == cell)
    end

    def o_unblocked_top_left?(cell, opposition, area)
        (area[:top_left] && area[:top_left] == cell)
       ((area[:left] && area[:left] != opposition) ||
       (area[:top] && area[:top] != opposition))
    end

    def o_unblocked_bottom_left?(cell, opposition, area)
        (area[:bottom_left] && area[:bottom_left] == cell)
       ((area[:left] && area[:left] != opposition) ||
       (area[:bottom] && area[:bottom] != opposition))
    end
end