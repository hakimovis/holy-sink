class User < ApplicationRecord
  validates :name, presence: true
  validates :team_name, presence: true
  has_many :days, dependent: :destroy
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
