class LawyerController < ApplicationController
    before_action :authenticate_user!
    before_action :lawyer_required
    before_action :get_mailbox
    layout "lawyer"


end
