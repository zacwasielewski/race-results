class ConvertTimeFieldsToIntegers < ActiveRecord::Migration
  def up
    change_column :runners, :gun_time, :integer
    change_column :runners, :gun_pace, :integer
    change_column :runners, :net_time, :integer
    change_column :runners, :net_pace, :integer
  end
  def down
    change_column :runners, :gun_time, :time
    change_column :runners, :gun_pace, :time
    change_column :runners, :net_time, :time
    change_column :runners, :net_pace, :time
  end
end
