class Entity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :values, type: Hash, default: Hash.new
  field :default_path, type: String

  belongs_to :type
  has_and_belongs_to_many :collections

  validates :type, presence: true
  validates :default_path, uniqueness: true, allow_blank: true
  validate :has_required_values
  validate :values_are_valid

  before_validation :convert_value_keys_to_strings
  before_create :generate_default_path

  def self.with_path path
    self.where(default_path: path).first
  end

  def primary_name
    self.primary_val || self.type.name
  end

  def primary_val
    self.type.primary_prop ? self.values[self.type.primary_property] : nil
  end

  def has_required_values
    return if self.type.nil?

    missing = []
    for prop in self.type.properties do
      missing << prop.name if prop.req and self.values[prop.name].blank?
    end
    if missing.any?
      errors.add(:values, "missing required value for: #{missing.join(", ")}")
    end
  end

  def values_are_valid
    return if self.type.nil?

    for property in self.type.properties
      val = self.values[property.name]
      if val and not property.valid_value? val
        errors.add(:values, "invalid value: #{val} for kind: #{property.kind}")
      end
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

  def generate_default_path
    return if self.default_path
    prop_name = self.type.primary_property
    if prop_name and self.values[prop_name]
      self.default_path = self.values[prop_name].parameterize
    else
      self.default_path = self.id
    end
  end

  def to_liquid
    self.values
  end

  def liquid_attrs
    {
      "#{self.type.name}" => self,
      "type" => self.type.name
    }
  end

end
