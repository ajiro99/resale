class Stocking < ApplicationRecord
  has_many :stocking_products, dependent: :destroy
  accepts_nested_attributes_for :stocking_products, allow_destroy: true, reject_if: :all_blank

  extend Enumerize
  enumerize :product_type, in: { レンズキット: 1, ボディ: 2, レンズ: 3, ダブルレンズキット: 4, その他:0 }, scope: true
  enumerize :payment_type, in: { Yahoo: 1, P_One: 2, Amex: 3, 現金:0 }, scope: true
  enumerize :purchase_place, in: { ヤフオク: 1, メルカリ: 2, キタムラ: 20, ハードオフ:21, アキバU_shop:22, ソフマップ:23 }, scope: true

  def maker
    stocking_products.first&.product&.maker
  end

  def product_name
    stocking_products.map { |stocking_product| stocking_product&.product&.name}.join(' / ')
  end
end
