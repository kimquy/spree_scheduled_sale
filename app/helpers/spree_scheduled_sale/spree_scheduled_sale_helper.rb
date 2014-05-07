module SpreeScheduledSale
  module SpreeScheduledSaleHelper
    def active_sales
      Spree::ScheduledSale.currently_active
    end
  end
end
