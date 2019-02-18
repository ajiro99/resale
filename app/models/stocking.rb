class Stocking < ApplicationRecord
  before_destroy :check_saled

  has_many :stocking_products, dependent: :destroy
  accepts_nested_attributes_for :stocking_products, allow_destroy: true, reject_if: :all_blank

  scope :stock, -> { joins(:stocking_products).where('stocking_products.product_id is not null').where('stocking_products.sale_id is null') }

  extend Enumerize
  enumerize :product_type, in: { lense_kit: 1, body: 2, lense: 3, w_lense_kit: 4, other: 0 }, scope: true
  enumerize :payment_type, in: { yahoo: 1, p_one: 2, amex: 3, cash: 0 }, scope: true
  enumerize :purchase_place, in: { yahoo_auctions: 1, mercari: 2, kitamura: 20, hard_off: 21, soff_map: 23, other: 0 }, scope: true

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

  def self.ransackable_scopes(auth_object = nil)
    %i[stock]
  end

  private

  def check_saled
    return true if stocking_products.in_stock.size == 3
    errors.add(:base, 'この商品は売却されている為、削除できません')
    throw :abort
  end
end
