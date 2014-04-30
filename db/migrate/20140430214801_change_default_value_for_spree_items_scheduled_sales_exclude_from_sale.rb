class ChangeDefaultValueForSpreeItemsScheduledSalesExcludeFromSale < ActiveRecord::Migration
  def change
    change_column_default(:spree_items_scheduled_sales, :exclude_item_from_sale, false)
  end
end
