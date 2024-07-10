class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    payment_method_selection_path
  end
end