class AddUserToStocks < ActiveRecord::Migration[7.1]
  def change
    add_reference :stocks, :user, foreign_key: true
  end
end
