module Spree
  module Admin
    module ScheduledSales
      class ScheduledSaleDescriptionsController < ResourceController
        belongs_to 'spree/scheduled_sale', :find_by => :id

        def index

        end

        def create
          @scheduled_sale = Spree::ScheduledSale.find params[:scheduled_sale_id]
          @scheduled_sale.scheduled_sale_descriptions.create!(scheduled_sale_descriptions_params)
          redirect_to edit_admin_scheduled_sale_path(id: @scheduled_sale.id)
        end

        :protected
        def scheduled_sale_descriptions_params
           params.require(:scheduled_sale_description).permit(:key, :description)
        end

        def collection_url(options = {})
           edit_admin_scheduled_sale_url(:id => parent.id)
        end
      end
    end
  end
end
