Spree::Variant.class_eval do
  has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale', :as => :item

  def on_sale?
    !item_scheduled_sales.active.not_excluded.blank?
  end

  def sale_price
    on_sale? ? derived_sale_price : nil
  end

  :protected
  def derived_sale_price
    discount_amount = price * best_active_discount_amount_as_percent
    Spree::Money.new(price - discount_amount, { currency: currency })
  end

  def best_active_discount_amount_as_percent
    return 0.0 unless best_active_discount_amount.present?

    best_active_discount_amount / 100.to_f
  end

  def best_active_discount_amount
    active_sales.map{|sale| sale.discount}.compact.max
  end

  def active_sale_items
    item_scheduled_sales.select{|item_sale| item_sale.scheduled_sale.is_active? && !item_sale.exclude_item_from_sale?}
  end

  def active_sales
    active_sale_items.map{|item_sale| item_sale.scheduled_sale}
  end

end