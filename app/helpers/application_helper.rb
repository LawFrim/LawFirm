module ApplicationHelper

  # f265-确定最后一条回答是否来自于当前用户
  def i_send_last_message(messages)
    messages.present? && messages.last.sender == current_user
  end

end
