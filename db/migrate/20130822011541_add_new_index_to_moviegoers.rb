class AddNewIndexToMoviegoers < ActiveRecord::Migration
  def change
      add_index :moviegoers, [:uid, :provider]
  end
end
