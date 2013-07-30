class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer    :potatoes
      t.text       :comments
      t.references :moviegoers
      t.references :movies
    end
  end
end
