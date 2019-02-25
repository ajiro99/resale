class Sale < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  attr_accessor :target_body
  attr_accessor :target_lense_1
  attr_accessor :target_lense_2
  has_many :stocking_products
  has_many :sale_extras
  accepts_nested_attributes_for :sale_extras, allow_destroy: true, reject_if: :all_blank

  scope :this_month, -> { where(sales_date: Time.now.all_month) }
  scope :this_year, -> { where(sales_date: Time.now.all_year) }

  extend Enumerize
  enumerize :product_type, in: { lense_kit: 1, body: 2, lense: 3, w_lense_kit: 4, other: 0 }, scope: true
  enumerize :sales_channel, in: { mercari: 1, yahoo_auctions: 2, other: 0 }, scope: true
  enumerize :account, in: { main: 1, sub: 2, other: 0 }, scope: true
  enumerize :shipping_type, in: { compact_445: 445, post_600: 600, post_700: 700 }, scope: true
  enumerize :state, in: {
    new: 1, close_to_unused: 2, no_scratch: 3, slightly_scratched: 4, with_scratches: 5, bad_condition: 6
  }, scope: true

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
