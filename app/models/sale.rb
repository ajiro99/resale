class Sale < ApplicationRecord
  attr_accessor :target_body
  attr_accessor :target_lense_1
  attr_accessor :target_lense_2
  has_many :stocking_products
  # accepts_nested_attributes_for :stocking_products,
  #                               allow_destroy: true, reject_if: :all_blank

  extend Enumerize
  enumerize :product_type, in: { レンズキット: 1, ボディ: 2, レンズ: 3, その他: 0 }, scope: true
  enumerize :sales_channel, in: { メルカリ: 1, ヤフオク: 2, その他: 0 }, scope: true
  enumerize :account, in: { メイン: 1, サブ: 2, その他: 0 }, scope: true

  def maker
    stocking_products&.first&.product&.maker
  end

  def product_name
    # sale_products.map { |sale_product| sale_product&.stocking_product&.product&.name}.join(' / ')
  end
end
