class ChangeColumnTypeNameInBusiness < ActiveRecord::Migration[7.0]
  def change
    rename_column(:businesses, :type, :category)
  end
end
