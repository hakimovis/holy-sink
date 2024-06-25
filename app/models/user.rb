class User < ApplicationRecord
  has_many :days, dependent: :destroy
  
  validates :name, presence: true
  validates :team_name, presence: true

  def admin?
    self == self.class.where(team_name: team_name).order(:created_at).first
  end
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
