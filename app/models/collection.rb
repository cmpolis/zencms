class Collection
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_and_belongs_to_many :entities

  validates :name, presence: true, uniqueness: true

  def to_s
    self.name
  end

end
