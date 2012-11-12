class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id,       null: false
      t.float :top,             null: false, default: 0
      t.float :left,            null: false, default: 0
      t.string :last_direction, null: false, default: 'down'
      t.boolean :is_moving,     null: false, default: false

      t.timestamps
    end
  end
end
