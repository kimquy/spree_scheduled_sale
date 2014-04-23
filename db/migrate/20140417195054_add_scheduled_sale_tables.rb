class AddScheduledSaleTables < ActiveRecord::Migration
  def change
    create_table :spree_scheduled_sales do |t|
      t.string :name
      t.string :title
      t.string :permalink
      t.attachment :image
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.boolean :clearance, default: false
      t.boolean :weekly_sale, default: false
      t.boolean :is_active, default: true
      t.integer :discount
      t.timestamps
    end

    create_table :spree_items_scheduled_sales do |t|
      t.integer :spree_scheduled_sales_id
      t.integer :item_id
      t.string :item_type
      t.integer :override_price_as_cents
      t.boolean :exclude_item_from_sale, :default => true
      t.timestamps
    end

    create_table :spree_items_scheduled_description_placements do |t|
      t.integer :spree_scheduled_sales_id
      t.integer :spree_scheduled_sales_placement_location_id
      t.text :description
      t.boolean :exclude_item_from_sale, :default => true
      t.timestamps
    end

    create_table :spree_scheduled_sales_placement_locations do |t|
      t.string :description
      t.timestamps
    end
  end
end
