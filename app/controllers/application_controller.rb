class ApplicationController < ActionController::Base

  before_filter :auth_and_notify_count, :except => [:log_in]

  $items = Item.all

  protect_from_forgery

  def auth_and_notify_count
    if session[:user] == nil && request.url != '/auth/log_in'
      redirect_to :controller => 'auth', :action => 'log_in'
    elsif  session[:user] != nil&& request.url == '/auth/log_in'
      redirect_to :controller => 'news', :action => 'index'
    else
      session[:notify_count] = Notify.where(:target_id => session[:user].id, :is_read => false).length
    end

  end

end
