module Spree
  class ScheduledSale <  ActiveRecord::Base
    has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale'

    def discount_as_percent
      return 0.0 unless discount.present?

      discount / 100.to_f
    end
  end
end
