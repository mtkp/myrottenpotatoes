class AddAdminToMoviegoers < ActiveRecord::Migration
  def change
    add_column :moviegoers, :admin, :boolean, default: false
  end
end
