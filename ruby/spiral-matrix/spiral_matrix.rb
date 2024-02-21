class SpiralMatrix

    attr_reader :matrix

    def initialize(n)
        @matrix = generate(n)
    end

    def generate(n)
        m = empty_matrix(n)
        populate_matrix(m,n)
    end

    private
    
    def empty_matrix(n)
        m = []
        for i in 1..n do
            m.push([])
        end
        m
    end

    def populate_matrix(m,n)
        count = 1
        x1 = 0
        y1 = 0
        x2 = n - 1
        y2 = n - 1
        
        while x1 <= x2 && y1 <= y2 do
            (y1..y2).to_a.each do |i|
                m[x1][i] = count
                count += 1
            end
            x1 += 1
    
           (x1..x2).to_a.each do |i|
                m[i][y2] = count
                count += 1
            end
            y2 -= 1
    
            (y1..y2).to_a.reverse.each do |i|
                m[x2][i] = count
                count += 1
            end
            x2 -= 1
    
            (x1..x2).to_a.reverse.each do |i|
                m[i][y1] = count
                count += 1
            end
            y1 += 1
        end
        m
    end
end
