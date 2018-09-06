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
  
end
