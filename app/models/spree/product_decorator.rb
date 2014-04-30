Spree::Product.class_eval do
  has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale', :as => :item

  def on_sale?
    taxon_on_sale? || product_on_sale? || any_variant_on_sale
  end

  # :protected
  def product_on_sale?
    !item_scheduled_sales.active.not_excluded.blank?
  end

  def taxon_on_sale?
    taxon_sales = Spree::ItemScheduledSale.by_taxon(taxons.map(&:id))

    !taxon_sales.blank? &&
        !product_excluded_from_any_sale?(taxon_sales)
  end

  def any_variant_on_sale
    variants.any? {|v| !v.item_schedule_sales.active.blank}
  end

  def product_excluded_from_any_sale?(taxon_sales)
    item_scheduled_sales.active.any? do |product_sale|
      product_sale.exclude_item_from_sale? &&
          taxon_sales.any? do |taxon_sale|
            product_sale.scheduled_sale == taxon_sale.scheduled_sale
          end
    end
  end

end