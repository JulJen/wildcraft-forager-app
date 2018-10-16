module ApplicationHelper

  def find_user_name(member)
    user = User.find_by_id(member.user_id)
    @find_user_name = user.name.capitalize
  end

end
