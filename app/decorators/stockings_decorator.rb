class StockingsDecorator < Draper::CollectionDecorator

  def total_count
    total(:count)
  end

  def total_use_points
    total(:use_points)
  end

  def total_purchasing_cost
    total(:purchasing_cost)
  end

  def self.select_payment_types
    Stocking.payment_type.find_values(*Stocking.payment_type.values.map(&:to_sym)).map do |payment_type|
      [payment_type.text, payment_type.value]
    end
  end

  def self.select_purchase_places
    Stocking.purchase_place.find_values(*Stocking.purchase_place.values.map(&:to_sym)).map do |purchase_place|
      [purchase_place.text, purchase_place.value]
    end
  end

  private

  def total(column)
    total = 0
    object.map do |sale|
      total += sale.send(column)
    end
    total.to_s(:delimited)
  end
end
