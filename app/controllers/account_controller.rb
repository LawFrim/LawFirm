class AccountController < ApplicationController

  before_action :authenticate_user!
  # f120
  before_action :get_mailbox

  layout "user"
  
end
