class CreateExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :extras do |t|
      t.string :name
      t.integer :price
      t.boolean :display
      t.string :remarks

      t.timestamps
    end
  end
end
