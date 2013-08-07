class Type
  include Mongoid::Document
  field :name, type: String

  validates :name, presence: true, uniqueness: true
  validate :uniquely_named_properties

  embeds_many :properties

  def to_s
    self.name
  end

  def uniquely_named_properties
    names = self.properties.collect(&:name)
    if names.uniq.length != names.length
      errors.add(:properties, "can't have duplicate names")
    end
  end

end
