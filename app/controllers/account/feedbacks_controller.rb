class Account::FeedbacksController < ApplicationController


  before_action :authenticate_user!
  before_action :get_mailbox

  layout "user"

  def index
    @feedbacks = Feedback.all
  end
end
