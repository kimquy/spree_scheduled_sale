module Spree
  class ScheduledSale <  ActiveRecord::Base
    has_many :scheduled_sale_descriptions
    has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale'
    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

    WEEKLY_DEAL_DESCRIPTION = 'weekly_deal_description'
    PRODUCT_PRIMARY_DESCRIPTION = 'product_primary_description'
    PRODUCT_SECONDARY_DESCRIPTION = 'product_secondary_description'

    scope :currently_active, lambda{
      where('? between start_date_time and  end_date_time and is_active = ?', Time.current, true)
    }

    def description_for(key)
      scheduled_sale_description = scheduled_sale_descriptions.detect{|d| d.key == key}
      scheduled_sale_description.present? ? scheduled_sale_description.description : nil
    end

    def discount_as_percent
      return 0.0 unless discount.present?

      discount / 100.to_f
    end

    def discount_formatted
      "#{discount}%"
    end

    def min_item_price
      item_scheduled_sales
    end

    def end_date_brief
      end_date_time.present? ? end_date_time.strftime('%A %e/%-m') : ''
    end

    def sale_price_min
      products.map(&:sale_price).compact.min {|a,b|a.cents <=> b.cents}
    end

    def sale_price_max
      products.map(&:sale_price).compact.max{|a,b|a.cents <=> b.cents}
    end

    def regular_price_min
      products.map(&:price).min
    end

    def regular_price_max
      products.map(&:price).max
    end

    def products
      item_scheduled_sales.map(&:products).flatten
    end
  end
end
