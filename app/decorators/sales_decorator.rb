class SalesDecorator < Draper::CollectionDecorator

  def total_profit
    object[object.size - 1]&.profit.presence || 0
  end

  def this_month_progress
    achievement_rate = to_percentage(total_profit, 50_000)
    progress_diff = ActionController::Base.helpers.number_to_currency(
      total_profit - 50_000 / Date.new.end_of_month.mday * Time.zone.now.mday,
      format: '%n円のリード', negative_format: '%n円の遅れ'
    )
    "今月の売上　目標達成率：#{achievement_rate}（#{progress_diff}）"
  end

  def by_year_sales_title
    "年別の売上　コンテンツ利益：#{(total_profit - 350_000).to_s(:delimited)}円"
  end

  def self.select_sale_shipping_types
    Sale.shipping_type.find_values(*Sale.shipping_type.values.map(&:to_sym)).map do |shipping_type|
      [shipping_type.text, shipping_type.value]
    end
  end

  def self.select_sale_states
    Sale.state.find_values(*Sale.state.values.map(&:to_sym)).map do |state|
      [state.text, state.value]
    end
  end

  def self.select_sale_sales_channel
    Sale.sales_channel.find_values(*Sale.sales_channel.values.map(&:to_sym)).map do |sales_channel|
      [sales_channel.text, sales_channel.value]
    end
  end

  def self.select_sale_account_channel
    Sale.account.find_values(*Sale.account.values.map(&:to_sym)).map do |account|
      [account.text, account.value]
    end
  end

  private

  def to_percentage(target_value, source_value)
    return if target_value.blank?
    ActionController::Base.helpers.number_to_percentage(
      target_value.fdiv(source_value) * 100, precision: 2
    )
  end
end
