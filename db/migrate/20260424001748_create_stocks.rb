class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :ticker, null: false
      t.string :company_name
      t.text :notes
      t.decimal :target_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
