class Day < ApplicationRecord
  STATUSES = ['working', 'free', 'things', 'other']

  belongs_to :user

  validates :date, uniqueness: { scope: :user_id }
  validates :status, inclusion: { in: STATUSES }
  validates :team_name, presence: true

  scope :for_user, -> (user) { where(user: user) }
  scope :for_team, -> (team_name) { where(team_name: team_name) }

  def self.for_month(year, month)
    first_date = Date.new(year, month, 1)
    last_date = first_date.end_of_month
    where(date: (first_date..last_date))
  end

  def self.by_weeks
    dates = self
    weeks_count = (dates.count / 7).ceil + 1
    matrix = [[] * 7] * weeks_count

    week_num = 0

    dates.each do |date|
      i = date.wday == 0 ? 6 : date.wday - 1

      matrix[week_num][i] = date
      week_num += 1 if i == 6
    end

    matrix.pop if matrix[-1].all?(&:empty?)

    matrix
  end

  def ru_status
    I18n.t("days.#{self.status}")
  end
end

# == Schema Information
#
# Table name: days
#
#  id         :integer          not null, primary key
#  date       :date
#  status     :string
#  team_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
