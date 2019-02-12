class Product < ApplicationRecord
  extend Enumerize
  enumerize :maker, in: { olympus: 1, nicon: 2, canon: 3, sigma: 4 }, scope: true

  has_many :stocking_products

  def product_name
    "#{maker} / #{name} / #{color}"
  end
end
