module BookStore
    def self.calculate_price(basket)
        counts = basket.reduce(Hash.new(0)) { |counts, book| counts[book] += 1; counts }
        basket = basket.sort_by { |book| counts[book] }
        batches = basket.reverse.reduce([[]]) do |batches, book|
            i = 0
            while batches[i] && batches[i].include?(book) do
                i += 1
            end

            batch = batches.find do |batch|
                (batch.length == 3 &&
                !batch.include?(book))
            end

            if batch then
                batch << book
            elsif batches[i]
                batches[i] << book
            else
                batches << [book]
            end

            batches
        end

        batches.reduce(0) do |price, batch|
            discount =
            case batch.size
            when 4,5
                 (batch.size * 0.05)
            when 2,3
                ((batch.size - 1) * 0.05)
            else
                0
            end
            price += (batch.size * 8) - (discount * (batch.size * 8))
        end
    end
end