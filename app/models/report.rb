class Report < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude
  attr_accessible :photo

  default_scope order("created_at desc")
  
  scope :in_term, lambda{|from, to|
    where("created_at between ? and ?", from, to)
  }
  
  scope :in_days, lambda{|days|
    to = Time.now
    from = to - days.days
    where("created_at between ? and ?", from, to)
  }
  
  
  has_attached_file :photo, styles: {
    thumb: '100x100#',
    medium: '300x300>'
  }
  
  class << self
  
    def clean_past_at t = nil
      t ||= Time.now - 1.day
      self.where("created_at < ?", t).delete_all
    end

  end
  
  def photo_url
    photo_url_for_style nil
  end
  
  def thumb_url
    photo_url_for_style :thumb
  end
  
  def as_json options = {}
  	super :methods => [:photo_url]
  end

  def has_photo
    !(/missing.png$/i =~ photo.url)
  end

  private
  
  def photo_url_for_style style
    if has_photo
      url = photo.url(style)
      url = "#{$http_schema}://#{$http_host}#{url}" unless /^http/ =~ url
      url
    else
      nil
    end
  end

end
