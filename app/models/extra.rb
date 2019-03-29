class Extra < ApplicationRecord
  has_many :sale_extras
  scope :display, -> { where(display: true).order(:name) }
  scope :no_display, -> { where(display: false).order(:name) }
end
