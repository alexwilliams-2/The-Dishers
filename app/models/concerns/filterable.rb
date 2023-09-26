
module Filterable
  extend ActiveSupport::Concern

  included do
    scope :filter_by_category, -> (category) { where(category: category) if category.present? }
    scope :filter_by_rating, -> (rating) { joins(:reviews).group('businesses.id').having('AVG(reviews.rating) >= ? AND AVG(reviews.rating) <= ?', rating.to_f, rating.to_f + 1) if rating.present? }
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
