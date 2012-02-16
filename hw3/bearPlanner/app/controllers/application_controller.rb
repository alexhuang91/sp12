class ApplicationController < ActionController::Base
  protect_from_forgery

  def invite_id_matches_user
  end

  def cal_id_matches_user
  end

  def login_required
    if session[:uid] #if there is a logged in user
      return true
    end #Otherwise redirect to login page
    redirect_to :controller => "bear_planner", :action=> "login", :notice=>"Please log in to view this page"
    return false 
  end
end
