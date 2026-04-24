class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :stock, optional: true
  has_many :messages, dependent: :destroy
end
