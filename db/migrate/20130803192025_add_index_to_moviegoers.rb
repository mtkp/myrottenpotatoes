class AddIndexToMoviegoers < ActiveRecord::Migration
  def change
    add_index :moviegoers, [:name, :uid, :provider]
  end
end
