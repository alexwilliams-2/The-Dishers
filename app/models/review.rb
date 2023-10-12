require 'language_filter'

class Review < ApplicationRecord
  belongs_to :business
  belongs_to :user
  validates :content, presence: true
  validates :job_title, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  validate :profanity
  validate :named_individual

  def profanity
    profanity_filter = LanguageFilter::Filter.new matchlist: File.join(Rails.root, 'config/language_filter_profanity.yml')
    if profanity_filter.match?(content)
      errors.add(:base, 'Mind your language! Whilst we encourage healthy criticism, please keep your review informative and hate-free for our community.')
    end
  end

  def named_individual
    profanity_filter = LanguageFilter::Filter.new matchlist: File.join(Rails.root, '/config/language_filter.yml')
    if profanity_filter.match?(content)
      errors.add(:base, 'We unfortunately do not allow you to name colleagues or customers, even if that manager was always out for a smoke break. Please keep your review informative without naming names.')
    end
  end




end
