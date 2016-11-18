class Admin::DocumentsController < ApplicationController

      before_action :authenticate_user!
      before_action :admin_required
      before_action :get_mailbox

      layout "admin"

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



        # 建一个邮箱
        def get_mailbox
          @mailbox ||= current_user.mailbox
        end

end
