Item = Struct.new(:name, :sell_in, :quality) do
  def increase_quality(amount = 1)
    self.quality += amount
  end

  def decrease_quality(amount = 1)
    self.quality -= amount
  end

  def decrease_sell_in
    self.sell_in -= 1
  end

  def has_quality?
    self.quality >= 0
  end

  def sulfuras?
    self.name.include?("Sulfuras, Hand of Ragnaros")
  end

  def aged_brie?
    self.name.include?("Aged Brie")
  end

  def backstage_passes?
    self.name.downcase.include?("backstage passes to a tafkal80etc concert")
  end

  def conjured?
    self.name.include?("Conjured")
  end

  def expired?
    self.sell_in <= 0
  end

  def quality_decrease_exempt?
    self.aged_brie? ||
    self.backstage_passes? ||
    self.sulfuras?
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update!
    @items.each do |item|
      update_quality(item) if item.has_quality?
      update_sell_in(item)
    end
  end

  def update_sell_in(item)
    if !item.sulfuras? || item.conjured? then
      item.decrease_sell_in
    end
  end

  def update_quality(item)
    

    if zero_on_expire?(item) && item.expired?
      
      item.quality = 0
    else
      margin = calculate_quality_margin(item)
      if !item.quality_decrease_exempt?
        margin = item.conjured? ? margin * 2 : margin
        item.decrease_quality(margin)
      elsif !item.sulfuras? && item.quality < 50

        item.increase_quality(margin)
      end
    end
  end

  def zero_on_expire?(item)
    item.conjured? || item.backstage_passes?
  end

  def calculate_quality_margin(item)
    margin =
    if item.backstage_passes? then
      backstage_pass_margin(item)
    else
      item.expired? ? 2 : 1
    end

    cap_margin(item, margin)
  end

  def backstage_pass_margin(item)
    margin =
    case item.sell_in
    when 1..5; 3
    when 6..10; 2
    else; 1
    end
    item.conjured? ? margin -= 1 : margin
  end

  def cap_margin(item, margin)
    if item.quality + margin > 50 then
      50 - item.quality
    else
      margin
    end
  end
end
