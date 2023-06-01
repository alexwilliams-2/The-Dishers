class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :business, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :content
      t.boolean :recommended
      t.string :job_title
      t.integer :rating
      t.float :wage
      t.integer :votes

      t.timestamps
    end
  end
end
