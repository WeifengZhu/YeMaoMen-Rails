class PostsController < ApplicationController
  
  skip_before_filter :authorize, only: [:top_posts]
  
  # GET top_posts
  def top_posts
    
  end
  
end
