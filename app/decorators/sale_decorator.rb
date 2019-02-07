class SaleDecorator < Draper::Decorator
  delegate_all

  def maker
    stocking_products&.first&.product&.maker
  end

  def product_name
    # sale_products.map { |sale_product| sale_product&.stocking_product&.product&.name}.join(' / ')

    stocking_products.map do |stocking_product|
      stocking_product&.product&.name if stocking_product.product_id.present?
    end.compact.join('<br>')
  end
end
