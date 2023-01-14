class CreateDays < ActiveRecord::Migration[7.0]
  def change
    create_table :days do |t|
      t.integer :user_id
      t.string :team_name
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
