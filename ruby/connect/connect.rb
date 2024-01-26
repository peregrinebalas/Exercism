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

    def x_left_to_right?
        if x_left? then
            x_crosses?
        end
    end

    def x_crosses?
        # len = board[0].length - 1
        # x_indeces = board.map do |row|
        #     tracker = []
        #     row.each_with_index do |cell, i|
        #         tracker << i if cell == 'X'
        #     end
        #     tracker
        # end

        # current_index = 0
        # direction = :down
        # sequence = []
        # done = false
        # until done do
        #     if sequence.empty? then
        #         sequence.union(x_indeces[current_index])
        #     else
        #         x_indeces.each do |x|
                    
        #         end
        #     end
        # end
        outcome = ('.' * board[0].length).split('')

        board.each_with_index do |row, row_i|
            if (outcome.all? { |cell| cell == '.' }) then
                outcome = row
            else
                row.each_with_index do |cell, i|
                    if cell == 'X' && unblocked_diagonal?(row_i, i) then
                        outcome[i] = cell
                    end
                end
            end
        end
        pp outcome
        outcome.all? { |cell| cell == 'X' }
    end

    def unblocked_diagonal?(row, column)
        cell = board[row][column]
        opposition = cell == 'X' ? 'O' : 'X'
        
        area = {
            top: board[row-1] && board[row-1][column],
            bottom: board[row+1] && board[row+1][column],
            left: board[row][column-1],
            right: board[row][column+1],
        }
    end

    def x_left?
        board.any? { |row| row[0] == 'X' }
    end

    def o_top_to_bottom?
        if o_top? then
            o_crosses?
        end
    end

    def o_crosses?
        outcome = ('.' * board.length).split('')

        board.each_with_index do |row, row_i|
            if (outcome.all? { |cell| cell == '.' }) then
                outcome = row
            else
                row.each_with_index do |cell, i|
                    if cell == 'O' || cell == 'X' && row[i-1] == 'O' then
                        outcome[i] = cell
                    end
                end
            end
        end

        outcome.all? { |cell| cell == 'O' }
    end

    def o_top?
        board[0].any? { |column| column == 'O' }
    end

    def parse_board(board)
        board.map do |row|
            row.split(" ")
        end
    end
end