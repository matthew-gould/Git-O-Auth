class Repos < ActiveRecord::Migration
  def change
    create_table(:repos) do |t|
      t.string :name
      t.integer :user_id
      t.integer :commits
      t.integer :stars
      t.integer :watchers
    end
  end
end
