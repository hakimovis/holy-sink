class Calendar
  def self.group_by_weeks(dates)
    matrix = []

    week_num = 0

    dates.each do |date|
      matrix[week_num] = [nil] * 7 if matrix[week_num].blank?
      i = date.wday == 0 ? 6 : date.wday - 1

      matrix[week_num][i] = date
      week_num += 1 if i == 6
    end

    matrix
  end
end