#encoding = UTF-8
class CommentsController < ApplicationController

  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  def show
    @comment = Comment.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @news = News.find(params[:news_id])
    @user = User.find(session[:user].id)
    is_show_public = @news.is_show_public;
    @comment = @news.comments.new(:content => params[:comment]['content'], :is_show_public => is_show_public);

    @comment.user = @user

    @notify = Notify.new(:content => '评论了您的文章', :is_read => false, :target_id => @news.author_id)
    @notify.user = @user
    @notify.news = @news

    respond_to do |format|
      if @comment.save && @notify.save

        format.html { redirect_to @news  , notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: '@comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comment_index_url }
      format.json { head :no_content }
    end
  end
end
