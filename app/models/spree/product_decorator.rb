Spree::Product.class_eval do
  has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale', :as => :item

  def on_sale?
    taxon_on_sale? || product_on_sale? || any_variant_on_sale
  end

  def sale_price
    on_sale? ? derived_sale_price : nil
  end

  alias_method :orig_price_in, :price_in
  def price_in(currency)
    on_sale? ? derived_sale_price : orig_price_i(currency)
  end

  def sale_amount
    discount_amount = price * best_active_discount_amount_as_percent
  end

  def active_scheduled_sale
    return nil unless on_sale?

    active_sales.first
  end

  # :protected
  def derived_sale_price
    best_active_override_amount.present? ? best_active_override_amount : calculated_price
  end

  def calculated_price
    discount_amount = sale_amount
    Spree::Money.new(price - discount_amount, { currency: currency })
  end

  def product_on_sale?
    !item_scheduled_sales.active.not_excluded.blank?
  end

  def taxon_on_sale?
    taxon_sales = Spree::ItemScheduledSale.by_taxon(taxons.map(&:id))

    !taxon_sales.blank? &&
        !product_excluded_from_all_sale?(taxon_sales)
  end

  def any_variant_on_sale
    variants.any? {|v| !v.item_scheduled_sales.active.blank?}
  end

  def best_active_override_amount
    active_sale_items.map{|sale| sale.override_price_as_cents}.compact.min
  end

  def best_active_discount_amount
    active_sales.map{|sale| sale.discount}.compact.max
  end

  def best_derived_price
    active_sales.map{|sale| sale.discount}.max
  end

  def active_sale_items
    item_scheduled_sales.select{|item_sale| item_sale.scheduled_sale.is_active? && !item_sale.exclude_item_from_sale?}
  end

  def active_sales
    active_sale_items.map{|item_sale| item_sale.scheduled_sale}
  end

  def best_active_discount_amount_as_percent
    return 0.0 unless best_active_discount_amount.present?

    best_active_discount_amount / 100.to_f
  end

  def product_excluded_from_all_sale?(taxon_sales)
    item_scheduled_sales.active.all? do |product_sale|
      product_sale.exclude_item_from_sale? &&
          taxon_sales.all? do |taxon_sale|
            product_sale.scheduled_sale == taxon_sale.scheduled_sale
          end
    end
  end

end