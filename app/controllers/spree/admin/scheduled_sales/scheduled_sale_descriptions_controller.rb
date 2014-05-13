module Spree
  module Admin
    module ScheduledSales
      class ScheduledSaleDescriptionsController < ResourceController
        belongs_to 'spree/scheduled_sale', :find_by => :id

        def index

        end

        def create
          # @scheduled_sale = Spree::ScheduledSale.find params[:scheduled_sale_id]
          # @scheduled_sale.item_scheduled_sales.create!(item_scheduled_sales_params)
        end

        :protected
        def item_scheduled_sales_params
          # params.require(:item_scheduled_sale).permit(:item_id, :item_type)
        end

        def collection_url(options = {})
          # edit_admin_scheduled_sale_url(:id => parent.id)
        end
      end
    end
  end
end
