#encoding=utf-8
class ApiController < ApplicationController

  def notify
    @user = session[:user]
    @title = "通知"

    @un_reads = Notify.where(:target_id => @user.id ,:is_read => false) ;
    @reads = Notify.where(:target_id => @user.id ,:is_read => true);

    @un_reads.each do |notify|
      notify.is_read =  true
      notify.save
    end

    puts @un_reads.length
    puts @reads.length
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @un_reads }
    end

  end



end
