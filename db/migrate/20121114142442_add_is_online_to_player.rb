class AddIsOnlineToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :is_online, :boolean, null: false, default: false
  end
end
