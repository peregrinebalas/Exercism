class Grains
    SQUARES = 64

    def self.square(n)
        raise ArgumentError if n < 1 || n > SQUARES
        values[n-1]
    end

    def self.total
        values.sum
    end

    private

    def self.values
        @values ||= set_values
    end

    def self.set_values
        i = 1
        v = *(1...SQUARES)
        v.last.times do
            v[i] = v[i-1] * 2
            i += 1
        end
        v
    end
end