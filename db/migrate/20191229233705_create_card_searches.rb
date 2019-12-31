class CreateCardSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :card_searches do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
