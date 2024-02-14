module BookStore
    def self.calculate_price(basket)
        pp basket
        counts = basket.reduce({}) do |counts, book|
            counts[book] ? counts[book] += 1 : counts[book] = 1
            counts
        end
        counts = counts.to_a.sort { |a,b| b[1] <=> a[1] }
        pp counts.to_h
        batches = counts.to_h.reduce([]) do |batches, (book, count)|
            
            count.times do
                batches = if count > batches.size then
                    Array.new(count) { [book] }
                else
                    countdown = count
                    batches.map do |batch|
                        if countdown > 0 && !batch.include?(book) then
                            countdown -= 1
                            batch << book
                        else
                            batch
                        end
                    end
                end
            end
            batches
        end

        pp batches
        # batches = basket.reduce([[]]) do |batches, book|
        #     i = 0
        #     while batches[i] && batches[i].include?(book) do
        #         i += 1
        #     end
        #     min = batches.min { |a, b| a.length <=> b.length }
        #     batches[i] ? batches[i] << book : batches << [book]
        #     batches
        # end

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