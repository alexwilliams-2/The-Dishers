require 'language_filter'

class Review < ApplicationRecord
  belongs_to :business
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :job_title, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  validate :profanity

  def profanity
    profanity_filter = LanguageFilter::Filter.new matchlist: File.join(Rails.root, '/config/language_filter.yml')
    if profanity_filter.match?(content)
      errors.add(:content, 'Hi there - you can be critical but please keep your review informative and hate-free. Thanks!')
    end
  end

end
