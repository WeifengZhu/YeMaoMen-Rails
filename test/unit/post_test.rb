# == Schema Information
#
# Table name: posts
#
#  id               :integer         not null, primary key
#  topic_id         :integer
#  user_id          :integer
#  content          :text
#  like_count       :integer
#  reply_to_post_id :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
