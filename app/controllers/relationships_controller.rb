class RelationshipsController < ApplicationController
 
  # フォローするとき 
 def create
  current_user.follow(params[:user_id])
  redirect_to users_path
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to  users_path
  end
end
