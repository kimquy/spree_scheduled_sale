module Spree
  class ItemScheduledSale <  ActiveRecord::Base
    self.table_name = "spree_items_scheduled_sales"
    belongs_to :item, polymorphic: true
    belongs_to :scheduled_sale

    def item_calculated_price
      if item.respond_to?(:price)
        discount_amount = item.price * scheduled_sale.discount_as_percent
        Spree::Money.new(item.price - discount_amount, { currency: currency })
      else
        'NA'
      end
    end

    def override_price=(val)
      self.override_price_as_cents = val
    end

    # def override_price
    #   Spree::Money.new(override_price_as_cents || 0.0, { currency: currency })
    # end

    def currency
      item.present? ? item.currency : Spree::Config[:currency]
    end

  end
end
