module UsersHelper

  def is_self?(user)
    user == @user
  end

  def had_waiting_response?
    @user.waiting_response.present?
  end

  def had_please_response?
    @user.please_response.present?
  end

  def had_friended?
    @user.friended.present?
  end

  def respond_relation(friend, user)
    if user.please_response.include?(friend)
      link_to(user.friend?(friend), friend_ship_path(id:friend.id),method: :post, remote: true, class: "btn") +
      link_to("拒絕", remove_friendship_path(id: friend.id),method: :post, remote: true, class: "btn btn-danger")
    else
      link_to(user.friend?(friend), friend_ship_path(id:friend.id),method: :post, remote: true, class: "btn")
    end
  end
  
end
