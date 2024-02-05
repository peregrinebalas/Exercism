class RunLengthEncoding
    def self.encode(input)
        input.gsub(/(.)\1+/) { |x| "#{x.size}#{x[0]}"}
    end

    def self.decode(input)
        input.gsub(/\d+./) { |x| x[-1] * x.to_i }
    end
end
