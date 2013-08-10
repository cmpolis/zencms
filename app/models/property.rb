class Property
  include Mongoid::Document
  include Mongoid::Timestamps

  KINDS = [:string, :text, :html, :image, :float, :integer, :array, :enum]

  field :name, type: String
  field :kind, type: Symbol
  field :req, type: Mongoid::Boolean, default: false
  field :possible, type: Array

  validates :name, presence: true
  validates :kind, inclusion: KINDS
  validates :possible, presence: true, if: :enum?
  validate :possible_is_an_array, if: :enum?

  before_create :normalize_name

  embedded_in :type

  def to_s
    self.name
  end

  def required?
    self.req
  end

  def enum?
    self.kind == :enum
  end

  def possible_is_an_array
    errors.add(:possible, 'must be array') unless self.possible.is_a? Array
  end

  def normalize_name
    self.name = self.name.gsub(' ', '_').downcase
  end

  def valid_value? value
    val_method = "valid_#{self.kind}?"
    return self.send(val_method, value) if self.respond_to? val_method
    true
 end

 def valid_integer? value
   value.is_a? Integer
 end

 def valid_float? value
   value.is_a? Float
 end

 def valid_array? value
   value.is_a? Array
 end

 def valid_enum? value
   self.possible and self.possible.include? value
 end

end
