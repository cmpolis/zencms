class Layout 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :content, type: String, default: ''

  has_many :statics
  has_many :types
  has_many :child_layouts, class_name: 'Layout', inverse_of: :parent
  belongs_to :parent, class_name: 'Layout', inverse_of: :child_layouts
  has_and_belongs_to_many :scripts
  has_and_belongs_to_many :styles

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
      add_assets(render)
    end
  end

  def downcase_name
    self.name.downcase!
  end

  def add_assets dom
    assetIncludes = ""
    for script in self.scripts do
      assetIncludes << "<script src='/js/#{script}.js'></script>\n"
    end
    
    for style in self.styles do
      assetIncludes << "<link rel='stylesheet' type='text/css' href='/css/#{style}.css'>\n"
    end

    dom.sub /<\/head>/i, "#{assetIncludes}</head>"
  end

end
