require 'language_filter'

class Review < ApplicationRecord
  belongs_to :business
  belongs_to :user
  validates :content, presence: true
  validates :job_title, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  validate :profanity
  validate :named_individual
  validate :too_short

  def profanity
    profanity_filter = LanguageFilter::Filter.new matchlist: File.join(Rails.root, 'config/language_filter_profanity.yml')
    if profanity_filter.match?(content)
      errors.add(:base, 'Mind your language! Whilst we encourage healthy criticism, we do not condone profanity. Please keep your review informative and hate-free for our community.')
    end
  end

  def named_individual
    profanity_filter = LanguageFilter::Filter.new matchlist: File.join(Rails.root, '/config/language_filter_names.yml')
    if profanity_filter.match?(content)
      errors.add(:base, "The Dishers values anonymonity for it's users. Colleagues and customers also deserve a right to privacy, even if that manager was always out for a smoke break. Please keep your review informative without naming names.")
    end
  end

  def too_short
    if content[120] == false
      errors.add(:base, "Your review was too short to be submitted! The Dishers works when explain our experiences - please go into more detail for your fellow Dishers!")
    end
  end
end
