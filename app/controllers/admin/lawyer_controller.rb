class Admin::LawyerController < ApplicationController
  before_action :lawyer_required
  before_action :authenticate_user!
  layout "lawyer"
end
