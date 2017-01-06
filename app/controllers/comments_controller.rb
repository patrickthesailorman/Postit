class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :comment_owner]
  before_action :authenticate_user!,except:[:index]
  before_action :comment_owner, only: [:edit, :update, :destroy]

    def comment_owner
     unless @comment.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Comment'
      redirect_to posts_path
     end
    end
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  #  @post = Post.find(params[:post_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@post,@comment], alert: 'Comment was successfully created!' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comment_path, alert: 'Comment was successfully updated!' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
      respond_to do |format|
       format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :votes, :content, :user_id)
    end
end
