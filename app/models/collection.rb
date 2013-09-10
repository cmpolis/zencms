class Collection
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_and_belongs_to_many :entities

  validates :name, presence: true, uniqueness: true

  def to_s
    self.name
  end

  # Returns array of entities in same order as ids in entity_ids
  #  (without n+1 query)
  def ordered_entities
    ids = self.entity_ids
    self.entities.sort { |a, b| ids.index(a.id) <=> ids.index(b.id) }
  end

end
