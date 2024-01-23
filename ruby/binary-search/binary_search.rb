class BinarySearch
    attr_reader :list

    def initialize(list)
        @list = list
    end

    def search_for(n)
        len = list.length
        first = 0
        last = len - 1
        i = len/2
        
        if list[i] == n then
            return i
        elsif list.empty? then
            return nil
        end

        while first != last do
            if list[i] == n then
                return i
            elsif first + 1 == last then
                break
            else
                if list[i] > n then
                    last = i
                    node = ((last - first) / 2)
                    i = i - (node > 0 ? node : 1)
                else
                    first = i
                    node = ((last - first) / 2) 
                    i = i + (node > 0 ? node : 1)
                end
            end
        end
    end
end