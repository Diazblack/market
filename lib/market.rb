class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.has_key?(item)
    end
  end

  def sorted_item_list
    list = []
    @vendors.each do |vendor|
      vendor.inventory.each_key do |key|
        if !(list.include?(key))
          list << key
        end
      end
    end
    list.sort
  end

  def total_inventory
    hash = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each_pair do |item, amount|
        hash[item] += amount
      end
    end
    hash
  end

  def sell(item, amount)
    vendors_with_item = vendors_that_sell(item)
    sum = sum_of_item(item, vendors_with_item)
    if vendors_with_item == []
      false
    elsif sum < amount
      false
    else
      sustract_from_vendor(sum, vendors_with_item, amount)
    end
  end

  def sum_of_item(item, vendors_with_item)
    vendors_with_item.sum do |vendor|
      vendor.inventory[item]
    end
  end

  def sustract_from_vendor(sum, vendors_with_item, amount)
    vendors_with_item.each do |vendor|
      vendor.inventory.each_pair do |item, quantity|
        if sum > quantity
          sum -= quantity
          vendor.inventory[item] -= quantity
        elsif amount == sum
          vendor.inventory[item] -= amount
        else
          vendor.inventory[item] -= sum
        end
      end
    end
  end

end
