class CreateDelta < ActiveRecord::Migration
  def change
    create_table :delta do |t|
      t.datetime :start
      t.integer :length
      t.references :stock, index: true

      t.timestamps
    end
  end
end
