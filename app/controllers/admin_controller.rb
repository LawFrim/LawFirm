class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :get_mailbox
  layout "admin"
end
