module BookStore
    @@cost = 8
    @@base_discount = 0.05

    def self.calculate_price(basket)
        counts = basket.reduce(Hash.new(0)) { |counts, book| counts[book] += 1; counts }
        calculate_total(basket.sort_by { |book| counts[book] })
    end

    private

    def self.calculate_total(basket)
        batch_books(basket.reverse).reduce(0) do |total, batch|
            price = batch.size * @@cost
            total += price - discount(batch.size) * price
        end
    end

    def self.batch_books(basket)
        basket.reduce([[]]) do |batches, book|
            batch = batches.find { |batch| batch.length == 3 && !batch.include?(book) }
            if batch then
                batch << book
            else
                i = 0; i += 1 while batches[i] && batches[i].include?(book)
                batches[i] ? batches[i] << book : batches << [book]
            end

            batches
        end
    end
    
    def self.discount(group)
        case group
        when 4,5
             (group * @@base_discount)
        when 2,3
            ((group - 1) * @@base_discount)
        else
            0
        end
    end
end