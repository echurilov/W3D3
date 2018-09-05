# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :courses,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Course
  
  has_many :enrollments,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Enrollment
end