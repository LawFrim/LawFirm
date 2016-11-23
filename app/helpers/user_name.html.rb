# module UserNameHelper
#
#   def render_user_status(user)
#     if !user.is_admin?
#       if user.is_lawyer?
#         content_tag(:span,"",class:"fa fa-user-plus")
#       else
#         content_tag(:span, "", class: "fa fa-user")
#       end
#     else
#       content_tag(:span,"",class:"fa fa-star-o")
#     end
#   end
#
#   def render_user_vip(user)
#     if !user.is_vip?
#       content_tag(:span,"", class:"fa fa-opera")
#     else
#       content_tag(:span,"", class:"fa fa-vimeo")
#     end
#
#   end
#
# end
