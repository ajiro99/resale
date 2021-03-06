class SaleDecorator < Draper::Decorator
  delegate_all

  def maker
    stocking_products&.first&.product&.maker&.capitalize
  end

  def product_name
    stocking_products.map do |stocking_product|
      "#{stocking_product&.product&.name} （#{stocking_product.color_text}）" if stocking_product.product_id.present?
    end.compact.join('<br>')
  end

  def monthly_sales_date
    return '合計' if sales_date == 999
    sales_date.strftime('%-m月')
  end

  def year_sales_date
    return '合計' if sales_date == 999
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

  def count_text
    "合計　#{count}個"
  end

  def sale_of_monthly_average_count(size)
    return 0 if size.zero?

    count / size
  end

  def sale_of_monthly_average_selling_price(size)
    return 0 if size.zero?

    to_delimited(selling_price / size)
  end

  def sale_of_monthly_average_profit(size)
    return 0 if size.zero?

    to_delimited(profit / size)
  end

  def sale_of_monthly_average_unit_profit
    return 0 if count.zero?

    to_delimited(profit / count)
  end

  def sale_of_monthly_average_profit_rate
    to_percentage(profit, selling_price)
  end

  def unit_profit_text
    to_delimited(profit / count)
  end

  private

  def to_delimited(column)
    column&.to_s(:delimited)
  end

  def to_percentage(target, source)
    return if target.blank? || source.blank?
    ActionController::Base.helpers.number_to_percentage(
      target.fdiv(source) * 100, precision: 2
    )
  end
end
