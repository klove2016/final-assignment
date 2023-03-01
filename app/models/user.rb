class User < ApplicationRecord
    has_many :availabilities
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ }
    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :phone, presence: true, length: { minimum: 10, maximum: 15 }, format: { with: /\A[0-9]+\z/ }
end
