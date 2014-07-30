require 'test_helper'

class SpreeScheduledSaleTest < ActiveSupport::TestCase

  test "variant should be on sale if the parent product is on sale even if variant is not specificaly on sale" do
    product = flexmock(Spree::Product.new)
    product.should_receive("on_sale?" => true)

    variant = flexmock(Spree::Variant.new)
    variant.should_receive("item_scheduled_sales.active.not_excluded.blank?" => true)
    variant.should_receive("product" => product)

    assert variant.on_sale?, 'Not on sale'
  end

  test "variant should be on sale if the parent product is not on sale" do
    product = flexmock(Spree::Product.new)
    product.should_receive("on_sale?" => false)

    variant = flexmock(Spree::Variant.new)
    variant.should_receive("item_scheduled_sales.active.not_excluded.blank?" => false)
    variant.should_receive("product" => product)

    assert variant.on_sale?, 'Not on sale'
  end

end
