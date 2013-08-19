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
    locals = ZenConfig.liquid_attrs
    locals.merge! entity.liquid_attrs unless entity.nil?
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
    assetIncludes = self.scripts.collect(&:to_html).join
    assetIncludes += self.styles.collect(&:to_html).join
    Layout.append_to_head(dom, assetIncludes)
  end

  def self.append_to_head dom, insert
    dom.sub /<\/head>/i, "#{insert}</head>"
  end

  def self.prepend_to_body dom, insert
    dom.sub /<body>/i, "<body>#{insert}"
  end

end
