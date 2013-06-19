#encoding=UTF-8
class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  $news_count_per_page = 1
  $comments_count_per_page = 1

  #skip_before_filter :verify_authenticity_token, :only => [:search]

  def index

    @title = "新闻浏览"
    @user = session[:user]
    if @user.rank == 2
      myarray= News.find_all_by_is_show_public_and_item_id(false, @user.item_id).reverse
      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)
      #@comments = Kaminari.paginate_array(myarray).page(params[:page]).per(2)
    elsif @user.rank ==3
      myarray= News.find_all_by_is_show_public_and_item_id_and_author_id(false, @user.item_id, @user.id).reverse
      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)
    elsif @user.rank == 4
      myarray= News.find_all_by_is_show_public_and_item_id(true, Item.first.id).reverse
      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)

    end

    #@news = Kaminari.paginate_array(myarray).page(params[:page]).per(2)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show

    @news = News.find(params[:id])
    @author = User.find(@news.author_id)
    @user = session[:user]
    @title = @news.title
    if (@news.author_id == @author.id)
      @notifies = Notify.where(:target_id => @author.id, :news_id => @author.id)
      @notifies.each do |notify|
        notify.is_read = true;
        notify.save
      end
    end


    if @user.rank ==2 || @user.rank == 3
      myarray = @news.comments.reverse
      @comments = Kaminari.paginate_array(myarray).page(params[:page]).per($comments_count_per_page)
    elsif @user.rank == 4
      myarray = @news.comments.where(:is_show_public => true).reverse
      @comments = Kaminari.paginate_array(myarray).page(params[:page]).per($comments_count_per_page)
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @title = '新建新闻'
    @news = News.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
    @title =@news.title
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(:author_id => session[:user].id, :content => params[:news]['content'],
                     :title => params[:news]['title'], :is_show_public => false, :item_id => session[:user].item_id)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end


  def published
    @title ='已发布新闻'
    @user = session[:user]

    #管理员
    if (@user.rank == 2)
      myarray = News.find_all_by_is_show_public_and_item_id(true, @user.item_id).reverse

      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)
      #撰写员
    elsif @user.rank == 3
      myarray = News.where(:is_show_public => true, :author_id => @user.id, :item_id => @user.item_id).reverse

      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)


    end
  end

  def unpublished
    @user = session[:user]
    @title ='未发布新闻'
    #管理员
    if (@user.rank == 2)
      myarray = News.find_all_by_is_show_public_and_item_id(false, @user.item_id).reverse

      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)
      #撰写员
    elsif @user.rank == 3
      myarray = News.where(:is_show_public => false, :author_id => @user.id, :item_id => @user.item_id).reverse

      @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)


    end
  end

  def issue

    @news = News.find(params[:id])
    @news.is_show_public = true
    @news.save

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end

  end


  def search

    @title = params[:search_target]
    myarray = News.find(:all, :conditions => ["title like ?", "%#{params[:search_target]}%"])
    @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)


    respond_to do |format|
      format.html
    end

  end


  def fenzu

    item = Item.find params[:id]
    @title =item.name
    myarray = News.find_all_by_item_id params[:id]
    @news = Kaminari.paginate_array(myarray).page(params[:page]).per($news_count_per_page)
    respond_to do |format|
      format.html
    end
  end

end
