class AddLocationToProjects < ActiveRecord::Migration[8.1]
  def change
    add_reference :projects, :location, null: true, foreign_key: true
  end
end
