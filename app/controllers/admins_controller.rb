class AdminsController < ArticlesController

  def index
  	checkingRights
    if params[:search] == ''
      @articles = Article.all
    elsif params[:search]
      @articles = Article.search(params[:search]).records.to_a
    else
      @articles = Article.all
    end
  end

end
