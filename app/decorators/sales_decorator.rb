class SalesDecorator < Draper::CollectionDecorator
  def this_month_progress
    profit = remove_comma(total_profit)
    achievement_rate = to_percentage(profit, 50_000)
    progress_diff = ActionController::Base.helpers.number_to_currency(
      profit - 50_000 / Date.new.end_of_month.mday * Time.zone.now.mday,
      format: '+%n円', negative_format: '%n円の遅れ'
    )
    "今月の売上　目標達成率：#{achievement_rate}（#{progress_diff}）"
  end

  def total_count
    total(:count)
  end

  def total_selling_price
    total(:selling_price)
  end

  def total_profit
    total(:profit)
  end

  def total_profit_rate
    to_percentage(remove_comma(total_profit), remove_comma(total_selling_price))
  end

  private

  def total(column)
    total = 0
    object.map do |sale|
      total += sale.send(column)
    end
    total.to_s(:delimited)
  end

  def remove_comma(target)
    target.gsub(/(\d{0,3}),(\d{3})/, '\1\2').to_i
  end

  def to_percentage(target_value, source_value)
    ActionController::Base.helpers.number_to_percentage(
      target_value.fdiv(source_value) * 100, precision: 2
    )
  end
end
