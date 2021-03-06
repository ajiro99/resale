class CreateStockingProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :stocking_products do |t|
      t.references :stocking, foreign_key: true
      t.references :product, foreign_key: true
      t.references :sale, foreign_key: true
      t.integer :estimated_price, default: 0
      t.integer :color
      t.boolean :janck

      t.timestamps
    end
  end
end
