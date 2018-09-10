module PostsHelper

  def self_post?(post, user)
    if post.user_id === user.try(:id)
      link_to("編輯 |", edit_post_path(post)) +
      link_to("刪除文章 |", post_path(post), method: :delete, remote: true)
    else
      link_to(post.collected?(current_user), collection_posts_path(post_id: post.id), method: :post, remote: true, id: "collection_post_#{post.id}")
    end  
  end
  
end
