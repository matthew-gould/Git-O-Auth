class UsersChange < ActiveRecord::Migration
  def change
    add_column :users, :auth_data, :text
  end
end
