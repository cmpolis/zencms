class Entity
  include Mongoid::Document

  field :values, type: Hash, default: Hash.new
  field :default_path, type: String

  belongs_to :type

  validates :type, presence: true
  validates :default_path, uniqueness: true, allow_blank: true
  validate :has_required_values

  before_validation :convert_value_keys_to_strings
  before_create :generate_default_path

  def self.with_path path
    self.where(default_path: path).first
  end

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

end
