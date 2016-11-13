module ApplicationHelper
  # 用于查询指定律师
  def conversation_manager(lawyer_id)
    lawyer = User.find(lawyer_id)
    return lawyer.email
  end

end
