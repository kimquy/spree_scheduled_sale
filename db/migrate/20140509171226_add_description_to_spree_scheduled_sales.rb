class AddDescriptionToSpreeScheduledSales < ActiveRecord::Migration
  def change
    add_column :spree_scheduled_sales, :description, :string
  end
end
