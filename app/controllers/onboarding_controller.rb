class OnboardingController < ApplicationController
  def index
    render layout: 'onboarding'
  end

  def onboard_user
    current_user.onboard! unless current_user.onboarded?
    redirect_to tags_url
  end
end
