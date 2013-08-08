class Type
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :primary_property, type: String

  validates :name, presence: true, uniqueness: true
  validate :uniquely_named_properties
  validate :primary_property_is_a_property

  before_create :normalize_name
  embeds_many :properties
  has_many :entities
  belongs_to :layout

  def to_s
    self.name
  end

  def plural_name
    self.name.pluralize.titleize
  end

  def uniquely_named_properties
    names = self.properties.collect(&:name)
    if names.uniq.length != names.length
      errors.add(:properties, "can't have duplicate names")
    end
  end
 
  def primary_property_is_a_property
    if self.primary_property and 
       self.properties.collect(&:name).exclude? primary_property
      errors.add(:primary_property, "primary property is not a property")
    end
  end

  def normalize_name
    return if self.name.nil?
    self.name = self.name.downcase.singularize
  end

end
