class AddSpreeScheduledSalesDescriptions < ActiveRecord::Migration
  def change
    create_table :spree_scheduled_sale_descriptions do |t|
      t.string :key
      t.text :description
      t.timestamps
    end

  end
end
