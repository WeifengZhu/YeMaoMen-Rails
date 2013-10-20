class User < ActiveRecord::Base
  attr_accessible :allow_browse, :avatar_url, :bio, :last_active_time, :location, :password_digest, :score, :username
end
