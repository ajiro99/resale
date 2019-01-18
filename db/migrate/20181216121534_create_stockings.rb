class CreateStockings < ActiveRecord::Migration[5.2]
  def change
    create_table :stockings do |t|
      t.date :purchase_date
      t.integer :product_type
      t.integer :purchase_price
      t.integer :shipping_cost
      t.integer :use_points
      t.integer :purchasing_cost
      t.integer :payment_type
      t.integer :purchase_place
      t.string :remarks

      t.timestamps
    end
  end
end
