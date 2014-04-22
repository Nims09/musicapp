class RenameTimeDelta < ActiveRecord::Migration
  def change
  	rename_table :time_delta, :time_deltas
  end
end
