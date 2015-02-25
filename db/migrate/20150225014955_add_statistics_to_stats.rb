class AddStatisticsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :statistics, :text
  end
end
