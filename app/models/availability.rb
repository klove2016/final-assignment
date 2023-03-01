class Availability < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time

  private

  def start_time_before_end_time
    if start_time && end_time && start_time >= end_time
      errors.add(:start_time, "must be before end time")
    end
  end
end
