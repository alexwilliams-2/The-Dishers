module ApplicationHelper
  include Pagy::Frontend

  def wage_checkbox(wage_range, label)
    checked = params[:wage]&.include?(wage_range)
    label_tag "wage_#{wage_range}" do
      check_box_tag 'wage[]', wage_range, checked
      label
    end
  end
end
