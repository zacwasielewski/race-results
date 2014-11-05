class CreateRunners < ActiveRecord::Migration
  def change
    create_table :runners do |t|
    	t.references :race

      t.string :name
      t.integer :place
      t.string :sex
      t.integer :place_in_sex
      t.string :age_group
      t.integer :total_in_age_group
      t.integer :place_in_age_group
      t.integer :gun_time
      t.integer :gun_pace
      t.integer :net_time
      t.integer :net_pace
      t.string :country
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
