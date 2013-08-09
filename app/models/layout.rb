class Layout 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :content, type: String, default: ''

  has_many :types
  has_many :child_layouts, class_name: 'Layout', inverse_of: :parent
  belongs_to :parent, class_name: 'Layout', inverse_of: :child_layouts

  validates :content, presence: true
  validates :name, presence: true, uniqueness: true

  before_create :downcase_name

  def to_s
    self.name
  end

  def parse
    parse_with_entity nil
  end

  # Returns HTML string with entity values
  def parse_with_entity entity, child = nil
    locals = {}
    locals[entity.type.name] = entity unless entity.nil?
    locals['type'] = (entity.nil? ? 'none' : entity.type.name)
    locals['child'] = child unless child.nil?

    # TODO: check which included templates need to be loaded...
    for other in Layout.ne(_id: self.id)
      next if entity and other.name == entity.type.name
      locals[other.name] = Liquid::Template.parse(other.content).render(locals)
    end

    render = Liquid::Template.parse(self.content).render(locals)

    if self.parent
      self.parent.parse_with_entity(entity, render)
    else
      render
    end
  end

  def downcase_name
    self.name.downcase!
  end

end
