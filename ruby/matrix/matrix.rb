class Matrix
    attr_reader :matrix
    def initialize(matrix_str)
        @matrix = parse_matrix_str(matrix_str)
    end

    def row(n)
        return matrix[n-1]
    end

    def column(n)
        return matrix.map { |row| row[n-1] }
    end

    private

    def parse_matrix_str(matrix_str)
        rows = matrix_str.split("\n")
        rows.map do |row|
            row.split(" ").map { |str| str.to_i }
        end
    end
end