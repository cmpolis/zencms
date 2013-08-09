class Property
  include Mongoid::Document
  include Mongoid::Timestamps

  KINDS = [:string, :text, :html, :image, :float, :integer]

  field :name, type: String
  field :kind, type: Symbol
  field :req, type: Mongoid::Boolean, default: false

  validates :name, presence: true
  validates :kind, inclusion: KINDS

  before_create :normalize_name

  embedded_in :type

  def to_s
    self.name
  end

  def required?
    self.req
  end

  def normalize_name
    self.name = self.name.gsub(' ', '_').downcase
  end
end
