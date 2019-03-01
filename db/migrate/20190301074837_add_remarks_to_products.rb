class AddRemarksToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :remarks, :string, after: :name
  end
end
