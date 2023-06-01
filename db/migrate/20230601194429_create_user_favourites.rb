class CreateUserFavourites < ActiveRecord::Migration[7.0]
  def change
    create_table :user_favourites do |t|
      t.references :business, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
