class OnboardingController < ApplicationController
  def index
    render layout: 'onboarding'
  end

  def onboard_user
    unless current_user.onboarded?
      current_user.onboard!
    end
    redirect_to tags_url
  end
end
