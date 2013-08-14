class ZenConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ga_tracking_id, type: String
  field :ga_enabled, type: Mongoid::Boolean

  field :head_bottom, type: String
  field :body_bottom, type: String

  field :jquery_version, type: String
  field :jquery_enabled, type: Mongoid::Boolean

  validate :only_one_should_exist, on: :create

  # Singleton
  def self.instance
    return self.count > 0 ? self.first : self.create()
  end

  def only_one_should_exist
    if ZenConfig.count > 0
      errors.add(:base, 'Can only create one ZenConfig object')
    end
  end

  def ga_code
    
  end

end
