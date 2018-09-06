# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :user_id, presence: true
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  
  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit
  
  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
  
  def self.random_code
    SecureRandom.urlsafe_base64(16)
  end
  
  def self.make_url(user_id: person, long_url: location)
    rando = ShortenedUrl.random_code
      while ShortenedUrl.exists?(short_url: rando)
        rando = ShortenedUrl.random_code
      end
      
    shorty = "mel.com/#{rando}"
    
    ShortenedUrl.create!(short_url: shorty, long_url: location, user_id: person)
  end
  
  def num_clicks
    self.visits.length
  end
  
  def num_uniques
    self.visitors.length
  end
  
  def num_recent_uniques
    self.visitors.where({created_at: (Time.now - 1.day)..Time.now}).length
  end
  
end
