class ArticlesController < ApplicationController
  #find specific article
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  #validate user 'has admin rights or not'
  before_action :checkingRights, only: [:edit, :create, :update, :destroy, :new]

  #main page
  def index
    #search parameters
    if params[:search] == ''
      @articles = Article.all.order_by(created_at: :desc).page params[:page]
    elsif params[:search]
      @articles = Article.all.order_by(created_at: :desc).search(params[:search]).records.page params[:page]
    else
      @articles = Article.all.order_by(created_at: :desc).page params[:page]
    end

    #for creating article from main page
    @article = Article.new
  end

  def new
    @article = Article.new
    respond_to :js
  end

  def edit
    @article = Article.find(params[:id])
    respond_to :js
  end

  def create
    #getting parameters from request
    @article = Article.new(article_params)
    
    #adding images if they has been added in request form
    if params[:article][:image]
      for image_item in params[:article][:image] 
        @article.images.build(image: image_item)
      end
    end

    respond_to do |format|
      if @article.save
        Article.create_indexes
        format.html { redirect_to home_path, notice: 'Статья успешно создана.' }
      else
        format.json { render json: @article.errors }
      end
    end
  end

  def update
    #adding images to existing article if they has been added in request form
    if params[:article][:image]
      for image_item in params[:article][:image]
        @article.images.push(Image.new(image: image_item))
      end
    end

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Статья успешно обновлена.' }
      else
        format.json { render json: @article.errors }
      end
    end
  end

  def destroy
    #delete images from specific article and folder
    ImagesController.new.destroy(article_id: @article.id)

    #delete specific article
    @article.destroy
    respond_to :js
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content)
    end

    #check admin or ordinary user
    def checkingRights
      if user_signed_in? and current_user.rights != 'admin'
        redirect_to :home
      end
    end
end
