module ApplicationHelper

  def i_send_last_message(messages)
    messages.present? && messages.last.sender == current_user
  end

end
