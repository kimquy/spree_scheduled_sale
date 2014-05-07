module Spree
  class ScheduledSale <  ActiveRecord::Base
    has_many :item_scheduled_sales, :class_name => 'Spree::ItemScheduledSale'
    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

    scope :currently_active, lambda{
      where('? between start_date_time and  end_date_time', Time.current)
    }


    def discount_as_percent
      return 0.0 unless discount.present?

      discount / 100.to_f
    end
  end
end
