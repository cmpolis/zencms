class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :file, ImageUploader

  field :name, type: String

  validates :name, presence: true, uniqueness: true

  def to_s
    self.name
  end

end
