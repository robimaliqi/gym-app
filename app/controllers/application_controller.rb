class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    payment_method_selection_path
  end
end
