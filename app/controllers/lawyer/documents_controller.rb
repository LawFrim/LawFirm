class Lawyer::DocumentsController < ApplicationController

  before_action :authenticate_user!
  before_action :lawyer_required
  before_action :get_mailbox

  layout "lawyer"

  def index
    # @user = current_user
    @documents = Document.all
  end

  def new
    @document = Document.new
  end


  def show
    @document = Document.find(params[:id])
  end

  private

  def docs_params
    params.require(:document).permit(:description,{client_docs:[]})
  end

end
