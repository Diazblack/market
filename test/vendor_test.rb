require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_if_exist
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_if_it_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
    assert_equal ({}) , vendor.inventory
  end

  def test_if_can_chech_stock_by_string
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock("Peaches")
  end
end
