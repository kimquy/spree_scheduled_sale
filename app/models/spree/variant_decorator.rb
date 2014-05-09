Spree::Variant.class_eval do
  has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale', :as => :item

end