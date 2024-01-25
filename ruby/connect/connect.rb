class Board
    attr_reader :board
    
    def initialize(board)
        @board = board
    end

    def winner
        if board.length == 1 then
            return board[0]
        else
            return ''
        end
    end
end