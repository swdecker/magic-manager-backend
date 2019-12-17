class CreateUserCards < ActiveRecord::Migration[6.0]
  def change
    create_table :user_cards do |t|
      t.references :card, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :num_owned
      
      t.timestamps
    end
  end
end
