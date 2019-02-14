class CreateStockings < ActiveRecord::Migration[5.2]
  def change
    create_table :stockings do |t|
      t.date :purchase_date
      t.integer :product_type
      t.integer :purchase_price
      t.integer :shipping_cost, default: 0
      t.integer :use_points, default: 0
      t.integer :purchasing_cost, default: 0
      t.integer :payment_type
      t.integer :purchase_place
      t.boolean :refund
      t.string :remarks

      t.timestamps
    end
  end
end
