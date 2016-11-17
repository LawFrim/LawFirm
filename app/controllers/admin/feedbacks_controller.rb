class Admin::FeedbacksController < ApplicationController
  class Lawyer::FeedbacksController < ApplicationController

    before_action :authenticate_user!
    before_action :admin_required
    before_action :get_mailbox

    layout "admin"

    def index
      @feedbacks = Feedback.all

    end
    #
    # def new
    #   @feedback = Feedback.new
    # end
    #
    # def show
    #   @feedback = Feedback.find(params[:id])
    # end
    #
    # def create
    #   @document = Document.find(params[:document_id])
    #   @feedback = Feedback.new(feedback_params)
    #   @feedback.user = current_user
    #   @feedback.document = @document
    #   if @feedback.save
    #     redirect_to lawyer_document_feedbacks_path, notice: "合同已上传!"
    #   else
    #     render :new
    #   end
    # end

    private

    def feedback_params
      params.require(:feedback).permit(:description,{client_docs:[]}, :document_id)
    end



  end

end
