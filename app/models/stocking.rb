class Stocking < ApplicationRecord
  before_destroy :check_saled

  has_many :stocking_products, dependent: :destroy
  accepts_nested_attributes_for :stocking_products, allow_destroy: true, reject_if: :all_blank

  scope :stock, -> { joins(:stocking_products).where('stocking_products.product_id is not null').where('stocking_products.sale_id is null') }
  scope :this_month, -> { where(purchase_date: Time.now.all_month) }
  scope :this_year, -> { where(purchase_date: Time.now.all_year) }

  extend Enumerize
  enumerize :product_type, in: { lense_kit: 1, body: 2, lense: 3, w_lense_kit: 4, other: 0 }, scope: true
  enumerize :payment_type, in: { yahoo: 1, p_one: 2, amex: 3, point: 4, smart_phone_pay: 5, kyash: 6, cash: 0, rakuten: 7 }, scope: true
  enumerize :purchase_place, in: {
    yahoo_auctions: 1, mercari: 2, rakuten: 3, yahoo_shopping: 4, kitamura: 20, hard_off: 21, other: 0, total: 999
  }, scope: true

  def self.ransackable_scopes(auth_object = nil)
    %i[stock]
  end

  def self.to_csv stockings
    CSV.generate do |csv|
      csv << %i(購入日時 商品タイプ 商品名 販売価格 送料 ポイント利用 購入金額)
      stockings.each do |stocking|
        csv << [
          stocking.purchase_date, stocking.product_type_text, stocking.product_name.gsub('<br>', ' ').gsub("<li class='fi-shopping-cart stock'></li>", ''),
          stocking.purchase_price, stocking.shipping_cost, stocking.use_points, stocking.purchasing_cost
        ]
      end
    end
  end

  private

  def check_saled
    return true if stocking_products.where(sale_id: nil).size == 3
    errors.add(:base, 'この商品は売却されている為、削除できません')
    throw :abort
  end
end
