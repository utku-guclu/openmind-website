class AddHeroImageDisplaySettingsToVolunteerAudiences < ActiveRecord::Migration[8.1]
  def change
    add_column :volunteer_audiences, :hero_image_object_fit, :string, default: "cover"
    add_column :volunteer_audiences, :hero_image_object_position, :string, default: "center"
  end
end
