class Triangle
    attr_reader :rows

    def initialize(n)
        @rows = generate_rows([[1]], n)
    end

    private

    def generate_rows(rows, n)
        if rows.size < n then
            row = [0] + rows.last + [0]
            rows << row.each_cons(2).map {|a,b| a + b}
            generate_rows(rows, n)
        else
            rows
        end
    end
end