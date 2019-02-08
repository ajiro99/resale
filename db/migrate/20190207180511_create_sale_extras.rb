class CreateSaleExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_extras do |t|
      t.references :sale, foreign_key: true
      t.references :extra, foreign_key: true

      t.timestamps
    end
  end
end
