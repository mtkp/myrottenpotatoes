class AddIndexesToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, [:moviegoer_id, :movie_id]
  end
end
