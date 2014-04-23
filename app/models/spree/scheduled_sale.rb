module Spree
  class ScheduledSale <  ActiveRecord::Base
    has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale'
  end
end
