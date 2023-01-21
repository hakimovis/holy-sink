class AddCommentToDays < ActiveRecord::Migration[7.0]
  def change
    add_column :days, :comment, :string
  end
end
