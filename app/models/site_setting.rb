class SiteSetting < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  def self.get(key, default = nil)
    setting = find_by(key: key)
    setting ? setting.typed_value : default
  end

  def self.to_hash
    all.each_with_object({}) { |s, h| h[s.key] = s.typed_value }
  end

  def self.set(key, value, type: "string")
    setting = find_or_initialize_by(key: key)
    setting.update!(value: value.to_s, value_type: type)
  end

  def typed_value
    case value_type
    when "integer" then value.to_i
    when "boolean" then value == "true"
    when "json" then JSON.parse(value) rescue {}
    else value
    end
  end
end
