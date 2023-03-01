class Availability < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time
  validate :no_overlap

  private

  def start_time_before_end_time
    if start_time && end_time && start_time >= end_time
      errors.add(:start_time, "must be before end time")
    end
  end

  def no_overlap
    overlaps = user.availabilities.where.not(id: id).where("(start_time <= :end_time) AND (end_time >= :start_time)", { start_time: start_time, end_time: end_time })
    errors.add(:base, "Availability overlaps with existing availability") if overlaps.any?
  end
end
