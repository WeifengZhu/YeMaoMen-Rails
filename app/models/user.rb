# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  username         :string(255)
#  password_digest  :string(255)
#  bio              :string(255)
#  location         :string(255)
#  avatar_url       :string(255)
#  allow_browse     :boolean
#  score            :integer
#  last_active_time :datetime
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :allow_browse, :avatar_url, :bio, :last_active_time, :location, :password_digest, :score, :username
end
