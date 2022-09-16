class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_beginning_of_week

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_events_path
    else
        events_path
    end
  end

def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        about_path
    else
        admin_session_path
    end
end

  private
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :employee_id, :affiliation, :body])
  end
end
