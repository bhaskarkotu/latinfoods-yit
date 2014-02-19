class VideosController < InheritedResources::Base

def index
  @videos = Video.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')
end

def upload
  @video = Video.create(params[:video])
  if @video
    @upload_info = Video.token_form(params[:video], save_video_new_video_url(:video_id => @video.id))
  else
    respond_to do |format|
      format.html { render "/videos/new" }
    end
  end
end

  def update
    @video     = Video.find(params[:id])
    @result    = Video.update_video(@video, params[:video])
    respond_to do |format|
      format.html do
        if @result
          redirect_to @video, :notice => "video successfully updated"
        else
          respond_to do |format|
            format.html { render "/videos/_edit" }
          end
        end
      end
    end
  end

  def save_video
    @video = Video.find(params[:video_id])
    if params[:status].to_i == 200
      @video.update_attributes(:yt_video_id => params[:id].to_s, :is_complete => true)
      Video.delete_incomplete_videos
    else
      Video.delete_video(@video)
    end
    redirect_to videos_path, :notice => "video successfully uploaded"
  end

  def destroy
    @video = Video.find(params[:id])
    if Video.delete_video(@video)
      flash[:notice] = "video successfully deleted"
    else
      flash[:error] = "video unsuccessfully deleted"
    end
    redirect_to videos_path
  end

  def add_comment
    @video = Video.find(params[:id])
    @comment = @video.comments.new
    @comment.comment = params[:video][:comment]
    @comment.user_id = current_user.id
    @comment.commentable_type="video"
    if @comment.save!
      flash[:notice] = "Comment has been sucessfully added."
    else
      flash[:error] = "Sorry the comment has not been added."
    end
    redirect_to @video    
  end


  protected
    def collection
      @videos ||= end_of_association_chain.completes
    end
end
