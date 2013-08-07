class Entity
  include Mongoid::Document

  field :values, type: Hash, default: Hash.new

  belongs_to :type

  validates :type, presence: true
  validate :has_required_values

  before_validation :convert_value_keys_to_strings

  def has_required_values
    return if self.type.nil?

    missing = []
    for prop in self.type.properties do
      missing << prop.name if prop.req and self.values[prop.name].blank?
    end
    if missing.any?
      errors.add(:values, "missing required value for: #{missing}")
    end
  end

  def convert_value_keys_to_strings
    for key in self.values.keys do
      unless key.is_a? String
        self.values[key.to_s] = self.values[key]
        self.values.delete(key)
      end
    end
  end

end
