class Site::CommentsController < ApplicationController
  
  before_action :authenticate_member!
  
  def create
    @comment = Comment.new(comments_params)
    @comment.member = current_member
    
    if (@comment.save)
      redirect_to site_ads_detail_path(@comment.ad_id), notice: "Comentário adicionado!"
    else
      redirect_to site_ads_detail_path(@comment.ad_id), notice: "Erro ao adicionar comentário!"
    end
  end
  
  private
  
  def comments_params
    params.require(:comment).permit(:body, :ad_id)
  end
  
  
  
end
