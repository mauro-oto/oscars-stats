class AddActorsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :actors, :text
  end
end
