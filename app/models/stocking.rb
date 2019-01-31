class Stocking < ApplicationRecord
  has_many :stocking_products, dependent: :destroy
  accepts_nested_attributes_for :stocking_products, allow_destroy: true, reject_if: :all_blank

  extend Enumerize
  enumerize :product_type, in: { レンズキット: 1, ボディ: 2, レンズ: 3, ダブルレンズキット: 4, その他:0 }, scope: true
  enumerize :payment_type, in: { Yahoo: 1, P_One: 2, Amex: 3, 現金:0 }, scope: true
  enumerize :purchase_place, in: { ヤフオク: 1, メルカリ: 2, キタムラ: 20, ハードオフ:21, アキバU_shop:22, ソフマップ:23 }, scope: true

  def self.total_purchase_price
    sum(:purchase_price).to_s(:delimited)
  end

  def self.total_shipping_cost
    sum(:shipping_cost).to_s(:delimited)
  end

  def self.total_use_point
    sum(:use_points).to_s(:delimited)
  end

  def self.purchasing_cost
    sum(:purchasing_cost).to_s(:delimited)
  end
end
