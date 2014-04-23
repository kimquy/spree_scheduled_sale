module Spree
  class ItemScheduledSale <  ActiveRecord::Base
    self.table_name = "spree_items_scheduled_sales"
    belongs_to :item, polymorphic: true
    belongs_to :scheduled_sale
  end
end
