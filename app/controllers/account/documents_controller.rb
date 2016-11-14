class Account::DocumentsController < ApplicationController
    before_action :authenticate_user!
    layout "user"


      def index
        @documents = Document.where(user_id: current_user)
      end




      def new
        @document = Document.new
      end


      def show
        @document = Document.find(params[:id])
      end


      # 建立
      def create
        @document = Document.new(docs_params)
        @document.user = current_user
        if @document.save
          redirect_to account_documents_path, notice: "文件已经上传!"
        else
          render :new
        end
      end

      def destroy
        @document = Document.find(params[:id])
        @document.destroy
        redirect_to :back
      end



      private

      # 问题参数
      def docs_params
        params.require(:document).permit(:description,{client_docs:[]})
      end






end
