class StockingDecorator < Draper::Decorator
  delegate_all

  def maker
    stocking_products.first&.product&.maker&.capitalize || stocking_products.second&.product&.maker&.capitalize
  end

  def product_name
    stocking_products.map do |stocking_product|
      "#{stocking_product&.product&.name} （#{stocking_product.color&.capitalize}）#{stock_mark(stocking_product.sale_id)}" if stocking_product.product_id.present?
    end.compact.join('<br>')
  end

  def count_text
    "合計　#{count}個"
  end

  def purchase_price_text
    to_delimited(purchase_price)
  end

  def shipping_cost_text
    to_delimited(shipping_cost)
  end

  def use_points_text
    to_delimited(use_points)
  end

  def purchasing_cost_text
    to_delimited(purchasing_cost)
  end

  private

  def stock_mark(sale_id)
    "<li class='fi-shopping-cart stock'></li>" if sale_id.blank?
  end

  def to_delimited(column)
    column&.to_s(:delimited)
  end
end
