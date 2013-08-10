class Static
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :path, type: String

  belongs_to :layout

  validates :layout, presence: true
  validates :name, presence: true
  validates :path, presence: true, uniqueness: true

  def to_s
    self.name
  end

  def self.with_path path
    self.where(path: path).first
  end

end
