class AddUniqueIndexToStocksTicker < ActiveRecord::Migration[7.1]
  def change
    add_index :stocks, "LOWER(ticker)", unique: true, name: "index_stocks_on_lower_ticker"
  end
end
