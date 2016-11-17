class Lawyer::FeedbacksController < ApplicationController

  before_action :authenticate_user!
  before_action :lawyer_required
  before_action :get_mailbox

  layout "lawyer"
  def index
    # @user = current_user
    @feedbacks = Feedback.all

  end

  def new
    @feedback = Feedback.new
  end


  def show
    @feedback = Feedback.find(params[:id])

  end
  def create
    # binding.pry
    @document = Document.find(params[:document_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user
    if @feedback.save!
      redirect_to lawyer_document_feedbacks_path, notice: "合同已上传!"
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:description,{client_docs:[]})
  end

  def document_params
    params.require(:document).permit(:description,{client_docs:[]})
  end

end
