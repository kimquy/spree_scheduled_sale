module Spree
  class ScheduledSalesController < Spree::StoreController
    def show
      @scheduled_sale = Spree::ScheduledSale.find params[:id]
    end
  end
end
