class Board
    attr_reader :game, :winner

    def initialize(game)
        @game = game.map { |row| row.split(" ") }
        @winner = ''

        find_path(?X, @game.transpose)
        find_path(?O, @game)
    end

    private

    def find_path(type, board)
        @board = board
        @xmax = board.length - 1
        @ymax = board[0].length - 1
        @traversed = []

        @board[0].each_with_index do |cell, i|
            break if winner?(type, 0, i) 
            break if connection?(0, i) if cell == type
        end
    end

    def connection?(x, y)
        cell = @board[x][y]
        area = area(x, y)
        area.each do |ax, ay|
            break if winner?(cell, ax, ay) if inside_board?(ax, ay) && !@traversed.any?([ax, ay])
        end
        @winner != ''
    end

    def winner?(cell, x, y)
        if @board[x] && @board[x][y] == cell then
            @winner = cell if x == @xmax
            @traversed << [x, y]
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
