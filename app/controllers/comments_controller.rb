class CommentsController < ApplicationController
 USER, PASSWORD = 'dhh', 'secret'

before_filter :authentication_check, :except => :index

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
   def comment_params
     params.require(:comment).permit(:commenter, :body)
   end

  private
   def authentication_check
     authenticate_or_request_with_http_basic do |user, password|
      user == USER && password == PASSWORD
    end
   end
end
