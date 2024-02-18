class Triangle
    attr_reader :rows

    def initialize(n)
        @rows = generate_rows([[1]], n)
    end

    private

    def generate_rows(rows, n)
        if rows.size < n then
            previous_row = rows.last
            row = Array.new(previous_row.size + 1)
            rows << row.map.with_index do |_,index|
                a = get_value(previous_row, index)
                b = get_value(previous_row, index - 1)
                a + b
            end
            generate_rows(rows, n)
        else
            rows
        end
    end

    def get_value(row, index)
        row[index] && index >= 0 ? row[index] : 0
    end
end