class SalesDecorator < Draper::CollectionDecorator
  def this_month_progress
    achievement_rate = to_percentage(object.sum(:profit), 50_000)
    progress_diff = ActionController::Base.helpers.number_to_currency(
      object.sum(:profit) - 50_000 / Date.new.end_of_month.mday * Time.zone.now.mday,
      format: '+%n円', negative_format: '%n円の遅れ'
    )
    "今月の売上　目標達成率：#{achievement_rate}（#{progress_diff}）"
  end

  def with_account_main_size
    with_account_main.size
  end

  def with_account_main_total_selling_price
    with_account_main.sum(:selling_price).to_s(:delimited)
  end

  def with_account_main_total_profit
    with_account_main.sum(:profit).to_s(:delimited)
  end

  def with_account_main_total_profit_rate
    to_percentage(with_account_main.sum(:profit), with_account_main.sum(:selling_price))
  end

  def with_account_sub_size
    with_account_sub.size
  end

  def with_account_sub_total_selling_price
    with_account_sub.sum(:selling_price).to_s(:delimited)
  end

  def with_account_sub_total_profit
    with_account_sub.sum(:profit).to_s(:delimited)
  end

  def with_account_sub_total_profit_rate
    to_percentage(with_account_sub.sum(:profit), with_account_sub.sum(:selling_price))
  end

  def total_selling_price
    object.sum(:selling_price).to_s(:delimited)
  end

  def total_profit
    object.sum(:profit).to_s(:delimited)
  end

  def total_profit_rate
    to_percentage(object.sum(:profit), object.sum(:selling_price))
  end

  def total_stocking_price
    object.sum(:stocking_price).to_s(:delimited)
  end

  def total_bonus_price
    object.sum(:bonus_price).to_s(:delimited)
  end

  def total_cost
    object.sum(:cost).to_s(:delimited)
  end

  def total_fee
    object.sum(:fee).to_s(:delimited)
  end

  def total_shipping_cost
    object.sum(:shipping_cost).to_s(:delimited)
  end

  private

  def total(column)
    object.sum(:shipping_cost).to_s(:delimited)
  end

  def with_account_main
    object.with_account(:main)
  end

  def with_account_sub
    object.with_account(:sub)
  end

  def to_percentage(target_value, source_value)
    ActionController::Base.helpers.number_to_percentage(
      target_value.fdiv(source_value) * 100, precision: 2
    )
  end
end
