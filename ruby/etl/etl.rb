module ETL
    def self.transform(old)
        old.reduce({}) do |acc, (k,v)|
            v.each { |x| acc[x.downcase] = k }
            acc
        end
    end
end