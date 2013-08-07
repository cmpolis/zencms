class Property
  include Mongoid::Document
  KINDS = [:string, :text, :html, :image, :float, :integer]

  field :name, type: String
  field :kind, type: Symbol
  field :req, type: Boolean, default: false

  validates :name, presence: true
  validates :req, presence: true
  validates :kind, inclusion: KINDS

  embedded_in :type

  def to_s
    self.name
  end

  def required?
    self.req
  end
end
