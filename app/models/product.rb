class Product < ApplicationRecord
  extend Enumerize
  enumerize :maker, in: { OLYMPUS: 1, NICON: 2, CANON: 3, SIGMA: 4 }, scope: true

  def product_name
    "#{maker} / #{name} / #{color}"
  end
end
