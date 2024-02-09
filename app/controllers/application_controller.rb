class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    gym_classes_path
  end
end
