class Grains
    def self.square(n)
        raise ArgumentError if n < 1 || n > 64
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
        v = *(1...64)
        v.last.times do
            v[i] = v[i-1] * 2
            i += 1
        end
        v
    end
end