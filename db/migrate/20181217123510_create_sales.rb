class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.date :sales_date
      t.integer :product_type
      t.integer :stocking_price
      t.integer :bonus_price
      t.integer :cost
      t.integer :selling_price
      t.integer :fee
      t.integer :shipping_cost
      t.integer :sales
      t.integer :profit
      t.decimal :profit_rate, precision: 5, scale: 2
      t.integer :status
      t.string :remarks

      t.timestamps
    end
  end
end
