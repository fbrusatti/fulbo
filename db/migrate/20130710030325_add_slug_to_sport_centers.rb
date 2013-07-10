class AddSlugToSportCenters < ActiveRecord::Migration
  def change
    add_column :sport_centers, :slug, :string
  end
end
