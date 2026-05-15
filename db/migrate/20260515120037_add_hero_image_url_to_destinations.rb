class AddHeroImageUrlToDestinations < ActiveRecord::Migration[8.1]
  def change
    add_column :destinations, :hero_image_url, :string
  end
end
