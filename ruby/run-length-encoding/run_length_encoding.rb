class RunLengthEncoding
    def self.encode(input)
        chunks = input.split('').slice_when do |before, after|
            before != after
        end

        chunks.reduce("") do |output, chunk|
            output << (chunk.length == 1 ? chunk[0] : "#{chunk.length}#{chunk[0]}")
        end
    end

    def self.decode(input)
        pp input

        chunks = input.partition(/(\d.{1}|.)/)

        pp chunks.to_a

        chunks.reduce("") do |output, chunk|
            output << (chunk.length == 1 ? chunk[0] : chunk * chunk.length)
        end
    end
end