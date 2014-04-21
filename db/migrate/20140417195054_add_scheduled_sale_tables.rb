class AddScheduledSaleTables < ActiveRecord::Migration
  def change
    create_table :spree_scheduled_sales do |t|
      t.string :name
      t.string :title
      t.text :description
      t.text :description2
      t.string :permalink
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_active, default: true
      t.integer :discount
      t.timestamps
    end
    create_table :spree_items_scheduled_sales do |t|
      t.string :name

    end
  end
end
