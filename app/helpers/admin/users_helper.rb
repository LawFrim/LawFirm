module Admin::UsersHelper

  def render_user_avatar(user)
    if !user.user_avatar.present?
      image_tag user.gravatar_url
    else
      image_tag (user.user_avatar.url(:middle))
    end
  end




  def render_user_small_avatar(user)
    if !user.user_avatar.present?
    image_tag user.gravatar_url,class:"lawyerImage"
  else
    image_tag (user.user_avatar.url(:small)),class:"lawyerImage"
  end
end

  def change_user_status(user)
    if !user.is_lawyer?
      link_to("设为律师", change_to_lawyer_admin_user_path(user), method: :post,data: { confirm: "确认认证为律师么？" }, class:"btn btn-xs btn-info")
    else
      link_to("设为用户", change_to_user_admin_user_path(user), method: :post,data: { confirm: "确认降级为顾客么？" }, class:"btn btn-xs btn-info")
    end
  end



  def chenge_user_vip(user)
    if !user.is_vip?
      link_to("设为VIP", chenge_to_vip_admin_user_path(user), method: :post,data: {confirm: "确认认证VIP？"}, class: "btn btn-xs btn-warning")
    else
      link_to("取消VIP", chenge_to_visitor_admin_user_path(user), method: :post, data: {confirm: "取消认证VIP？"}, class: "btn btn-xs btn-warning ")
    end
  end
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
