class StockingProductsDecorator < Draper::CollectionDecorator
  def total_count
    total(:count)
  end

  def total_estimated_price
    total(:estimated_price)
  end

  def oldest_stock
    " 一番古い在庫：#{Stocking.stock.order(:purchase_date).first&.purchase_date&.strftime('%-m月%d日')}"
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
