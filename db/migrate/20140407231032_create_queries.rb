class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.text :tweet
      t.integer :tweetId

      t.timestamps
    end
  end
end
