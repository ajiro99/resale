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

  private

  def total(column)
    total = 0
    object.map do |sale|
      total += sale.send(column)
    end
    total.to_s(:delimited)
  end
end
