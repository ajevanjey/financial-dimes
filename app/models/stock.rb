class Stock < ApplicationRecord
  has_many :chats, dependent: :nullify
  validates :ticker, presence: true, uniqueness: { case_sensitive: false }
end
