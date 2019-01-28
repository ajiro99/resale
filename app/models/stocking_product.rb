class StockingProduct < ApplicationRecord
  belongs_to :stocking
  belongs_to :product, optional: true
  belongs_to :sale, optional: true

  extend Enumerize
  enumerize :color, in: { WHITE: 1, SILVER: 2, BLACK: 3, RED: 4 }, scope: true

  scope :in_stock, -> { where(sale_id: nil) }
  scope :body, -> { joins(:product).where('products.type = ?', 'Body') }
  scope :lense, -> { joins(:product).where('products.type = ?', 'Lense') }

  def products_product_id
    product.id
  end

  def product_name
    "#{stocking.purchase_date} / #{stocking.purchase_place} / #{stocking.product_type} / #{product.maker} / #{product.name} / #{color} / #{estimated_price.to_s(:delimited)}"
  end
end
