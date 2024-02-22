class AddColumnsToGymClass < ActiveRecord::Migration[7.1]
  def change
    add_column :gym_classes, :title, :text
    add_column :gym_classes, :date_and_time, :datetime
    add_column :gym_classes, :price, :integer
  end
end
