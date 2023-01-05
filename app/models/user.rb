class User < ApplicationRecord
  validates :name, presence: true
  validates :team_name, presence: true
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  team_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
