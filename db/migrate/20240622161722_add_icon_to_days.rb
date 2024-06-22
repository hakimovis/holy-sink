class AddIconToDays < ActiveRecord::Migration[7.0]
  def change
    add_column :days, :icon, :string
  end
end
