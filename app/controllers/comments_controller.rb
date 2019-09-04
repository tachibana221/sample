class CommentsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index
    @comments = Comment.all()
  end

  # 詳細ページ
  def show
    comment_id = params[:id]
    @comment = Comment.find(comment_id)
  end

  # 新規作成ページ
  def new
    bedsore_id = params[:bedsore_id]
    @bedsore = Bedsore.find(bedsore_id)
    @comment = Comment.new()
  end

  # 編集ページ
  def edit
    comment_id = params[:id]
    @comment = Comment.find(comment_id)
  end

  # 新規作成
  def create
    puts params[:bedsore_id]
    bedsore_id = params[:comment][:bedsore_id]
    @bedsore = Bedsore.find(bedsore_id)
    comment = @bedsore.comments.build()
    comment.update(params[:comment])
    if comment.save()
      flash[:primary] = '新しくコメントを登録しました'
      redirect_back(fallback_location: root_path)
    end
  end

  # 登録情報更新
  def update
    @comment = Comment.find(params[:id])
    puts params
    @comment.update(params[:comment])
    if @comment.save()
      flash[:primary] = 'コメントを更新しました'
      redirect_back(fallback_location: root_path)
    end
  end

  # 削除
  def destroy
    @comment = Comment.find(params[:id])
    redirect_back(fallback_location: root_path) if @comment.destroy()
  end
end
