class Layout 
  include Mongoid::Document
  include Mongoid::Timestamps

  EDITABLE_SELECTOR = 'h1, h2, h3, h4, h5, h6, p, div, li, tr'

  field :name, type: String
  field :content, type: String, default: ''

  # copy of parsed layout for live admin editing
  field :admin_edit, type: String

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

  def parse(is_admin = false)
    parse_with_entity(nil, nil, is_admin)
  end

  # Returns HTML string with entity values
  # TODO: CLEAN THIS UP!!!
  def parse_with_entity entity, child = nil, is_admin = false
    locals = ZenConfig.liquid_attrs
    locals.merge! entity.liquid_attrs unless entity.nil?
    locals['child'] = child unless child.nil?

    others = self.content.scan(/\{\{.*\}\}/).map { |s| s.gsub(/[ |\{|\}]/, '') }
    for other in Layout.in(name: others)
      next if entity and other.name == entity.type.name
      otherLiq = Liquid::Template.parse(other.content).render(locals)
      otherHtml = Nokogiri::XML.fragment(otherLiq)
      other.adminize(otherHtml) if is_admin
      locals[other.name] = "<div class='zen-layout-wrapper' data-zen-id='#{other.id}' data-zen-name='#{other.name}'>#{otherHtml.to_s}</div>"
    end

    render = Liquid::Template.parse(self.content).render(locals)
    html = Nokogiri::XML.fragment(render)
    self.adminize(html) if is_admin
    render = html.to_s
    if self.parent
      self.parent.parse_with_entity(entity, render, is_admin)
    else
      add_assets(render)
    end
  end

  def downcase_name
    self.name.downcase!
  end

  def adminize html
    html.css(EDITABLE_SELECTOR).each do |tag|
      next if tag['data-zen-id']
      tag['data-zen-layout'] = self.id
      tag['data-zen-editable'] = 'true'
      tag['data-zen-id'] = ('%06x' % (rand * 0xffffff))
    end
    self.update_attributes(admin_edit: html)
  end

  def add_assets dom
    assetIncludes = self.scripts.collect(&:to_html).join
    assetIncludes += self.styles.collect(&:to_html).join
    Layout.append_to_head(dom, assetIncludes)
  end

  def self.append_to_head dom, insert
    dom.sub! /<head.*\/>/i, '<head></head>' if dom =~ /<head.*\/>/i
    dom.sub /<\/head>/i, "#{insert}</head>"
  end

  def self.prepend_to_body dom, insert
    dom.sub /<body>/i, "<body>#{insert}"
  end

  # TODO: get this working with children layouts, entity attributes
  def merge_edit(id, replacement)
    return if self.admin_edit.blank?

    html = Nokogiri::XML.fragment(self.admin_edit)
    el = html.css("[data-zen-id='#{id}']").first
    if el # found target element - change content, cleanup and update
      el.replace(replacement)
      html.css(EDITABLE_SELECTOR).each do |tag|
        tag.remove_attribute('data-zen-editable')
        tag.remove_attribute('data-zen-id')
        tag.remove_attribute('data-zen-layout')
      end
      self.update_attributes(content: html.to_s)
    end
  end

end
