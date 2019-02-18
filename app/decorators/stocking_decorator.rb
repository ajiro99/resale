class StockingDecorator < Draper::Decorator
  delegate_all

  def maker
    stocking_products.first&.product&.maker || stocking_products.second&.product&.maker
  end

  def product_name
    stocking_products.map do |stocking_product|
      "#{stocking_product&.product&.name} （#{stocking_product.color}）" if stocking_product.product_id.present?
    end.compact.join('<br>')
  end
end
