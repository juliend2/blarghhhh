class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.xml
  def create
    verify_recaptcha :private_key => 'YOUR KEY HERE'
  
    @comment = Comment.new(params[:comment])
    @post = @comment.post
    @categories = Category.find(:all)

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(:controller=>'posts', :action=>'show', :id=>@post.id, :anchor=>@comment.id) }
      else
        flash[:notice] = 'Comment was unable to be saved..'
        format.html { redirect_to(@post) }
      end
    end
  end
end
