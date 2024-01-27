class Board
    attr_reader :game, :winner

    X = 'X'
    O = 'O'

    def initialize(game)
        @game = game.map { |row| row.split(" ") }
        @winner = ''

        pathfinding(X, @game.transpose)
        pathfinding(O, @game)
    end

    private

    def pathfinding(type, board)
        @board = board
        @xmax = board[0].length - 1
        @ymax = board.length - 1

        board[0].each_with_index do |cell, i|
            win_if_connected(type, 0, i)
            if cell == type && !game_over?
                connection?(0, i)
            end
        end
    end

    def game_over?
        @winner != ''
    end

    def connection?(x, y)
        cell = @board[x][y]
        area = area(x, y)
        pp area
        pp @board
        area.each do |ax, ay|
            if inside_board?(ax, ay) && !game_over? then
                win_if_connected(cell, ax, ay)
            end
        end
        game_over?
    end

    def win_if_connected(cell, x, y)
        if @board[x][y] == cell && x == @xmax then
            @winner = cell
        elsif @board[x][y] == cell then
            @board[x][y] = cell + "."
            connection?(x, y)
        end
    end

    def inside_board?(x, y)
        x >= 0 && y >= 0 && x <= @xmax && y <= @ymax
    end

    def area(x, y)
        [-1, 0, 1].permutation(2).to_a.reverse.map { |ax, ay| [x + ax, y + ay]}
    end
end
