class LeaveRequest < ApplicationRecord
  validates :employee_name, :start_date, :end_date, presence: true

  validate :end_date_after_start_date

  def duration
    (end_date - start_date).to_i + 1
  end

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    errors.add(:end_date, "must be after start date") if end_date < start_date
  end
end
