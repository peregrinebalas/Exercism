class Deque
    def initialize
        @list = []
    end
    
    def push(x)
        @list.push(x)
    end
    
    def pop
        @list.pop
    end
    
    def unshift(x)
        @list.unshift(x)
    end
    
    def shift
        @list.shift
    end
end