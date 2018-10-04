class Admins::PostCategoriesController < Admins::AdminController
  # 這邊需要讓全部後台共用，之後可改寫
  

  def index
    @post_categories = PostCategory.all
    @post_category = PostCategory.new
    @users = User.all
  end

  def create
    @post_category = PostCategory.create(post_category_params)
    # 之後要寫判斷失敗的狀況
  end

  def update
    find_post_category
    @post_category.update(title: params[:title])
  end

  def edit
    find_post_category
  end

  def destroy
    find_post_category
    if @post_category&.destroy
    else
      flash.now[:notice] = "請勿刪除"
    end
  end

  private

  def find_post_category
    @post_category = PostCategory.find(params[:id])
  end

  def post_category_params
    params.require(:post_category).permit(:title)
  end
  
end
