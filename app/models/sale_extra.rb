class SaleExtra < ApplicationRecord
  belongs_to :sale, optional: true
  belongs_to :extra, optional: true
end
