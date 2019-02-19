class SaleDecorator < Draper::Decorator
  delegate_all

  def maker
    stocking_products&.first&.product&.maker&.capitalize
  end

  def product_name
    stocking_products.map do |stocking_product|
      "#{stocking_product&.product&.name} （#{stocking_product.color&.capitalize}）" if stocking_product.product_id.present?
    end.compact.join('<br>')
  end
end
