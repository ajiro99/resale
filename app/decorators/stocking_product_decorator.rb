class StockingProductDecorator < Draper::Decorator
  delegate_all

  def product_type_text
    {
      'Body' => 'ボディ',
      'Lense' => 'レンズ'
    }.fetch(product_type)
  end

  def estimated_price_text
    to_delimited(estimated_price)
  end

  private

  def to_delimited(column)
    column&.to_s(:delimited)
  end
end
