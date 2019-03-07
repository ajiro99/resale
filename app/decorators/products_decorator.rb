class ProductsDecorator < Draper::CollectionDecorator
  def self.select_product_types
    Sale.product_type.find_values(*Sale.product_type.values.map(&:to_sym)).map do |product_type|
      [product_type.text, product_type.value]
    end
  end

  def self.select_product_makers
    Product.maker.find_values(*Product.maker.values.map(&:to_sym)).map do |product_maker|
      [product_maker.text, product_maker.value]
    end
  end
end
