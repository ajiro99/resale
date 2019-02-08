class Sale < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  attr_accessor :target_body
  attr_accessor :target_lense_1
  attr_accessor :target_lense_2
  has_many :stocking_products
  has_many :sale_extras
  accepts_nested_attributes_for :sale_extras, allow_destroy: true, reject_if: :all_blank

  extend Enumerize
  enumerize :product_type, in: { レンズキット: 1, ボディ: 2, レンズ: 3, その他: 0 }, scope: true
  enumerize :sales_channel, in: { メルカリ: 1, ヤフオク: 2, その他: 0 }, scope: true
  enumerize :account, in: { メイン: 1, サブ: 2, その他: 0 }, scope: true

  def self.total_stocking_price
    sum(:stocking_price).to_s(:delimited)
  end

  def self.total_bonus_price
    sum(:bonus_price).to_s(:delimited)
  end

  def self.total_cost
    sum(:cost).to_s(:delimited)
  end

  def self.total_selling_price
    sum(:selling_price).to_s(:delimited)
  end

  def self.total_fee
    sum(:fee).to_s(:delimited)
  end

  def self.total_shipping_cost
    sum(:shipping_cost).to_s(:delimited)
  end

  def self.total_sales
    sum(:sales).to_s(:delimited)
  end

  def self.total_profit
    sum(:profit).to_s(:delimited)
  end

  def self.total_profit_rate
    ActionController::Base.helpers.number_to_percentage(sum(:profit).fdiv(sum(:selling_price)) * 100, precision: 2)
  end
end
