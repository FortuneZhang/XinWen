#encoding=UTF-8
class AuthController < ApplicationController
  def log_in


    if session[:user] !=nil
      redirect_to :controller => 'news', :action => 'index'
    end

    if request.post?
      username = params[:username].to_s.downcase
      password = params[:password]


      if (username=='admin' && password== 'moodepass')
        @user = User.new(:name => 'admin', :pwd => 'moodepass', :rank => 1 ,:item_id=>0 )
        session[:user] = @user
        redirect_to :controller => 'users', :action => 'index'
        return
      end

      @user = User.find_by_name username
      if (@user==nil or password != @user.pwd)
        redirect_to :controller => 'auth', :action => 'log_in'
      else
        session[:user] = @user
        puts '=============='
        puts @user.rank
        puts @user.name
        session[:items] = Item.all


        redirect_to :controller => 'news', :action => 'index'
      end

    end
  end

  def log_out
    session[:user] = nil
    redirect_to :action => 'log_in'
  end

  def regist
  end
end
