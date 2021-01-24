class ArticlesController < ApplicationController

  # privateで定義
  before_action :set_article, only: [:show]

  # devise(gem)が用意しているメソッド(authenticate_user)を使用
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def show
    @comments = @article.comments
  end

  def new
    # current_user(deviseのヘルパーメソッド)でユーザー情報を取得
    # userに紐づいた空のarticleインスタンスを build で生成
    # @articleに代入
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存しました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private

  # :titleと:contentの値を受け取るためのメソッド
  # 更新する対象のモデルの名前をつける
  def article_params
    params.require(:article).permit(:title, :content, :eyecatch)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  # インスタンス変数はそのクラス内であれば自由にアクセスできる

end