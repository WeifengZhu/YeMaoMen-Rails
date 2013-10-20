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
#  identify_token   :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
