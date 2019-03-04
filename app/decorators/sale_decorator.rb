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

  def monthly_sales_date
    sales_date.strftime('%-m月')
  end

  def year_sales_date
    sales_date.strftime('%Y年')
  end

  def selling_price_text
    to_delimited(selling_price)
  end

  def profit_text
    to_delimited(profit)
  end

  def stocking_price_text
    to_delimited(stocking_price)
  end

  def bonus_price_text
    to_delimited(bonus_price)
  end

  def cost_text
    to_delimited(cost)
  end

  def selling_price_text
    to_delimited(selling_price)
  end

  def fee_text
    to_delimited(fee)
  end

  def shipping_cost_text
    to_delimited(shipping_cost)
  end

  def profit_rate_text
    to_percentage(profit, selling_price)
  end

  private

  def to_delimited(column)
    column.to_s(:delimited)
  end

  def to_percentage(target, source)
    ActionController::Base.helpers.number_to_percentage(
      target.fdiv(source) * 100, precision: 2
    )
  end
end
