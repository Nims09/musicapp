class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.text :name
      t.text :hashtag

      t.timestamps
    end
  end
end
