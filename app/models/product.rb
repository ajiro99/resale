class Product < ApplicationRecord
  extend Enumerize
  enumerize :maker, in: { olympus: 1, nicon: 2, canon: 3, panasonic: 4 }, scope: true

  has_many :stocking_products
end
