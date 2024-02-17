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
    aged_brie? || backstage_passes? || sulfuras?
  end

  def zero_on_expire?
    conjured? || backstage_passes?
  end

  def quality_shift
    base = backstage_passes? ? backstage_pass_margin : expired? ? 2 : 1

    if !quality_decrease_exempt?
      base = conjured? ? base * 2 : base
      cap_subtraction(base * -1)
    elsif !sulfuras? && self.quality < 50
      cap_addition(base)
    end
  end

  def cap_addition(margin)
    self.quality + margin > 50 ? 50 - self.quality : margin
  end

  def cap_subtraction(margin)
    self.quality + margin < 0 ? self.quality * -1 : margin
  end

  def backstage_pass_margin
    margin =
      case self.sell_in
      when 1..5; 3
      when 6..10; 2
      else; 1
      end
    conjured? ? margin -= 1 : margin
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
    item.sell_in -= 1 if !item.sulfuras? || item.conjured?
  end

  def update_quality(item)
    if item.zero_on_expire? && item.expired?
      item.quality = 0
    else
      margin = item.quality_shift
      item.quality += margin if margin
    end
  end
end
