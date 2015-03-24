class EditUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :github_id, :integer
  end
end
