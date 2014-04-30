module Spree
  class ItemScheduledSale <  ActiveRecord::Base
    self.table_name = "spree_items_scheduled_sales"
    belongs_to :item, polymorphic: true
    belongs_to :scheduled_sale

    def item_calculated_price
      if item.respond_to?(:price)
        discount_amount = item.price * scheduled_sale.discount_as_percent
        Spree::Money.new(item.price - discount_amount)
      else
        'NA'
      end
    end
  end
end
