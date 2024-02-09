class CreateGymClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :gym_classes do |t|

      t.timestamps
    end
  end
end
