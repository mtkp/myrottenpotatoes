class RemoveIndexFromMoviegoers < ActiveRecord::Migration
  def change
    remove_index :moviegoers, [:name, :uid, :provider]
  end
end
