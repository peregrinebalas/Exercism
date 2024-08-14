=begin
Write your code for the 'Grains' exercise in this file. Make the tests in
`grains_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/grains` directory.
=end
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
        v = (1...64).to_a
        v.last.times do
            v[i] = v[i-1] * 2
            i += 1
        end
        v
    end
end