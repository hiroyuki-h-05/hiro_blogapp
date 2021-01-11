class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    # 空のインスタンスをviewに渡してformの情報を埋め込む
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end


  
  private

  # :titleと:contentの値を受け取るためのメソッド
  # 更新する対象のモデルの名前をつける
  def article_params
    params.require(:article).permit(:title, :content)
  end

end