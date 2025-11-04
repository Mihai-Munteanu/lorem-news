class CommentsController < ApplicationController
  before_action :set_post, only: %i[ create ]
  before_action :set_comment, only: %i[ edit update destroy ]

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.new(comment_params.merge(user: Current.user))

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_path, notice: "Comment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params.expect(:post_id))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
      raise NotAuthorized unless @comment.user == Current.user
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [:body])
    end
end
