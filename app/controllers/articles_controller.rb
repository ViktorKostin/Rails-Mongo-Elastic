class ArticlesController < ApplicationController
  #find specific article
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  #validate user 'has admin rights or not'
  before_action :checkingRights, only: [:edit, :create, :update, :destroy, :new]

  #main page
  def index
    #search parameters
    if params[:search] == ''
      @articles = Article.order_by(created_at: :desc).page params[:page]
    elsif params[:search]
      @articles = Article.search(params[:search]).records.order_by(created_at: :desc).page params[:page]
    else
      @articles = Article.order_by(created_at: :desc).page params[:page]
    end
  end

  def new
    @article = Article.new
    respond_to :html
  end

  def edit
    @article = Article.find(params[:id])
    respond_to :html
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
    #delete specific article and images
    @article.images.destroy_all
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
end
