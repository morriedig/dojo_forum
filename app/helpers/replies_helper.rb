module RepliesHelper

  def self_replied?(reply, user)
    if reply.user_id == user.try(:id)
      link_to "刪除", post_reply_path(id:reply.id, post_id: reply.post_id ), method: :delete, remote: true
    end
  end
end
