
Spree::Product.class_eval do
  has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale', :as => :item

  def on_sale?
    product_on_sale? || taxon_on_sale? || any_variant_on_sale
  end

  :protected
  def product_on_sale?
    !item_scheduled_sales.active.blank?
  end

  def taxon_on_sale?
    !Spree::ItemScheduledSale.by_taxon(taxons.map(&:id)).blank?
  end

  def any_variant_on_sale
    variants.any? {|v| !v.item_schedule_sales.active.blank}
  end
end