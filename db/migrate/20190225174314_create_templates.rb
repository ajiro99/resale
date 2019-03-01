class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.integer :category
      t.string :description

      t.timestamps
    end
  end
end
