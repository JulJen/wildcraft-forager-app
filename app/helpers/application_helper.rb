module ApplicationHelper

  def find_user_name(member)
    user = User.find_by_id(member.user_id)
    @find_user_name = user.name.capitalize
  end


  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def nav_entry(body, path)
    content_tag(:li, link_to(body, path), class: ('active' if current_page?(path)))
  end


end
