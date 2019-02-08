class Extra < ApplicationRecord
  has_many :sale_extras
  scope :display, -> { where(display: true) }
end
