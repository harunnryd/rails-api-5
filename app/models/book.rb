class Book < ApplicationRecord
  belongs_to :author
  monetize :price_cents

  validates :title, presence: true
end
