class Stock < ApplicationRecord
  belongs_to :user, optional: true
  has_many :chats, dependent: :nullify

  validates :ticker, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
end
