# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string           not null
#

class User < ApplicationRecord
  validates :username, :email, presence: true, uniqueness: true
  
  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl
  
  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit
  
  has_many :visited_sites,
    Proc.new { distinct },
    through: :visits,
    source: :url
end
