module Admins::UsersHelper

  def change_role(user)
    user.admin? ? "刪除管理員" : "加入管理員"
  end
end
