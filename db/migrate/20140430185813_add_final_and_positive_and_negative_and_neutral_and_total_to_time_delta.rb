class AddFinalAndPositiveAndNegativeAndNeutralAndTotalToTimeDelta < ActiveRecord::Migration
  def change
    add_column :time_deltas, :final, :integer
    add_column :time_deltas, :positive, :integer
    add_column :time_deltas, :negative, :integer
    add_column :time_deltas, :neutral, :integer
    add_column :time_deltas, :total, :integer
  end
end
