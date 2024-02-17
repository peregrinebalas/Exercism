Item = Struct.new(:name, :sell_in, :quality) do
  def has_quality?
    self.quality > 0
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
      update_quality(item) 
      update_sell_in(item)
    end
  end

  def update_sell_in(item)
    if !item.sulfuras? || item.conjured? then
      item.sell_in -= 1
    end
  end

  def update_quality(item)
    if zero_on_expire?(item) && item.expired?
      item.quality = 0
    else
      margin = calculate_quality_margin(item)

      item.quality += margin if margin
    end
  end

  def zero_on_expire?(item)
    item.conjured? || item.backstage_passes?
  end

  def calculate_quality_margin(item)
    base =
    if item.backstage_passes? then
      backstage_pass_margin(item)
    else
      item.expired? ? 2 : 1
    end

    if !item.quality_decrease_exempt?
      base = item.conjured? ? base * 2 : base
      cap_subtraction(item, base * -1)
    elsif !item.sulfuras? && item.quality < 50
      cap_addition(item, base)
    end
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

  def cap_addition(item, margin)
    item.quality + margin > 50 ? 50 - item.quality : margin
  end

  def cap_subtraction(item, margin)
    item.quality + margin < 0 ? item.quality * -1 : margin
  end
end
