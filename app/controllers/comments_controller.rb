class CommentsController < ApplicationController

  def new
    # ルーティングから:aricle_idの値をparamsで取得
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create

    # ルーティングから:aricle_idの値をparamsで取得
    article = Article.find(params[:article_id])

    # paramsで取得した:article_idの値をもったコメントインスタンスにcomment_paramsの値を渡してbuild
    @comment = article.comments.build(comment_params)

    if @comment.save
      redirect_to article_path(article), notice: 'コメントを追加しました'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end