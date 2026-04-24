class Stock < ApplicationRecord
  has_many :chats, dependent: :null
  validates :ticker, presence: true
end
