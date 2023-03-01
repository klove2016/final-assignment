class Availability < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :start_time, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/ }
  validates :end_time, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/ }, date: { after: :start_time }
  
end
