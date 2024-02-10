class Grep
    def self.grep(pattern, flags, files)
        flags = flags.to_h { |flag| [flag[-1].to_sym, true] }
        add_file = files.size > 1

        files.reduce([]) do |matches, file|
            IO.read(file).split("\n").each_with_index do |line, i|
                if add_line?(pattern, line, flags) then
                    matches << new_line(flags, line, i, file, add_file)
                end
            end
            matches
        end.uniq.join("\n")
    end

    private

    def self.pattern_match?(line, pattern, flags)
        line, pattern = [line.upcase, pattern.upcase] if flags[:i]
        flags[:x] ? line == pattern : line.include?(pattern)
    end

    def self.add_line?(pattern, line, flags)
        (!flags[:v] && pattern_match?(line, pattern, flags)) ||
        (flags[:v] && !pattern_match?(line, pattern, flags))
    end

    def self.new_line(flags, line, i, file, add_filename)
        if !flags[:l] then
            new_line = flags[:n] ? "#{i+1}:#{line}" : line
            add_filename ? "#{file}:#{new_line}" : new_line
        else
            file
        end
    end
end