class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy, :new]

  def checkingRights
    if current_user.rights != 'admin'
      redirect_to :home
    end
  end

  # GET /articles
  # GET /articles.json
  def index
    if params[:search] == ''
      @articles = Article.all
    elsif params[:search]
      @articles = Article.search(params[:search]).records.to_a
    else
      @articles = Article.all
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    checkingRights
    @article = Article.new
  end


  # GET /articles/1/edit
  def edit
    checkingRights
  end

  # POST /articles
  # POST /articles.json
  def create
    checkingRights
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Статья успешно добавлена.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    checkingRights
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Статья успешно обнавлена.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    checkingRights
    @article.destroy
    respond_to :js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :img)
    end
end
