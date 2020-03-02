class AddMultiverseIdToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :multiverse_id, :int
  end
end
