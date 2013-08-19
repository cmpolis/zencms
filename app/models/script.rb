class Script
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :content, type: String
  field :reference_url, type: String

  validates :content, presence: true, if: Proc.new { |s| s.reference_url.nil? }
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :layouts

  def to_s
    self.name
  end

  def to_html
    url = self.content.blank? ? self.reference_url : "/js/#{self.name}.js"
    "<script src='#{url}'></script>\n"
  end

end
