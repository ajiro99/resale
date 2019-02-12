module ApplicationHelper
  def date_text(date)
    date.strftime('%Y年%-m月%-d日')
  end

  def new_action?
    controller.action_name == 'new'
  end

  def select_product_types
    Sale.product_type.find_values(*Sale.product_type.values.map(&:to_sym)).map do |product_type|
      [product_type.text, product_type.value]
    end
  end

  def select_product_makers
    Product.maker.find_values(*Product.maker.values.map(&:to_sym)).map do |product_maker|
      [product_maker.text, product_maker.value]
    end
  end

  def select_payment_types
    Stocking.payment_type.find_values(*Stocking.payment_type.values.map(&:to_sym)).map do |payment_type|
      [payment_type.text, payment_type.value]
    end
  end

  def select_purchase_places
    Stocking.purchase_place.find_values(*Stocking.purchase_place.values.map(&:to_sym)).map do |purchase_place|
      [purchase_place.text, purchase_place.value]
    end
  end

  def defalt_date
    Time.now.strftime('%Y-%m-%d')
  end
end
