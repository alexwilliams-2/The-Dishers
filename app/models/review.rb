class Review < ApplicationRecord
  belongs_to :business
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :job_title, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
