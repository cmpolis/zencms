class Script
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :content, type: String

  validates :content, presence: true
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :layouts

  def to_s
    self.name
  end
end
