class StockingProductsDecorator < Draper::CollectionDecorator
  def total_count
    total(:count)
  end

  def total_estimated_price
    total(:estimated_price)
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
