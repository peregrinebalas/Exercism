class RunLengthEncoding
    def self.encode(input)
        input.split('')
             .slice_when { |before, after| before != after }
             .reduce('') { |output, chunk| output << encode_chunk(chunk) }
    end

    def self.decode(input)
        input.scan(/\d+.|./)
             .reduce('') { |output, chunk| output << decode_chunk(chunk) }
    end

    private

    def self.encode_chunk(chunk)
        chunk.size==1 ? chunk[0] : "#{chunk.size}#{chunk[0]}"
    end

    def self.decode_chunk(chunk)
        chunk.size==1 ? chunk[0] : chunk[-1]*chunk[0, chunk.size-1].to_i
    end
end
