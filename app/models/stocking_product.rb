class StockingProduct < ApplicationRecord
  belongs_to :stocking
  belongs_to :product

  extend Enumerize
  enumerize :stock, in: { 在庫あり: 1, 在庫なし:0 }, scope: true
  enumerize :color, in: { WHITE: 1, SILVER: 2, BLACK: 3, RED: 4 }, scope: true

  scope :body_in_stock, -> { StockingProduct.joins(:product).where('products.type = ?', "Body").with_stock(:在庫あり) }
  scope :lense_in_stock, -> { StockingProduct.joins(:product).where('products.type = ?', "Lense").with_stock(:在庫あり) }

  def products_product_id
    product.id
  end

  # def product_name
  #   "#{stocking.purchase_date} / #{stocking.purchase_place} / #{stocking.product_type} / #{product.maker} / #{product.name} / #{product.color} / #{estimated_price.to_s(:delimited)}"
  # end
end
