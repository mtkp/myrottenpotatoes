class AddImageToMoviegoers < ActiveRecord::Migration
  def change
    add_column :moviegoers, :image, :string
  end
end
