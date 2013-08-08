class Layout 
  include Mongoid::Document

  field :name, type: String
  field :content, type: String, default: ''

  has_many :types

  validates :content, presence: true
  validates :name, presence: true, uniqueness: true

  def to_s
    self.name
  end

end
