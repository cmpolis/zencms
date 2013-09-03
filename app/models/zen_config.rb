class ZenConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ga_tracking_id, type: String
  field :ga_enabled, type: Mongoid::Boolean, default: false

  field :head_bottom, type: String
  field :body_bottom, type: String

  field :jquery_version, type: String
  field :jquery_enabled, type: Mongoid::Boolean

  field :name, type: String
  field :base_url, type: String
  field :admin_email, type: String
  field :twitter_handle, type: String

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

  def admin_title
    "#{self.name || "ZenCMS"} Admin"
  end

  def ga_code
    return "" unless self.ga_enabled
    "<script type=\"text/javascript\">
     var _gaq = _gaq || [];
     _gaq.push(['_setAccount', '#{self.ga_tracking_id}']);
     _gaq.push(['_trackPageview']);
     (function() {
       var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
       ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
     })();
     </script>"
  end

  def self.liquid_attrs
    config = self.instance
    {
      'ga_code' => config.ga_code,
      'twitter_url' => "http://twitter.com/#{config.twitter_handle}",
      'base_url' => config.base_url,
      'admin_email' => config.admin_email
    }
  end

end
