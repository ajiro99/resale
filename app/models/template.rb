class Template < ApplicationRecord
  extend Enumerize
  enumerize :category, in: { wifi: 1, no_wifi: 2, lense: 3 }, scope: true
end
