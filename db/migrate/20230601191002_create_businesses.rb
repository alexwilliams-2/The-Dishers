class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone_number
      t.string :type
      t.integer :size
      t.string :business_hours
      t.string :description

      t.timestamps
    end
  end
end
