module Spree
  module Admin
    class ScheduledSalesController < ResourceController

      def index

      end

      def new

      end

      def items_search
        search = params[:item_type].constantize.search(:name_cont => params[:name])
        render :json => search.result.map{|r| {id: r.id,   label: (r.respond_to?(:name_and_sku) ? r.name_and_sku : r.name)}}
      end
    end
  end
end
