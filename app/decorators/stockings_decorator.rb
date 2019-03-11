class StockingsDecorator < Draper::CollectionDecorator

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
end
