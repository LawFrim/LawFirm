module ApplicationHelper

  # f265-确定最后一条回答是否来自于当前用户
  def i_send_last_message(messages)
    messages.present? && messages.last.sender == current_user
  end

  # 用户头像
  def img_by(user)

    user.user_avatar.url(:small)
  end

  def time_format(time)
    DateTime.parse(time.to_s).strftime('%Y-%m-%d %H:%M:%S').to_s
  end


end
