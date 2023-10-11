
module Filterable
  extend ActiveSupport::Concern

  included do
    scope :filter_by_category, -> (categories) {
      if categories.present?
        if categories.include?('All')
          where(category: ['Pub', 'Cafe', 'Restaurant'])
        else
          where(category: categories)
        end
      end
    }
    scope :filter_by_rating, -> (ratings) {
      ratings = Array(ratings).map(&:to_f)
      if ratings.present?
        joins(:reviews).group('businesses.id').having('AVG(reviews.rating) IN (?)', ratings)
      end
    }
    scope :filter_by_wage, -> (wage) { joins(:reviews).group('businesses.id').having('AVG(reviews.wage) >= ? AND AVG(reviews.wage) <= ?', wage.to_f, wage.to_f + 1) if wage.present? }
  end

  class_methods do
    def filter(filtering_params)
      results = self.all
      filtering_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end
  end
end
