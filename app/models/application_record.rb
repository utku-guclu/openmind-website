class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Allow Ransack (used by ActiveAdmin filters) to query any column or
  # association on every model. Safe because Ransack is only invoked from
  # the authenticated admin namespace — there's no public Ransack endpoint.
  def self.ransackable_attributes(_auth_object = nil)
    column_names + _ransackers.keys
  end

  def self.ransackable_associations(_auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s }
  end
end
