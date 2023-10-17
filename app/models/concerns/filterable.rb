
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
      if ratings.present?
        having_condition = ratings.map { "ROUND(AVG(reviews.rating)) = ?" }.join(' OR ')
        having_values = ratings.map(&:to_f)
        joins(:reviews).group('businesses.id').having(having_condition, *having_values)
      end
    }

    scope :filter_by_wage, -> (wage_ranges) {
      if wage_ranges.present?
        having_condition = wage_ranges.map do |range|
          "AVG(reviews.wage) >= ? AND AVG(reviews.wage) <= ?"
        end.join(' OR ')
        having_values = wage_ranges.flat_map do |range|
          [range.split('..').first.to_f, range.split('..').last.to_f + 1]
        end
        joins(:reviews).group('businesses.id').having(having_condition, *having_values)
      end
    }
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
