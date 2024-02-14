module BookStore
    def self.calculate_price(basket)
        counts = basket.reduce(Hash.new(0)) { |counts, book| counts[book] += 1; counts }
        basket = basket.sort_by { |book| counts[book] }
        batches = basket.reverse.reduce([[]]) do |batches, book|
            batch = batches.find { |batch| batch.length == 3 && !batch.include?(book) }
            if batch then
                batch << book
            else
                i = 0; i += 1 while batches[i] && batches[i].include?(book)
                batches[i] ? batches[i] << book : batches << [book]
            end

            batches
        end

        batches.reduce(0) do |total, batch|
            price = batch.size * 8
            total += price - discount(batch.size) * price
        end
    end

    private
    
    def self.discount(group)
        case group
        when 4,5
             (group * 0.05)
        when 2,3
            ((group - 1) * 0.05)
        else
            0
        end
    end
end