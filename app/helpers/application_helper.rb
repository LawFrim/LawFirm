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
  #用户的身份状态图标
  def render_user_status(user)
    if !user.is_admin?
      if user.is_lawyer?
        content_tag(:span,"",class:"fa fa-user-plus")
      else
        content_tag(:span, "", class: "fa fa-user")
      end
    else
      content_tag(:span,"",class:"fa fa-star-o")
    end
  end

  def render_user_vip(user)
    if !user.is_vip?
      content_tag(:span,"", class:"fa fa-opera")
    else
      content_tag(:span,"", class:"fa fa-vimeo")
    end

  end

end
