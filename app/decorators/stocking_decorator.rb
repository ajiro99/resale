class StockingDecorator < Draper::Decorator
  delegate_all

  def maker
    stocking_products.first&.product&.maker || stocking_products.second&.product&.maker
  end

  def product_name
    stocking_products.map do |stocking_product|
      stocking_product&.product&.name if stocking_product.product_id.present?
    end.compact.join('<br>')
  end

  def total_use_points
    sum(:use_points).to_s(:delimited)
  end
end
