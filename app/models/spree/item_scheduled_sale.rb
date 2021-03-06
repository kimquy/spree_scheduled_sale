module Spree
  class ItemScheduledSale <  ActiveRecord::Base
    self.table_name = "spree_items_scheduled_sales"
    belongs_to :item, polymorphic: true
    belongs_to :scheduled_sale

    scope :active, lambda{
      joins(:scheduled_sale).where('spree_scheduled_sales.is_active = ?', true)
    }

    scope :excluded, lambda{
      where('exclude_item_from_sale = ?', true)
    }

    scope :not_excluded, lambda{
      where('exclude_item_from_sale = ?', false)
    }

    scope :by_taxon, lambda{ |taxon_ids|
      {
          :conditions => ["item_type = 'Spree::Taxon' and item_id in (?)", taxon_ids ]
      }
    }

    def item_calculated_price
      if item.respond_to?(:orig_price)
        discount_amount = item.orig_price * scheduled_sale.discount_as_percent
        Spree::Money.new(item.orig_price - discount_amount, { currency: currency })
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

    def products
      return item.products if item.respond_to?(:products)
      [item]
    end

  end
end
